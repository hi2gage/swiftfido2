//
//  UninitializedFidoDevice.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import Foundation
import IOKit

/// Represents a raw HID device that hasn't been assigned a CTAPHID channel yet
public struct UninitializedFidoDevice: @unchecked Sendable {
	public let deviceRef: IOHIDDevice
	public let vendorId: UInt16
	public let productId: UInt16
	public let productName: String
	public let inputReportSize: Int
	public let outputReportSize: Int
}

extension UninitializedFidoDevice {
	init(from hidDevice: IOHIDDevice) throws {
		guard hidDevice.isFido else {
			throw FidoError.device(.notFidoCompliant)
		}

		guard Self.getPath(for: hidDevice) != nil else {
			throw FidoError.device(.invalidPath)
		}

		guard
			let vendorId = IOHIDDeviceGetProperty(
				hidDevice,
				kIOHIDVendorIDKey as CFString
			) as? UInt16,
			let productId = IOHIDDeviceGetProperty(
				hidDevice,
				kIOHIDProductIDKey as CFString
			) as? UInt16
		else {
			throw FidoError.device(.missingVendorOrProductId)
		}

		guard
			IOHIDDeviceGetProperty(hidDevice, kIOHIDManufacturerKey as CFString)
				as? String != nil,
			let productName = IOHIDDeviceGetProperty(
				hidDevice,
				kIOHIDProductKey as CFString
			) as? String
		else {
			throw FidoError.device(.missingMetadata)
		}

		let inputReportSize = try ReportLengthUtility.getReportLength(
			device: hidDevice,
			direction: .inward
		)
		let outputReportSize = try ReportLengthUtility.getReportLength(
			device: hidDevice,
			direction: .outward
		)

		self.deviceRef = hidDevice
		self.vendorId = vendorId
		self.productId = productId
		self.productName = productName
		self.inputReportSize = inputReportSize
		self.outputReportSize = outputReportSize
	}
}

extension UninitializedFidoDevice {
	private static func getPath(for device: IOHIDDevice) -> String? {
		let service = IOHIDDeviceGetService(device)
		var id: UInt64 = 0

		if service != MACH_PORT_NULL,
			IORegistryEntryGetRegistryEntryID(service, &id) == KERN_SUCCESS
		{
			return "ioreg://\(id)"
		} else {
			return nil
		}
	}
}
