# SwiftFido2

A pure Swift FIDO2/CTAP2 library for macOS. Communicates directly with hardware security keys like YubiKey over USB HID using the CTAP2 protocol. No C dependencies, no wrappers.

## Features

- Device discovery via IOKit HID
- CTAPHID channel initialization
- CTAP2 GetAssertion (authentication)
- CTAP2 GetInfo (device capabilities)
- Async/await API with dispatch queue-based HID transport
- Automatic device polling with configurable timeout

## Quick Start

```swift
import SwiftFido2

let client = FidoClient()
let assertion = try await client.getAssertion(
    AssertionRequest(
        rpId: "example.com",
        clientDataHash: clientDataHash,
        allowCredentials: [CredentialDescriptor(id: credentialId)]
    )
)

// assertion.credentialId
// assertion.authData
// assertion.signature
// assertion.userHandle
```

## Explicit Device Control

For more control over device selection and lifecycle:

```swift
let client = FidoClient()

// Wait for a key to be plugged in
let device = try await client.waitForDevice(timeoutSeconds: 30)
print("Found: \(device.name)")  // "YubiKey OTP+FIDO+CCID"

// Query device capabilities
let info = try await client.getInfo(device)
print(info.versions)    // ["U2F_V2", "FIDO_2_0", "FIDO_2_1"]
print(info.extensions)  // ["hmac-secret", "credProtect", "largeBlobKey"]
print(info.options)     // ["rk": true, "clientPin": true, ...]

// Perform assertion
let assertion = try await client.getAssertion(device, request: request)
```

## How It Works

1. **Discovery** Enumerates USB HID devices via IOKit and filters for FIDO-compliant keys (usage page `0xF1D0`)
2. **Channel Init** Sends `CTAPHID_INIT` on the broadcast channel to allocate a dedicated communication channel
3. **Command** Encodes the CTAP2 command as `CBOR`, frames it into HID report packets, and sends to the device
4. **Response** Reassembles multi-packet responses, handles `KEEPALIVE` messages while waiting for user touch, and decodes the `CBOR` response

## Supported Devices

Tested with YubiKey 5C NFC (firmware 5.7.1). Should work with any FIDO2-compliant USB HID security key.

The library includes a catalog of 50+ known FIDO authenticators from vendors including Yubico, Ledger, SoloKeys, Feitian, Google, Nitrokey, and others.

## Architecture

```
SwiftFido2/
├── FidoClient           # Public API entry point
├── FidoDevice           # Device handle (name, vendor/product ID)
├── AssertionRequest     # GetAssertion input (rpId, clientDataHash, credentials)
├── AssertionResponse    # GetAssertion output (credentialId, authData, signature)
├── DeviceInfo           # Device capabilities (versions, extensions, options)
├── FidoError            # Error types with user-friendly descriptions
├── CTAPHID/             # HID framing, packet splitting, response reassembly
├── Devices/             # IOKit HID transport, device discovery
└── Utils/               # Nonce generation, report length utilities
```

## Requirements

- macOS 10.15+
- Swift 6.0+
- A FIDO2-compliant USB security key

## License

MIT
