//
//  CTAPHIDInitPayload.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import Foundation

struct CTAPHIDInitPayload {
	struct FirmwareVersion {
		let major: UInt8
		let minor: UInt8
		let build: UInt8
	}

	struct CapabilityFlags: OptionSet {
		let rawValue: UInt8
		static let wink = CapabilityFlags(rawValue: 0x01)
		static let cbor = CapabilityFlags(rawValue: 0x04)
		static let nmsg = CapabilityFlags(rawValue: 0x08)
		// …future bits reserved
	}

	let nonce: Data
	let channelId: UInt32
	let protocolVersion: UInt8
	let firmware: FirmwareVersion
	let flags: CapabilityFlags

	init(payload: Data) throws {
		guard payload.count >= 17 else {
			throw FidoError.protocolError(.internalError)
		}
		nonce = payload[0..<8]
		channelId = payload[8..<12].withUnsafeBytes {
			$0.load(as: UInt32.self).bigEndian
		}
		protocolVersion = payload[12]
		firmware = FirmwareVersion(
			major: payload[13],
			minor: payload[14],
			build: payload[15]
		)
		flags = CapabilityFlags(rawValue: payload[16])
	}

	init(rawReport: Data) throws {
		// 1. Strip 1‑byte reportID
		let packet = rawReport.dropFirst()

		// 2. Parse header & length
		guard packet.count >= 7 else {
			throw FidoError.protocolError(.tooShort)
		}

		let cmdByte = packet[4]
		guard cmdByte & 0x80 != 0,
			(cmdByte & 0x7F) == CTAPHIDSpec.Command.`init`.rawValue
		else {
			throw FidoError.protocolError(.invalidCommand)
		}

		let length = Int(packet[5]) << 8 | Int(packet[6])
		guard packet.count >= 7 + length, length >= 17 else {
			throw FidoError.protocolError(.lengthMismatch)
		}

		// 3. Extract and parse the 17‑byte payload
		let payload = packet[7..<7 + 17]
		try self.init(payload: Data(payload))
	}
}

extension CTAPHIDInitPayload {
	func assertValidNonce(_ expected: Data) throws {
		guard self.nonce == expected else {
			throw CTAPHIDError.invalidNonce
		}
	}
}
