//
//  CTAPHIDResponseReader.swift
//  swiftfido2
//
//  Created by Gage Halverson on 3/27/26.
//

import Foundation

/// Reassembles a multi-packet CTAPHID response (INIT + CONT frames) into a single payload.
enum CTAPHIDResponseReader {

	/// Reads a complete CTAPHID response from the transport, handling KEEPALIVE and
	/// reassembling continuation packets.
	///
	/// - Parameters:
	///   - transport: The HID transport to read from
	///   - channelId: The expected channel ID
	///   - timeoutMs: Timeout per individual read in milliseconds
	/// - Returns: The reassembled payload (status byte + CBOR data)
	static func readResponse(
		from transport: HIDTransport,
		channelId: UInt32,
		timeoutMs: Int = 5000
	) async throws -> Data {
		// Read packets until we get a non-KEEPALIVE INIT frame
		var initPacket: Data
		while true {
			initPacket = try await transport.readAsync(timeoutMs: timeoutMs)
			guard initPacket.count >= 7 else {
				throw CTAPHIDError.invalidResponseLength
			}

			let cmd = initPacket[4] & 0x7F
			if cmd == CTAPHIDSpec.Command.keepalive.rawValue {
				// Device is still processing (e.g. waiting for user touch)
				continue
			}
			break
		}

		// Parse INIT frame header
		// Bytes 0-3: channel ID
		// Byte 4: command (with high bit set)
		// Bytes 5-6: payload length (big endian)
		let respChannel = initPacket.withUnsafeBytes { buf in
			buf.load(as: UInt32.self).bigEndian
		}
		guard respChannel == channelId else {
			throw CTAPHIDError.malformedFrame(
				"Channel mismatch: expected \(channelId), got \(respChannel)"
			)
		}

		let cmd = initPacket[4]
		guard cmd & 0x80 != 0 else {
			throw CTAPHIDError.malformedFrame("Expected INIT frame (high bit set)")
		}

		let command = cmd & 0x7F
		if command == CTAPHIDSpec.Command.error.rawValue {
			let errorCode = initPacket.count > 7 ? initPacket[7] : 0xFF
			throw CTAPHIDError.malformedFrame(
				"Device error: 0x\(String(format: "%02X", errorCode))"
			)
		}

		let totalLength = Int(initPacket[5]) << 8 | Int(initPacket[6])

		// Collect payload from INIT frame (bytes 7 onward)
		var payload = Data(initPacket[7...])

		// Read continuation packets if needed
		var expectedSeq: UInt8 = 0
		while payload.count < totalLength {
			let contPacket = try await transport.readAsync(timeoutMs: timeoutMs)
			guard contPacket.count >= 5 else {
				throw CTAPHIDError.invalidResponseLength
			}

			// Verify channel ID matches on continuation packets
			let contChannel = contPacket.withUnsafeBytes { buf in
				buf.load(as: UInt32.self).bigEndian
			}
			guard contChannel == channelId else {
				throw CTAPHIDError.malformedFrame(
					"Continuation channel mismatch: expected \(channelId), got \(contChannel)"
				)
			}

			// Byte 4 is sequence number (no high bit set)
			let seq = contPacket[4]
			guard seq == expectedSeq else {
				throw CTAPHIDError.malformedFrame(
					"Sequence mismatch: expected \(expectedSeq), got \(seq)"
				)
			}

			payload.append(contentsOf: contPacket[5...])
			expectedSeq += 1
		}

		// Trim to exact length
		return Data(payload.prefix(totalLength))
	}
}
