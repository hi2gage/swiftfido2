import Foundation
import SwiftCBOR
import Testing

@testable import SwiftFido2

@Suite("CTAPHIDSpec")
struct CTAPHIDSpecTests {

	@Test("broadcast channel ID is correct")
	func broadcastChannel() {
		#expect(CTAPHIDSpec.broadcastChannelId == 0xFFFF_FFFF)
	}

	@Test("nonce length is 8 bytes")
	func nonceLength() {
		#expect(CTAPHIDSpec.nonceLength == 8)
	}

	@Test("max report length is 64 bytes")
	func maxReportLength() {
		#expect(CTAPHIDSpec.maxReportLength == 64)
	}

	@Test("command raw values match CTAPHID spec")
	func commandValues() {
		#expect(CTAPHIDSpec.Command.ping.rawValue == 0x01)
		#expect(CTAPHIDSpec.Command.msg.rawValue == 0x03)
		#expect(CTAPHIDSpec.Command.lock.rawValue == 0x04)
		#expect(CTAPHIDSpec.Command.`init`.rawValue == 0x06)
		#expect(CTAPHIDSpec.Command.cbor.rawValue == 0x10)
		#expect(CTAPHIDSpec.Command.cancel.rawValue == 0x11)
		#expect(CTAPHIDSpec.Command.error.rawValue == 0x3F)
		#expect(CTAPHIDSpec.Command.keepalive.rawValue == 0x3B)
	}
}

@Suite("NonceGenerator")
struct NonceGeneratorTests {

	@Test("generates requested number of bytes")
	func correctLength() {
		let nonce = NonceGenerator.randomBytes(count: 8)
		#expect(nonce.count == 8)

		let larger = NonceGenerator.randomBytes(count: 32)
		#expect(larger.count == 32)
	}

	@Test("generates different values each time")
	func uniqueness() {
		let a = NonceGenerator.randomBytes(count: 16)
		let b = NonceGenerator.randomBytes(count: 16)
		#expect(a != b)
	}
}

@Suite("FidoError")
struct FidoErrorTests {

	@Test("all error cases have descriptions")
	func allCasesHaveDescriptions() {
		let errors: [FidoError] = [
			.deviceNotFound,
			.deviceOpenFailed,
			.notFidoCompliant,
			.invalidPath,
			.missingVendorOrProductId,
			.missingMetadata,
			.reportLengthUnavailable,
			.reportLengthInvalid,
			.timeout,
			.disconnected,
			.tooShort,
			.invalidCommand,
			.lengthMismatch,
			.ctapError(status: 0x2E),
			.protocolError("test"),
		]

		for error in errors {
			let desc = error.errorDescription
			#expect(desc != nil)
			#expect(!desc!.isEmpty)
		}
	}

	@Test("ctapError includes hex status code")
	func ctapErrorFormat() {
		let error = FidoError.ctapError(status: 0x2E)
		#expect(error.errorDescription?.contains("2E") == true)
	}

	@Test("protocolError includes message")
	func protocolErrorMessage() {
		let error = FidoError.protocolError("something broke")
		#expect(error.errorDescription?.contains("something broke") == true)
	}
}

@Suite("DeviceInfo")
struct DeviceInfoTests {

	@Test("extensions defaults to empty array when nil")
	func extensionsDefault() throws {
		// Build a minimal GetInfo CBOR with no extensions
		var map: [CBOR: CBOR] = [:]
		map[.unsignedInt(1)] = .array([.utf8String("FIDO_2_0")])
		map[.unsignedInt(3)] = .byteString([UInt8](Data(repeating: 0, count: 16)))
		let cbor = Data(CBOR.map(map).encode())

		var raw = Data([0x00])
		raw.append(cbor)

		let result = try GetInfoResult(raw: raw)
		let info = DeviceInfo(from: result)

		#expect(info.extensions.isEmpty)
		#expect(info.maxMsgSize == nil)
		#expect(info.pinProtocols == nil)
	}
}
