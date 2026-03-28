//
//  FidoDeviceDiscovery.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import IOKit

package enum FidoDeviceDiscovery {
	package static func discoverDevices() throws -> [UninitializedFidoDevice] {
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

	package static func open(_ device: UninitializedFidoDevice) throws
		-> UninitializedFidoContext
	{
		let hid = device.deviceRef

		let openResult = IOHIDDeviceOpen(hid, IOOptionBits(kIOHIDOptionsTypeSeizeDevice))
		guard openResult == kIOReturnSuccess else {
			throw FidoError.device(.failedToOpen)
		}

		let reportLen = max(device.inputReportSize, device.outputReportSize)

		let transport = HIDTransport(
			device: hid,
			reportLen: reportLen
		)

		return UninitializedFidoContext(
			device: device,
			transport: transport
		)
	}
}
