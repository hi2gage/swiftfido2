# ``SwiftFido2``

A pure Swift FIDO2/CTAP2 library for macOS.

## Overview

SwiftFido2 provides native Swift access to FIDO2 hardware security keys over USB HID on macOS. It communicates directly with authenticators like YubiKey using the CTAP2 protocol. No C dependencies, no wrappers.

## Topics

### Getting Started

- ``FidoClient``
- ``FidoDevice``

### Authentication

- ``AssertionRequest``
- ``AssertionResponse``
- ``CredentialDescriptor``

### Device Information

- ``DeviceInfo``

### Errors

- ``FidoError``
