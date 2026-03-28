//
//  FidoError.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import Foundation

/// Errors that can occur during FIDO2 operations.
public enum FidoError: Error, LocalizedError {
	// Device errors
	case deviceNotFound
	case deviceOpenFailed
	case notFidoCompliant
	case invalidPath
	case missingVendorOrProductId
	case missingMetadata
	case reportLengthUnavailable
	case reportLengthInvalid

	// Protocol errors
	case timeout
	case disconnected
	case tooShort
	case invalidCommand
	case lengthMismatch
	case ctapError(status: UInt8)
	case protocolError(String)

	public var errorDescription: String? {
		switch self {
		case .deviceNotFound:
			return "No FIDO security key found. Please plug in your key and try again."
		case .deviceOpenFailed:
			return
				"Could not open the security key. It may be in use by another application."
		case .notFidoCompliant:
			return "The device is not a FIDO-compliant security key."
		case .invalidPath:
			return "Could not determine the device path."
		case .missingVendorOrProductId:
			return "The device is missing vendor or product identification."
		case .missingMetadata:
			return "The device is missing required metadata."
		case .reportLengthUnavailable:
			return "Could not determine the HID report length."
		case .reportLengthInvalid:
			return "The HID report length is invalid."
		case .timeout:
			return "The security key did not respond in time."
		case .disconnected:
			return "The security key was disconnected."
		case .tooShort:
			return "The response from the security key was too short."
		case .invalidCommand:
			return "Received an unexpected command from the security key."
		case .lengthMismatch:
			return "The response length did not match the expected length."
		case .ctapError(let status):
			return
				"The security key returned an error (0x\(String(format: "%02X", status)))."
		case .protocolError(let message):
			return "Protocol error: \(message)"
		}
	}
}
