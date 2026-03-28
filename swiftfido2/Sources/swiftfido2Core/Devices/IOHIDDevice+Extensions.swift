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

		// Ensure the transport is USB
		if transport.lowercased() != "usb" {
			return false
		}

		return primaryUsagePage == 0xF1D0
	}
}

extension IOHIDDevice {
	func sendReport(_ report: HIDReport) throws {
		let result = report.data.withUnsafeBytes { buffer in
			IOHIDDeviceSetReport(
				self,
				report.reportType,
				report.reportID,
				buffer.bindMemory(to: UInt8.self).baseAddress!,
				buffer.count
			)
		}

		guard result == kIOReturnSuccess else {
			throw CTAPHIDError.txError(result)
		}
	}
}

extension IOHIDDevice {
	/// Waits asynchronously for a matching input report with the expected CTAPHID command.
	///
	/// - Parameters:
	///   - expectedCommand: The CTAPHID command you expect in the response (e.g. `.init`, `.cbor`)
	///   - reportSize: The expected size of the input report buffer
	///   - timeoutMs: Timeout in milliseconds before failing with `.rxTimeout`
	/// - Returns: A `Data` value containing the raw HID report
	/// - Throws: `CTAPHIDError.rxTimeout` if the report is not received in time,
	///           or any custom decoding error you implement later.
	func receiveReport(
		expectedCommand: CTAPHIDSpec.Command,
		reportSize: Int,
		timeoutMs: Int
	) async throws -> CTAPHIDInitPayload? {
		return nil
	}
}

public enum CTAPHIDError: Error {
	case txError(IOReturn)
	case rxTimeout
	case invalidNonce
	case unexpectedCommand(expected: UInt8, actual: UInt8)
	case invalidResponseLength
	case malformedFrame(String)
}
