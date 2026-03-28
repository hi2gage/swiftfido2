//
//  FidoDeviceDiscovery.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import IOKit

public enum FidoDeviceDiscovery {
	public static func discoverDevices() throws -> [UninitializedFidoDevice] {
		let manager = IOHIDManagerCreate(kCFAllocatorDefault, 0)

		IOHIDManagerSetDeviceMatching(manager, nil)
		IOHIDManagerOpen(manager, 0)

		guard let deviceSet = IOHIDManagerCopyDevices(manager) as? Set<IOHIDDevice> else {
			return []
		}

		return deviceSet.compactMap {
			try? UninitializedFidoDevice(from: $0)
		}
	}

	public static func open(_ device: UninitializedFidoDevice) throws
		-> UninitializedFidoContext
	{
		let hid = device.deviceRef

		let openResult = IOHIDDeviceOpen(hid, IOOptionBits(kIOHIDOptionsTypeSeizeDevice))
		guard openResult == kIOReturnSuccess else {
			throw FidoError.device(.failedToOpen)
		}

		// Create pipe
		var pipeFDs: [Int32] = [-1, -1]
		guard Darwin.pipe(&pipeFDs) == 0 else {
			throw FidoError.device(.failedToCreatePipe)
		}

		setNonBlocking(fd: pipeFDs[0])
		setNonBlocking(fd: pipeFDs[1])

		// Get report lengths
		let inputLen = try ReportLengthUtility.getReportLength(
			device: hid,
			direction: .inward
		)
		let outputLen = try ReportLengthUtility.getReportLength(
			device: hid,
			direction: .outward
		)

		let length = max(inputLen, outputLen)

		// Setup transport
		let transport = HIDTransport(
			device: hid,
			reportLen: length,
			bufferLength: inputLen,
			pipeFds: (read: pipeFDs[0], write: pipeFDs[1]),
		)

		let buffer = Buffer(
			bufferLength: length,
			pipeFds: (read: pipeFDs[0], write: pipeFDs[1])
		)

		var context = UninitializedFidoContext(
			device: device,
			transport: transport,
			buffer: buffer
		)

		device.deviceRef.setupHidCallbacks(context: &context)

		return context
	}

	static func setNonBlocking(fd: Int32) {
		let flags = fcntl(fd, F_GETFL, 0)
		if flags != -1 {
			_ = fcntl(fd, F_SETFL, flags | O_NONBLOCK)
		}
	}
}

extension IOHIDDevice {
	func setupHidCallbacks(context: inout UninitializedFidoContext) {

		IOHIDDeviceRegisterInputReportCallback(
			self,
			context.buffer.buffer,
			context.device.outputReportSize,
			inputReportCallback,
			Unmanaged.passUnretained(context.transport).toOpaque()
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

	let ctx = Unmanaged<HIDTransport>.fromOpaque(context).takeUnretainedValue()
	write(ctx.pipeFds.write, report, reportLength)
}
