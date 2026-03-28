import Foundation
import Testing

@testable import SwiftFido2

@Suite("CTAPHIDInitPayload")
struct CTAPHIDInitPayloadTests {

	@Test("parses valid 17-byte payload")
	func parseValidPayload() throws {
		// 8 bytes nonce + 4 bytes channel ID + 1 byte protocol version
		// + 3 bytes firmware + 1 byte flags = 17 bytes
		var payload = Data([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])  // nonce
		payload.append(contentsOf: [0x00, 0x00, 0x00, 0x42])  // channel ID = 0x42
		payload.append(0x02)  // protocol version
		payload.append(contentsOf: [0x05, 0x07, 0x01])  // firmware 5.7.1
		payload.append(0x05)  // flags: wink + cbor

		let result = try CTAPHIDInitPayload(payload: payload)

		#expect(result.nonce == Data([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08]))
		#expect(result.channelId == 0x42)
		#expect(result.protocolVersion == 0x02)
		#expect(result.firmware.major == 5)
		#expect(result.firmware.minor == 7)
		#expect(result.firmware.build == 1)
		#expect(result.flags.contains(.wink))
		#expect(result.flags.contains(.cbor))
		#expect(!result.flags.contains(.nmsg))
	}

	@Test("rejects payload shorter than 17 bytes")
	func rejectShortPayload() {
		let payload = Data(repeating: 0, count: 16)
		#expect(throws: (any Error).self) {
			try CTAPHIDInitPayload(payload: payload)
		}
	}

	@Test("validates nonce correctly")
	func nonceValidation() throws {
		var payload = Data([0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF, 0x11, 0x22])
		payload.append(Data(repeating: 0, count: 9))

		let result = try CTAPHIDInitPayload(payload: payload)

		// Matching nonce should not throw
		try result.assertValidNonce(
			Data([0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF, 0x11, 0x22])
		)

		// Mismatched nonce should throw
		#expect(throws: CTAPHIDError.self) {
			try result.assertValidNonce(Data(repeating: 0, count: 8))
		}
	}

	@Test("parses raw HID report with header")
	func parseRawReport() throws {
		// Simulate a real 64-byte HID report as the device would send it.
		// dropFirst() strips the reportID byte but preserves original indices.
		let nonce = Data([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])

		var report = Data(repeating: 0, count: 64)
		report[0] = 0x00  // reportID (stripped by dropFirst)
		// Channel ID at indices 1-3, command at index 4
		report[1] = 0xFF
		report[2] = 0xFF
		report[3] = 0xFF
		report[4] = 0x86  // INIT command (0x80 | 0x06)
		report[5] = 0x00
		report[6] = 0x11  // length = 17
		// 17-byte INIT payload starting at index 7
		for i in 0..<8 { report[7 + i] = nonce[i] }  // nonce
		report[15] = 0x0A
		report[16] = 0x0B
		report[17] = 0x0C
		report[18] = 0x0D  // channel ID
		report[19] = 0x02  // protocol version
		report[20] = 0x01
		report[21] = 0x02
		report[22] = 0x03  // firmware
		report[23] = 0x04  // flags: cbor

		let result = try CTAPHIDInitPayload(rawReport: report)
		#expect(result.nonce == nonce)
		#expect(result.channelId == 0x0A0B_0C0D)
		#expect(result.flags.contains(.cbor))
	}
}
