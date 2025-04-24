//
//  ReportLengthUtility.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/19/25.
//
import Foundation

struct ReportLengthUtility {
  enum Direction {
    case inward
    case outward
  }
  // Utility to get report length
  static func getReportLength(device: IOHIDDevice, direction: Direction) throws -> Int {
    let key: CFString
    let reportKey: String

    switch direction {
    case .inward:
      key = kIOHIDMaxInputReportSizeKey as CFString
      reportKey = "Input Report"
    case .outward:
      key = kIOHIDMaxOutputReportSizeKey as CFString
      reportKey = "Output Report"
    }

    // Use a utility function to get the report length
    let reportLength = try getInt32(device: device, key: key)
    if reportLength < 0 {
      print("\(reportKey): Failed to retrieve report length")
      throw FidoError.failedToGetReportLength
    }

    // Check for valid report length
    guard reportLength <= CTAP_MAX_REPORT_LEN else {
      print("\(reportKey): report length \(reportLength) exceeds maximum allowed")
      throw FidoError.invalidReportLength
    }

    return Int(reportLength)
  }

  // Utility function to retrieve an integer value from the HID device
  static func getInt32(device: IOHIDDevice, key: CFString) throws -> Int32 {
    guard let result = IOHIDDeviceGetProperty(device, key) as? NSNumber else {
      throw FidoError.propertyRetrievalFailed
    }
    return result.int32Value  // Success, return the value
  }

  static private let CTAP_MAX_REPORT_LEN: Int = 64
}
