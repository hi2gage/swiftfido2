//
//  FidoDeviceHandle.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import Foundation
import IOKit.hid

package struct FidoDeviceHandle: Hashable, @unchecked Sendable {
	package let deviceRef: IOHIDDevice
	package let vendorId: UInt16
	package let productId: UInt16
	package let inputReportSize: Int
	package let outputReportSize: Int
	package var channelId: UInt32

	package init(from device: UninitializedFidoDevice, channelId: UInt32) {
		self.deviceRef = device.deviceRef
		self.vendorId = device.vendorId
		self.productId = device.productId
		self.inputReportSize = device.inputReportSize
		self.outputReportSize = device.outputReportSize
		self.channelId = channelId
	}

	package var description: String {
		KnownVendors(rawValue: vendorId)?.products
			.first(where: { $0.productId == productId })?
			.name ?? "Unknown FIDO Device"
	}
}
