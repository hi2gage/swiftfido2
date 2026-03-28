import CryptoKit
import Foundation
import swiftfido2

do {
	let client = FidoClient()

	// 1. Discover
	print("🔑 Looking for your security key...")
	let device = try await client.waitForDevice()
	print("✅ Found: \(device.name)")

	// 2. GetInfo
	let info = try await client.getInfo(device)
	print("📋 Versions: \(info.versions)")
	print("📋 Extensions: \(info.extensions)")
	print("📋 Options: \(info.options)")

	// 3. GetAssertion — test against webauthn.io
	let clientDataJSON = """
		{"type":"webauthn.get","challenge":"dGVzdC1jaGFsbGVuZ2U","origin":"https://webauthn.io","crossOrigin":false}
		"""
	let clientDataHash = Data(SHA256.hash(data: Data(clientDataJSON.utf8)))

	let request = AssertionRequest(
		rpId: "webauthn.io",
		clientDataHash: clientDataHash
	)

	print("\n🖐️ Touch your security key...")
	let assertion = try await client.getAssertion(device, request: request)
	print("✅ Got assertion!")
	print("   Credential ID: \(assertion.credentialId.base64EncodedString())")
	print("   Auth Data: \(assertion.authData.count) bytes")
	print("   Signature: \(assertion.signature.count) bytes")
	if let handle = assertion.userHandle {
		print(
			"   User Handle: \(String(data: handle, encoding: .utf8) ?? handle.base64EncodedString())"
		)
	}

	print("🧹 Done")

} catch {
	print("❌ Error: \(error)")
}
