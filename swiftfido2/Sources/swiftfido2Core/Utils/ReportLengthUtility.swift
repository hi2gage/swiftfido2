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
	}

	static func getReportLength(device: IOHIDDevice, direction: Direction) throws -> Int {
		guard let result = IOHIDDeviceGetProperty(device, direction.key) as? NSNumber else {
			throw FidoError.device(.reportLengthUnavailable)
		}

		let length = Int(result.int32Value)
		guard length > 0, length <= maxReportLength else {
			throw FidoError.device(.reportLengthInvalid)
		}

		return length
	}

	private static let maxReportLength = 64
}
