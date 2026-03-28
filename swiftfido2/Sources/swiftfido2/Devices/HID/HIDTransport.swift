//
//  HIDTransport.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/19/25.
//

@preconcurrency import Foundation
import IOKit

final class HIDTransport: @unchecked Sendable {
	let device: IOHIDDevice
	let reportLen: Int

	private let queue: DispatchQueue
	private let buffer: UnsafeMutablePointer<UInt8>
	private let stream: AsyncStream<Data>
	private let continuation: AsyncStream<Data>.Continuation

	init(device: IOHIDDevice, reportLen: Int) {
		self.device = device
		self.reportLen = reportLen
		self.queue = DispatchQueue(label: "fido.hid.transport")
		self.buffer = .allocate(capacity: reportLen)

		var cont: AsyncStream<Data>.Continuation!
		self.stream = AsyncStream { cont = $0 }
		self.continuation = cont

		// Register input report callback — will fire on our dispatch queue
		let opaquePtr = Unmanaged.passUnretained(self).toOpaque()
		IOHIDDeviceRegisterInputReportCallback(
			device,
			buffer,
			reportLen,
			{ context, result, sender, type, reportID, report, reportLength in
				guard let context, reportLength > 0 else { return }
				let transport = Unmanaged<HIDTransport>.fromOpaque(context)
					.takeUnretainedValue()
				let data = Data(bytes: report, count: reportLength)
				transport.continuation.yield(data)
			},
			opaquePtr
		)

		// Schedule on dispatch queue (not run loop)
		IOHIDDeviceSetDispatchQueue(device, queue)
		IOHIDDeviceActivate(device)
	}

	deinit {
		buffer.deallocate()
	}

	enum HIDError: Error {
		case timeout
		case disconnected
	}

	// MARK: - Send

	func sendReport(_ report: HIDReport) throws {
		let result = report.data.withUnsafeBytes { buf -> IOReturn in
			IOHIDDeviceSetReport(
				device,
				report.reportType,
				report.reportID,
				buf.bindMemory(to: UInt8.self).baseAddress!,
				buf.count
			)
		}
		guard result == kIOReturnSuccess else {
			throw CTAPHIDError.txError(result)
		}
	}

	func sendReportPackets(_ report: HIDPackageReport) throws {
		for frame in report.packets {
			let rpt = HIDReport(
				reportID: report.reportID,
				reportType: report.reportType,
				data: frame
			)
			try sendReport(rpt)
		}
	}

	// MARK: - Read

	func readAsync(timeoutMs: Int) async throws -> Data {
		try await withThrowingTaskGroup(of: Data.self) { group in
			group.addTask {
				for await data in self.stream {
					return data
				}
				throw HIDError.disconnected
			}
			group.addTask {
				try await Task.sleep(nanoseconds: UInt64(timeoutMs) * 1_000_000)
				throw HIDError.timeout
			}
			let result = try await group.next()!
			group.cancelAll()
			return result
		}
	}

	// MARK: - Cleanup

	func close() {
		IOHIDDeviceCancel(device)
		continuation.finish()
	}
}
