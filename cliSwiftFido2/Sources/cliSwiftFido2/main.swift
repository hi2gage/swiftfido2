import Foundation
import swiftfido2
import swiftfido2Core

// Usage
do {
	let fido = FIDO()

	let args = ChallengeArgs(
		rpId: "webauthn.io",
		validCredentials: [
			"HzkKL3lwFsZO/yxT2ttc+vLDquHKwSlcoW/uXA4B2TwoFZzrPlO1WY49oXPtTqqh",
			"aVmqqquRaXjXoc2O9ha6SZrm3Fo=",
		],
		devPin: "2593",  // Not needed for this flow
		challenge:
			"oJaYU7YrvrHfE5nwjHFKs6UeJtmgZPPNrcCMghhtYs47zorVV3QIYkxjcB2FwTvLotXuZKxHBr3bHjAjA8icsQ",
		origin: "https://webauthn.io"
	)

	try await test()

	//    let response = try await fido.respondToChallenge(args: args)

	//    print(response)

} catch {
	print("❌ Error: \(error)")
}

func test() async throws {
	let devices = try FidoDeviceDiscovery.discoverDevices()
	guard let device = devices.first else {
		fatalError("No FIDO devices found")
	}
	let context = try FidoDeviceDiscovery.open(device)

	let core = FidoCore()

	let signedContext = try await core.initializeDevice(context)

	print("context: \(context)")
	print("signedContext: \(signedContext)")
}
