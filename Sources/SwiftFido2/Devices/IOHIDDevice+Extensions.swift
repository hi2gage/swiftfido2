//
//  IOHIDDevice+Extensions.swift
//  swiftfido2
//
//  Created by Gage Halverson on 10/23/24.
//

import IOKit.hid

extension IOHIDDevice {
	var isFido: Bool {
		let primaryUsagePage =
			IOHIDDeviceGetProperty(self, kIOHIDPrimaryUsagePageKey as CFString)
			as? UInt16
		guard let primaryUsagePage else { return false }

		let transportValue =
			IOHIDDeviceGetProperty(self, kIOHIDTransportKey as CFString) as? String
		guard let transport = transportValue else {
			return false
		}

		if transport.lowercased() != "usb" {
			return false
		}

		return primaryUsagePage == 0xF1D0
	}
}

enum CTAPHIDError: Error {
	case txError(IOReturn)
	case rxTimeout
	case invalidNonce
	case unexpectedCommand(expected: UInt8, actual: UInt8)
	case invalidResponseLength
	case malformedFrame(String)
}
