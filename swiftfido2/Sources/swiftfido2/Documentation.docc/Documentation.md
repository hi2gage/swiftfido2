# ``swiftfido2``

A pure Swift FIDO2/CTAP2 library for macOS.

## Overview

swiftfido2 provides native Swift access to FIDO2 hardware security keys over USB HID on macOS. It communicates directly with authenticators like YubiKey using the CTAP2 protocol. No C dependencies, no wrappers.

The library handles the full lifecycle: device discovery, CTAPHID channel initialization, and CTAP2 commands like GetAssertion and GetInfo.

### Quick Start

```swift
import swiftfido2

let client = FidoClient()
let assertion = try await client.getAssertion(
    AssertionRequest(
        rpId: "example.com",
        clientDataHash: clientDataHash,
        allowCredentials: [CredentialDescriptor(id: credentialId)]
    )
)
```

### Explicit Device Control

For more control over device selection and lifecycle:

```swift
let client = FidoClient()
let device = try await client.waitForDevice(timeout: .seconds(30))
let info = try await client.getInfo(device)
let assertion = try await client.getAssertion(device, request: request)
```

## Topics

### Essentials

- ``FidoClient``
- ``FidoDevice``
- ``FidoError``

### Authentication

- ``AssertionRequest``
- ``AssertionResponse``
- ``CredentialDescriptor``

### Device Information

- ``DeviceInfo``

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
