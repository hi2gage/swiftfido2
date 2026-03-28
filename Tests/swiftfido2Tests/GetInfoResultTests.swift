import Foundation
import Testing

@testable import SwiftCBOR
@testable import SwiftFido2

@Suite("GetInfoResult CBOR Parsing")
struct GetInfoResultTests {

	@Test("parses valid GetInfo response")
	func parseValid() throws {
		let cbor = buildGetInfoCBOR(
			versions: ["FIDO_2_0", "FIDO_2_1"],
			extensions: ["hmac-secret", "credProtect"],
			aaguid: Data(repeating: 0x42, count: 16),
			options: ["rk": true, "clientPin": true, "uv": false],
			maxMsgSize: 1280,
			pinProtocols: [1, 2]
		)

		var raw = Data([0x00])  // status: success
		raw.append(cbor)

		let result = try GetInfoResult(raw: raw)

		#expect(result.versions == ["FIDO_2_0", "FIDO_2_1"])
		#expect(result.extensions == ["hmac-secret", "credProtect"])
		#expect(result.aaguid == Data(repeating: 0x42, count: 16))
		#expect(result.options["rk"] == true)
		#expect(result.options["clientPin"] == true)
		#expect(result.options["uv"] == false)
		#expect(result.maxMsgSize == 1280)
		#expect(result.pinProtocols == [1, 2])
	}

	@Test("parses minimal GetInfo (no optional fields)")
	func parseMinimal() throws {
		let cbor = buildGetInfoCBOR(
			versions: ["U2F_V2"],
			extensions: nil,
			aaguid: Data(repeating: 0x00, count: 16),
			options: nil,
			maxMsgSize: nil,
			pinProtocols: nil
		)

		var raw = Data([0x00])
		raw.append(cbor)

		let result = try GetInfoResult(raw: raw)

		#expect(result.versions == ["U2F_V2"])
		#expect(result.extensions == nil)
		#expect(result.options.isEmpty)
		#expect(result.maxMsgSize == nil)
		#expect(result.pinProtocols == nil)
	}

	@Test("rejects non-success status")
	func rejectError() {
		var raw = Data([0x11])  // some error status
		raw.append(Data([0xA0]))  // empty CBOR map
		#expect(throws: Ctap2ResponseError.self) {
			try GetInfoResult(raw: raw)
		}
	}

	@Test("DeviceInfo maps from GetInfoResult")
	func deviceInfoMapping() throws {
		let cbor = buildGetInfoCBOR(
			versions: ["FIDO_2_0"],
			extensions: ["credProtect"],
			aaguid: Data(repeating: 0xAA, count: 16),
			options: ["rk": true],
			maxMsgSize: 2048,
			pinProtocols: [1]
		)

		var raw = Data([0x00])
		raw.append(cbor)

		let result = try GetInfoResult(raw: raw)
		let info = DeviceInfo(from: result)

		#expect(info.versions == ["FIDO_2_0"])
		#expect(info.extensions == ["credProtect"])
		#expect(info.aaguid == Data(repeating: 0xAA, count: 16))
		#expect(info.options["rk"] == true)
		#expect(info.maxMsgSize == 2048)
		#expect(info.pinProtocols == [1])
	}

	// MARK: - Helpers

	private func buildGetInfoCBOR(
		versions: [String],
		extensions: [String]?,
		aaguid: Data,
		options: [String: Bool]?,
		maxMsgSize: UInt64?,
		pinProtocols: [UInt64]?
	) -> Data {
		var map: [CBOR: CBOR] = [:]

		// Key 1: versions (required)
		map[.unsignedInt(1)] = .array(versions.map { .utf8String($0) })

		// Key 2: extensions (optional)
		if let extensions {
			map[.unsignedInt(2)] = .array(extensions.map { .utf8String($0) })
		}

		// Key 3: aaguid (required)
		map[.unsignedInt(3)] = .byteString([UInt8](aaguid))

		// Key 4: options (optional)
		if let options {
			var optMap: [CBOR: CBOR] = [:]
			for (key, value) in options {
				optMap[.utf8String(key)] = .boolean(value)
			}
			map[.unsignedInt(4)] = .map(optMap)
		}

		// Key 5: maxMsgSize (optional)
		if let maxMsgSize {
			map[.unsignedInt(5)] = .unsignedInt(maxMsgSize)
		}

		// Key 6: pinProtocols (optional)
		if let pinProtocols {
			map[.unsignedInt(6)] = .array(pinProtocols.map { .unsignedInt($0) })
		}

		return Data(CBOR.map(map).encode())
	}
}
