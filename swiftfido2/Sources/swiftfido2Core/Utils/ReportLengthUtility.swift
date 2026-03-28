//
//  ReportLengthUtility.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/19/25.
//
import Foundation

struct ReportLengthUtility {
	enum Direction {
		case inward, outward

		var key: CFString {
			switch self {
			case .inward: return kIOHIDMaxInputReportSizeKey as CFString
			case .outward: return kIOHIDMaxOutputReportSizeKey as CFString
			}
		}

		var label: String {
			switch self {
			case .inward: return "Input Report"
			case .outward: return "Output Report"
			}
		}
	}
	// Utility to get report length
	static func getReportLength(device: IOHIDDevice, direction: Direction) throws -> Int {

		// Use a utility function to get the report length
		let reportLength = try getInt32(device: device, key: direction.key)
		if reportLength < 0 {
			print("\(direction.label): Failed to retrieve report length")
			throw ReportLengthError.failedToGetReportLength
		}

		// Check for valid report length
		guard reportLength <= CTAP_MAX_REPORT_LEN else {
			print(
				"\(direction.label): report length \(reportLength) exceeds maximum allowed"
			)
			throw ReportLengthError.invalidReportLength
		}

		return Int(reportLength)
	}

	// Utility function to retrieve an integer value from the HID device
	static func getInt32(device: IOHIDDevice, key: CFString) throws -> Int32 {
		guard let result = IOHIDDeviceGetProperty(device, key) as? NSNumber else {
			throw ReportLengthError.propertyRetrievalFailed
		}
		return result.int32Value  // Success, return the value
	}

	static private let CTAP_MAX_REPORT_LEN: Int = 64
}

enum ReportLengthError: Error {
	case failedToGetReportLength
	case invalidReportLength
	case propertyRetrievalFailed

}
