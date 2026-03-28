//
//  CTAPHIDFramer.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import Foundation

package enum CTAPHIDFramer {
	static func buildInitialFrame(
		channelId: UInt32,
		nonce: Data,
		reportSize: Int
	) -> CTAPHIDFrame {
		var d = Data()
		d.append(contentsOf: withUnsafeBytes(of: channelId.bigEndian, Array.init))
		d.append(0x80 | CTAPHIDSpec.Command.`init`.rawValue)  // INIT with high‑bit
		d.append(UInt8((nonce.count >> CTAPHIDSpec.nonceLength) & 0xff))
		d.append(UInt8(nonce.count & 0xff))
		d.append(nonce)
		let cappedSize = min(reportSize, CTAPHIDSpec.maxReportLength)
		d.append(contentsOf: repeatElement(0, count: cappedSize - d.count))
		return CTAPHIDFrame(channelId: channelId, command: .`init`, data: d)
	}
}
