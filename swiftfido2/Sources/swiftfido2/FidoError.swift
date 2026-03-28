//
//  FidoError.swift
//  swiftfido2
//
//  Created by Gage Halverson on 3/27/26.
//

import Foundation

/// Errors that can occur during FIDO2 operations.
public enum FidoError: Error, LocalizedError {
	/// No FIDO device was found within the timeout period
	case deviceNotFound
	/// The device could not be opened (may be in use by another application)
	case deviceOpenFailed
	/// The operation timed out waiting for a response
	case timeout
	/// The device returned a CTAP2 error status
	case ctapError(status: UInt8)
	/// The device was disconnected during an operation
	case disconnected
	/// An internal protocol error occurred
	case protocolError(String)

	public var errorDescription: String? {
		switch self {
		case .deviceNotFound:
			return "No FIDO security key found. Please plug in your key and try again."
		case .deviceOpenFailed:
			return
				"Could not open the security key. It may be in use by another application."
		case .timeout:
			return "The security key did not respond in time."
		case .ctapError(let status):
			return
				"The security key returned an error (0x\(String(format: "%02X", status)))."
		case .disconnected:
			return "The security key was disconnected."
		case .protocolError(let message):
			return "Protocol error: \(message)"
		}
	}
}
