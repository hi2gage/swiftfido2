import Foundation
import Testing

@testable import swiftfido2Core

@Suite("Ctap2 Response Parsing")
struct AssertionResponseTests {

	@Test("parses valid GetAssertion CBOR response")
	func parseValidAssertionResponse() throws {
		// Build a minimal valid CBOR response:
		// Status byte 0x00 (success) followed by CBOR map:
		// {1: {"type": "public-key", "id": h'AABB'}, 2: h'authdata', 3: h'signature'}
		let cborBytes: [UInt8] = [
			0x00,  // status: success
			0xA3,  // map(3)
			0x01,  // key 1 (credential)
			0xA2,  // map(2)
			0x64, 0x74, 0x79, 0x70, 0x65,  // "type"
			0x6A, 0x70, 0x75, 0x62, 0x6C, 0x69, 0x63, 0x2D, 0x6B, 0x65, 0x79,  // "public-key"
			0x62, 0x69, 0x64,  // "id"
			0x42, 0xAA, 0xBB,  // bytes(2) AA BB
			0x02,  // key 2 (authData)
			0x45, 0x01, 0x02, 0x03, 0x04, 0x05,  // bytes(5)
			0x03,  // key 3 (signature)
			0x43, 0xDE, 0xAD, 0xBE,  // bytes(3)
		]

		let response = try swiftfido2Core.AssertionResponse(raw: Data(cborBytes))

		#expect(response.credentialId == Data([0xAA, 0xBB]))
		#expect(response.authData == Data([0x01, 0x02, 0x03, 0x04, 0x05]))
		#expect(response.signature == Data([0xDE, 0xAD, 0xBE]))
		#expect(response.userHandle == nil)
	}

	@Test("rejects non-success status")
	func rejectErrorStatus() {
		// Status byte 0x2E (no credentials) followed by empty CBOR
		let data = Data([0x2E, 0xA0])
		#expect(throws: Ctap2ResponseError.self) {
			try swiftfido2Core.AssertionResponse(raw: data)
		}
	}

	@Test("rejects empty data")
	func rejectEmptyData() {
		#expect(throws: Ctap2ResponseError.self) {
			try swiftfido2Core.AssertionResponse(raw: Data())
		}
	}
}
