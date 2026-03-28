import CryptoKit
import Foundation
import swiftfido2
import swiftfido2Core

do {
	let core = FidoCore()

	// 1. Discover
	let devices = try FidoDeviceDiscovery.discoverDevices()
	guard let device = devices.first else {
		fatalError("No FIDO devices found — plug in your YubiKey")
	}
	print("🔑 Found: \(device.vendorId):\(device.productId)")

	// 2. Open & CTAPHID Init
	let uninitContext = try FidoDeviceDiscovery.open(device)
	let context = try await core.initializeDevice(uninitContext)
	print("✅ Channel: \(String(format: "0x%08X", context.channelId))")

	// 3. GetInfo — see what the device supports
	let info = try await core.getInfo(context)
	print("📋 Versions: \(info.versions)")
	print("📋 Extensions: \(info.extensions ?? [])")
	print("📋 Options: \(info.options)")
	print("📋 Max message size: \(info.maxMsgSize ?? 0)")

	// 4. GetAssertion — a test assertion against webauthn.io
	//    This will fail with a CTAP2 error if no credential is registered,
	//    but it proves the full round-trip works.
	let clientDataJSON = """
		{"type":"webauthn.get","challenge":"dGVzdC1jaGFsbGVuZ2U","origin":"https://webauthn.io","crossOrigin":false}
		"""
	let clientDataHash = Data(SHA256.hash(data: Data(clientDataJSON.utf8)))

	let request = AssertionRequest(
		rpId: "webauthn.io",
		clientDataHash: clientDataHash
	)

	print("\n🖐️ Sending GetAssertion for webauthn.io — touch your key if it blinks...")
	let assertion = try await core.getAssertion(context, request: request)
	print("✅ Got assertion!")
	print("   Credential ID: \(assertion.credentialId.base64EncodedString())")
	print("   Auth Data: \(assertion.authData.count) bytes")
	print("   Signature: \(assertion.signature.count) bytes")
	if let handle = assertion.userHandle {
		print(
			"   User Handle: \(String(data: handle, encoding: .utf8) ?? handle.base64EncodedString())"
		)
	}

	context.close()
	print("🧹 Done")

} catch {
	print("❌ Error: \(error)")
}
