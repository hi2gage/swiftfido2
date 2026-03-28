//
//  CTAPHIDFrame.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import Foundation

struct CTAPHIDFrame {
	let channelId: UInt32
	let command: CTAPHIDSpec.Command
	let data: Data
}

extension CTAPHIDFrame {
	func asHIDReport() -> HIDReport {
		HIDReport(reportID: 0, reportType: kIOHIDReportTypeOutput, data: self.data)
	}
}
