//
//  HIDPackageReport.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/26/25.
//

import Foundation
import IOKit

struct HIDPackageReport {
	let reportID: CFIndex
	let reportType: IOHIDReportType
	let packets: [Data]
}

extension HIDPackageReport {
	init(
		_ hidFrame: CTAPHIDCborFrame,
		reportID: CFIndex = 0,
		reportType: IOHIDReportType = kIOHIDReportTypeOutput
	) {
		self.reportID = reportID
		self.reportType = reportType
		self.packets = hidFrame.packets
	}
}
