//
//  CTAPHIDCborFrame.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/26/25.
//

import Foundation

struct CTAPHIDCborFrame {
	static let reportSize = 64

	let channelId: UInt32
	let command: UInt8  // e.g. CTAP2Command.getAssertion.rawValue
	let payload: Data

	/// All the HID‑report payloads you must send, in order.
	var packets: [Data] {
		var frames: [Data] = []

		// ------- initial packet -------
		var initHeader = Data()
		initHeader.append(contentsOf: withUnsafeBytes(of: channelId.bigEndian, Array.init))
		initHeader.append(0x80 | command)  // high‑bit set → INIT packet
		initHeader.append(UInt8((payload.count >> 8) & 0xff))  // length hi
		initHeader.append(UInt8(payload.count & 0xff))  // length lo

		let firstChunkSize = Self.reportSize - initHeader.count
		let firstChunk = payload.prefix(firstChunkSize)

		var firstPacket = initHeader
		firstPacket.append(firstChunk)
		firstPacket.append(
			contentsOf: repeatElement(0, count: Self.reportSize - firstPacket.count)
		)
		frames.append(firstPacket)

		// ------- continuation packets -------
		var seq: UInt8 = 0
		var offset = firstChunkSize
		while offset < payload.count {
			var contHeader = Data()
			contHeader.append(
				contentsOf: withUnsafeBytes(of: channelId.bigEndian, Array.init)
			)
			contHeader.append(seq)  // sequence number

			let chunkSize = min(
				Self.reportSize - contHeader.count,
				payload.count - offset
			)
			contHeader.append(payload[offset..<offset + chunkSize])
			contHeader.append(
				contentsOf: repeatElement(
					0,
					count: Self.reportSize - contHeader.count
				)
			)

			frames.append(contHeader)
			offset += chunkSize
			seq += 1
		}

		return frames
	}
}
