import CryptoKit
import Foundation
//
//  Fido2Manager.swift
//  swiftfido2
//
//  Created by Gage Halverson on 10/23/24.
//
import IOKit.hid
import SwiftCBOR

// MARK: Find Device:

extension Fido2Manager {
	func fidoHidDevices(max: Int) throws -> [FidoDeviceInfo] {
		let manager: IOHIDManager = IOHIDManagerCreate(kCFAllocatorDefault, 0)

		IOHIDManagerSetDeviceMatching(manager, nil)
		if let deviceSet = IOHIDManagerCopyDevices(manager) as? Set<IOHIDDevice>,
			!deviceSet.isEmpty
		{
			return deviceSet.prefix(max).compactMap { FidoDeviceInfo(from: $0) }
		} else {
			throw FidoError.noDevicesFound
		}
	}
}

extension Fido2Manager {
	/// Polls for a FIDO/U2F key to be plugged in, printing a one‑time prompt if none is present.
	///
	/// - Parameters:
	///   - maxDevices: how many devices `fidoHidDevices(max:)` will return
	///   - pollInterval: how long (in seconds) to wait between tries
	///   - prompt: the one‑time message to show if no key is present
	/// - Returns: the first FidoDeviceInfo found
	/// - Throws: any error from `fidoHidDevices(max:)`, except `noDevicesFound` is simply retried
	func waitForDevice(
		maxDevices: Int = 12,
		pollInterval: TimeInterval = 1.0,
		prompt: String = "🔍 No FIDO/U2F key detected. Please plug one in…"
	) throws -> [FidoDeviceInfo] {
		var didPrintPrompt = false

		while true {
			do {
				let list = try fidoHidDevices(max: maxDevices)
				if list.count > 0 {
					return list
				}
				// if we get an empty array rather than throwing
			} catch FidoError.noDevicesFound {
				// swallow and retry
			}

			if !didPrintPrompt {
				print(prompt)
				didPrintPrompt = true
			}

			Thread.sleep(forTimeInterval: pollInterval)
		}
	}
}

public class Fido2Manager {
	func open(withHidDevice deviceInfo: FidoDeviceInfo) throws -> FidoDeviceContext {
		let device = deviceInfo.hidDevice

		// Open the device first to ensure it's usable
		let openResult = IOHIDDeviceOpen(device, IOOptionBits(kIOHIDOptionsTypeSeizeDevice))
		guard openResult == kIOReturnSuccess else {
			throw FidoError.failedToOpenDevice
		}

		// Create non-blocking pipe
		var pipeFD: [Int32] = [-1, -1]
		guard Darwin.pipe(&pipeFD) == 0 else {
			throw FidoError.failedToCreatePipe
		}

		setNonBlocking(fd: pipeFD[0])
		setNonBlocking(fd: pipeFD[1])

		print("🛠️ Pipe FDs — read end: \(pipeFD[0]), write end: \(pipeFD[1])")

		// Get input/output report sizes
		let inLen = try ReportLengthUtility.getReportLength(
			device: device,
			direction: .inward
		)
		let outLen = try ReportLengthUtility.getReportLength(
			device: device,
			direction: .outward
		)

		// 4) make & install your HIDContext
		let hidCtx = HIDContext(
			bufferLength: inLen,
			sharedPipe: pipeFD
		)

		// 5) build the transport helper
		let transport = HIDTransport(
			device: device,
			pipeFds: (read: pipeFD[0], write: pipeFD[1]),
			reportLen: inLen
		)

		// Setup callbacks
		var context = FidoDeviceContext(
			device: device,
			hidContext: hidCtx,
			transport: transport,
			reportOutLen: outLen,
			channelId: nil
		)

		device.setupHidCallbacks(context: &context)

		//        setupHidCallbacks(device: device, context: &context)

		return context
	}

	func setNonBlocking(fd: Int32) {
		var flags = fcntl(fd, F_GETFL, 0)
		if flags != -1 {
			fcntl(fd, F_SETFL, flags | O_NONBLOCK)
		}
	}

	func close(
		withHidDevice deviceInfo: FidoDeviceInfo,
		context: inout FidoDeviceContext
	) throws {
		let device = deviceInfo.hidDevice

		//        guard var reportData = context.reportInData else {
		//            throw FidoError.failedToFindReport
		//        }
		//
		//        // Ensure reportData is large enough to match the expected report length.
		//        guard reportData.count >= context.reportInLen else {
		//            throw FidoError.failedToFindReport
		//        }

		if let hidCtx = context.hidContext {
			IOHIDDeviceRegisterInputReportCallback(
				device,
				hidCtx.buffer,
				hidCtx.bufferLength,
				nil,
				nil
			)
		}

		// Deregister removal callback
		IOHIDDeviceRegisterRemovalCallback(device, nil, nil)

		// Close the HID device
		let closeResult = IOHIDDeviceClose(
			device,
			IOOptionBits(kIOHIDOptionsTypeSeizeDevice)
		)
		if closeResult != kIOReturnSuccess {
			print("Failed to close HID device with error: \(closeResult)")
		}

		// — 4) drop the HIDContext (this will deallocate its buffer *and* close its pipe FDs)
		context.hidContext = nil

		// — 5) clear out any other credentials
		context.channelId = nil
	}

	// Read and reassemble a full CBOR payload (INIT + CONT frames) asynchronously.
	func readData(
		from deviceInfo: FidoDeviceInfo,
		context: FidoDeviceContext,
		timeout: Int = 10_000
	) async throws -> Data {
		let deadline = Date().addingTimeInterval(Double(timeout) / 1000)
		var assembled = Data()
		var expectedLength: Int?
		var cid: Data?

		while Date() < deadline {
			// Instead of manually scheduling the run‑loop and calling `read`,
			// we just `await` our async wrapper.

			let raw = try await context.transport.readAsync(timeoutMs: timeout)

			print("📥 Received data: \(raw.hex)")

			guard raw.count >= 7 else {
				print("⚠️ Packet too short, skipping")
				continue
			}

			// parse the CTAPHID packet in‑place (no dropFirst!)
			let packetCID = raw[0..<4]
			let cmdByte = raw[4]
			let isInit = (cmdByte & 0x80) != 0
			let cmd = cmdByte & 0x7F

			// remember which channel we’re on
			if cid == nil {
				cid = packetCID
			} else if cid! != packetCID {
				print("⚠️ CID mismatch, skipping packet")
				continue
			}

			if !isInit {
				// CONT frames
				guard let total = expectedLength else {
					print("⚠️ Continuation before INIT – skipping")
					continue
				}
				let chunk = raw.dropFirst(5).prefix(total - assembled.count)
				assembled.append(contentsOf: chunk)
				print("➕ CONT frame appended: \(assembled.count)/\(total)")

				if assembled.count == total {
					print("✅ Full CBOR payload received (\(total) bytes)")
					return assembled
				}
			} else {
				// INIT frames: only CBOR commands matter here
				switch cmd {
				case 0x10:  // CTAPHID_CBOR
					let len = Int(raw[5]) << 8 | Int(raw[6])
					expectedLength = len
					assembled = Data(raw.dropFirst(7).prefix(len))
					print("📦 CBOR INIT frame: expected total \(len) bytes")
					if assembled.count == len {
						print("✅ Full CBOR payload received (\(len) bytes)")
						return assembled
					}
				case 0x3B:  // KEEPALIVE
					let status = raw[7]
					print(
						"⏳ KEEPALIVE: \(status == 1 ? "Processing" : "Touch Required")"
					)
				default:
					print(
						"⚠️ Unexpected CTAPHID_INIT cmd: 0x\(String(cmd, radix: 16))"
					)
				}
			}
		}

		throw FidoError.readTimedOut
	}

	func waitForAssertionResponse(
		device: FidoDeviceInfo,
		context: FidoDeviceContext,
		timeout: Int = 10_000
	) async throws -> GetAssertionResponse {
		let cborPayload = try await readData(
			from: device,
			context: context,
			timeout: timeout
		)
		return try GetAssertionResponse(from: Ctap2Response(raw: cborPayload))
	}
}

extension IOHIDDevice {
	func setupHidCallbacks(context: inout FidoDeviceContext) {
		guard let hidCtx = context.hidContext else { return }

		IOHIDDeviceRegisterInputReportCallback(
			self,
			hidCtx.buffer,
			hidCtx.bufferLength,
			inputReportCallback,
			Unmanaged.passUnretained(hidCtx).toOpaque()
		)

		// 3) Register removal callback if you want to know when the device vanishes.
		IOHIDDeviceRegisterRemovalCallback(
			self,
			{ contextPointer, result, sender in
				// you can tear down here if you like
			},
			nil
		)

		// 4) Finally schedule the device into the run‑loop so your callback can fire.
		IOHIDDeviceScheduleWithRunLoop(
			self,
			CFRunLoopGetCurrent(),
			CFRunLoopMode.defaultMode.rawValue
		)
	}
}

struct AssertionCBOR {
	let authData: Data
	let signature: Data
	let userHandle: Data?
	let credentialId: Data
}

struct CtapHidResponse {
	let channelId: UInt32
	let command: UInt8
	let payload: Data
}

func inputReportCallback(
	context: UnsafeMutableRawPointer?,
	result: IOReturn,
	sender: UnsafeMutableRawPointer?,
	type: IOHIDReportType,
	reportID: UInt32,
	report: UnsafeMutablePointer<UInt8>,
	reportLength: CFIndex
) {
	guard let context = context, reportLength > 0 else { return }

	let ctx = Unmanaged<HIDContext>.fromOpaque(context).takeUnretainedValue()
	write(ctx.pipe[1], report, reportLength)
}

final class HIDContext {
	let buffer: UnsafeMutablePointer<UInt8>
	let bufferLength: Int
	let pipe: [Int32]  // [readFD, writeFD]

	init(bufferLength: Int, sharedPipe: [Int32]) {
		self.bufferLength = bufferLength
		self.buffer = .allocate(capacity: bufferLength)
		self.pipe = sharedPipe
	}

	deinit {
		buffer.deallocate()
		close(pipe[0])
		close(pipe[1])
	}
}

struct FidoDeviceContext {
	/// your raw IOHIDDevice
	let device: IOHIDDevice

	/// the helper that owns the CFRunLoop buffer + pipe FDs
	var hidContext: HIDContext?

	/// the transport you’ll use to read/write HID packets
	let transport: HIDTransport

	/// the max output length (for writing CTAP frames)
	let reportOutLen: Int

	/// once you’ve done your INIT, you’ll set this
	var channelId: UInt32?
}

@discardableResult
func setNonBlocking(fd: Int32) -> Bool {
	let flags = fcntl(fd, F_GETFL)
	if flags == -1 { return false }
	return fcntl(fd, F_SETFL, flags | O_NONBLOCK) != -1
}
