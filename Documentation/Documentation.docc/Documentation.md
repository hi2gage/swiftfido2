# ``swiftfido2``

A pure Swift FIDO2/CTAP2 library for macOS.

## Overview

swiftfido2 provides native Swift access to FIDO2 hardware security keys (like YubiKey) over USB HID on macOS. It handles device discovery, CTAPHID channel initialization, and CTAP2 commands without any C dependencies.

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
