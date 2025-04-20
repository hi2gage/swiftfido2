import Foundation
import swiftfido2

// Usage
do {
    let fido = FIDO()

    let args = ChallengeArgs(
        rpId: "webauthn.io",
        validCredentials: [
            "HzkKL3lwFsZO/yxT2ttc+vLDquHKwSlcoW/uXA4B2TwoFZzrPlO1WY49oXPtTqqh",
            "aVmqqquRaXjXoc2O9ha6SZrm3Fo="
        ],
        devPin: "2593", // Not needed for this flow
        challenge: "oJaYU7YrvrHfE5nwjHFKs6UeJtmgZPPNrcCMghhtYs47zorVV3QIYkxjcB2FwTvLotXuZKxHBr3bHjAjA8icsQ",
        origin: "https://webauthn.io"
    )

    let response = try await fido.respondToChallenge(args: args)

    print(response)

} catch {
    print("❌ Error: \(error)")
}






