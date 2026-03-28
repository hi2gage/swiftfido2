import Foundation
import SwiftCBOR
import Testing

@testable import SwiftFido2

@Suite("AssertionRequest CBOR Encoding")
struct AssertionRequestTests {

	@Test("encodes rpId and clientDataHash")
	func basicEncoding() throws {
		let hash = Data(repeating: 0xAA, count: 32)
		let request = AssertionRequest(
			rpId: "apple.com",
			clientDataHash: hash
		)

		let cbor = try request.toCBOR()
		let map = try decodeCBORMap(cbor)

		// Key 1: rpId
		#expect(map.keys.contains(1))
		// Key 2: clientDataHash
		#expect(map.keys.contains(2))
		// Key 5: options (up: true by default)
		#expect(map.keys.contains(5))
	}

	@Test("encodes allowCredentials when provided")
	func withAllowCredentials() throws {
		let request = AssertionRequest(
			rpId: "example.com",
			clientDataHash: Data(repeating: 0, count: 32),
			allowCredentials: [
				CredentialDescriptor(id: Data([0x01, 0x02, 0x03])),
				CredentialDescriptor(id: Data([0x04, 0x05, 0x06])),
			]
		)

		let cbor = try request.toCBOR()
		let map = try decodeCBORMap(cbor)

		#expect(map.keys.contains(3))
	}

	@Test("omits allowCredentials when empty")
	func withoutAllowCredentials() throws {
		let request = AssertionRequest(
			rpId: "example.com",
			clientDataHash: Data(repeating: 0, count: 32)
		)

		let cbor = try request.toCBOR()
		let map = try decodeCBORMap(cbor)

		#expect(!map.keys.contains(3))
	}

	@Test("full round-trip CBOR encode and decode")
	func roundTrip() throws {
		let request = AssertionRequest(
			rpId: "webauthn.io",
			clientDataHash: Data(repeating: 0xBB, count: 32),
			allowCredentials: [
				CredentialDescriptor(id: Data([0xDE, 0xAD, 0xBE, 0xEF]))
			],
			userPresence: true,
			userVerification: true
		)

		let cbor = try request.toCBOR()
		guard let decoded = try CBOR.decode([UInt8](cbor)),
			case .map(let map) = decoded
		else {
			Issue.record("CBOR should decode to a map")
			return
		}

		// rpId
		if case .utf8String(let rpId) = map[.unsignedInt(1)] {
			#expect(rpId == "webauthn.io")
		} else {
			Issue.record("rpId should be a string")
		}

		// clientDataHash is 32 bytes
		if case .byteString(let hash) = map[.unsignedInt(2)] {
			#expect(hash.count == 32)
		} else {
			Issue.record("clientDataHash should be bytes")
		}

		// allowCredentials present
		#expect(map[.unsignedInt(3)] != nil)

		// options present (up + uv)
		#expect(map[.unsignedInt(5)] != nil)
	}

	// MARK: - Helpers

	private func decodeCBORMap(_ data: Data) throws -> [UInt64: CBOR] {
		guard let decoded = try CBOR.decode([UInt8](data)),
			case .map(let map) = decoded
		else {
			throw TestError.invalidCBOR
		}

		var result: [UInt64: CBOR] = [:]
		for (key, value) in map {
			if case .unsignedInt(let k) = key {
				result[k] = value
			}
		}
		return result
	}

	enum TestError: Error {
		case invalidCBOR
	}
}
