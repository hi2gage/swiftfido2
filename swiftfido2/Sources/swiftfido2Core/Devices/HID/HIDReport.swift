//
//  HIDReport.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import Foundation
import IOKit

struct HIDReport {
	let reportID: CFIndex
	let reportType: IOHIDReportType
	let data: Data
}
