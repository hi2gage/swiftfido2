import Foundation
import Testing

@testable import SwiftFido2

@Suite("FidoClient Public API")
struct FidoClientTests {

	@Test("AssertionRequest initializes with defaults")
	func assertionRequestDefaults() {
		let hash = Data(repeating: 0xAA, count: 32)
		let request = AssertionRequest(
			rpId: "apple.com",
			clientDataHash: hash
		)

		#expect(request.rpId == "apple.com")
		#expect(request.clientDataHash == hash)
		#expect(request.allowCredentials.isEmpty)
		#expect(request.userPresence == true)
		#expect(request.userVerification == false)
	}

	@Test("AssertionRequest accepts allow credentials")
	func assertionRequestWithCredentials() {
		let cred1 = CredentialDescriptor(id: Data([0x01, 0x02]))
		let cred2 = CredentialDescriptor(id: Data([0x03, 0x04]), type: "public-key")

		let request = AssertionRequest(
			rpId: "example.com",
			clientDataHash: Data(repeating: 0, count: 32),
			allowCredentials: [cred1, cred2],
			userVerification: true
		)

		#expect(request.allowCredentials.count == 2)
		#expect(request.allowCredentials[0].id == Data([0x01, 0x02]))
		#expect(request.allowCredentials[0].type == "public-key")
		#expect(request.userVerification == true)
	}

	@Test("CredentialDescriptor defaults to public-key type")
	func credentialDescriptorDefault() {
		let cred = CredentialDescriptor(id: Data([0xFF]))
		#expect(cred.type == "public-key")
	}

	@Test("FidoClient can be instantiated")
	func clientInit() {
		let client = FidoClient()
		_ = client  // No crash = success
	}

	@Test("FidoError has user-friendly descriptions")
	func errorDescriptions() {
		let errors: [(FidoError, String)] = [
			(.deviceNotFound, "No FIDO security key found"),
			(.timeout, "did not respond in time"),
			(.disconnected, "was disconnected"),
		]
		for (error, substring) in errors {
			let desc = error.errorDescription ?? ""
			#expect(desc.contains(substring))
		}
	}
}
