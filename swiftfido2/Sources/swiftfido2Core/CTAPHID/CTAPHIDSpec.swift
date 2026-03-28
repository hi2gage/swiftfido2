//
//  CTAPHIDSpec.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

package enum CTAPHIDSpec {
	/// Broadcast channel used to initiate communication before channel assignment
	package static let broadcastChannelId: UInt32 = 0xffff_ffff

	/// Required nonce length for CTAPHID_INIT
	package static let nonceLength: Int = 8

	/// Maximum report length (typically 64 bytes for HID)
	package static let maxReportLength: Int = 64

	/// Command values (you may already have this elsewhere)
	package enum Command: UInt8 {
		case ping = 0x01
		case msg = 0x03
		case lock = 0x04
		case `init` = 0x06
		case cbor = 0x10
		case cancel = 0x11
		case error = 0x3f
		case keepalive = 0x3b
	}
}
