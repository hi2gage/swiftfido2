//
//  FidoDevice.swift
//  swiftfido2
//
//  Created by Gage Halverson on 3/27/26.
//

import Foundation

/// An opaque handle representing a connected FIDO2 hardware security key.
public struct FidoDevice: Sendable {
	/// Human-readable device name (e.g. "YubiKey OTP+FIDO+CCID")
	public let name: String
	/// USB vendor ID
	public let vendorId: UInt16
	/// USB product ID
	public let productId: UInt16

	let raw: UninitializedFidoDevice

	init(raw: UninitializedFidoDevice) {
		self.raw = raw
		self.vendorId = raw.vendorId
		self.productId = raw.productId
		self.name = raw.productName
	}
}
