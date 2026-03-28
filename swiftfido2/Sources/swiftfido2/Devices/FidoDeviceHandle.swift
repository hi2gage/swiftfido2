//
//  FidoDeviceHandle.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import Foundation
import IOKit.hid

public struct FidoDeviceHandle: Hashable, @unchecked Sendable {
	public let deviceRef: IOHIDDevice
	public let vendorId: UInt16
	public let productId: UInt16
	public let inputReportSize: Int
	public let outputReportSize: Int
	public var channelId: UInt32

	public init(from device: UninitializedFidoDevice, channelId: UInt32) {
		self.deviceRef = device.deviceRef
		self.vendorId = device.vendorId
		self.productId = device.productId
		self.inputReportSize = device.inputReportSize
		self.outputReportSize = device.outputReportSize
		self.channelId = channelId
	}

	public var description: String {
		KnownVendors(rawValue: vendorId)?.products
			.first(where: { $0.productId == productId })?
			.name ?? "Unknown FIDO Device"
	}
}
