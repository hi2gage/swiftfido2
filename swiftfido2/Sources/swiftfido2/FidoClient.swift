//
//  FidoClient.swift
//  swiftfido2
//
//  Created by Gage Halverson on 3/27/26.
//

import Foundation
import swiftfido2Core

/// The main entry point for FIDO2 operations.
///
/// Supports both a simple one-call API and an explicit device-handle API
/// for more control.
///
/// Simple usage:
/// ```swift
/// let client = FidoClient()
/// let assertion = try await client.getAssertion(request)
/// ```
///
/// Explicit usage:
/// ```swift
/// let client = FidoClient()
/// let device = try await client.waitForDevice()
/// let info = try await client.getInfo(device)
/// let assertion = try await client.getAssertion(device, request: request)
/// client.close(device)
/// ```
public final class FidoClient: Sendable {

	private let core = FidoCore()

	public init() {}

	// MARK: - Simple API (handles full lifecycle)

	/// Discovers the first available FIDO device, performs an assertion, and closes the device.
	public func getAssertion(_ request: AssertionRequest) async throws -> AssertionResponse {
		let device = try await waitForDevice()
		defer { close(device) }
		return try await getAssertion(device, request: request)
	}

	/// Discovers the first available FIDO device, queries its info, and closes the device.
	public func getInfo() async throws -> DeviceInfo {
		let device = try await waitForDevice()
		defer { close(device) }
		return try await getInfo(device)
	}

	// MARK: - Explicit API (caller manages device lifecycle)

	/// Discovers FIDO devices currently connected.
	public func discoverDevices() throws -> [FidoDevice] {
		let raw = try FidoDeviceDiscovery.discoverDevices()
		return raw.map { FidoDevice(raw: $0) }
	}

	/// Waits for a FIDO device to be plugged in, polling up to `timeout`.
	public func waitForDevice(timeout: Duration = .seconds(30)) async throws -> FidoDevice {
		let deadline = ContinuousClock.now + timeout
		while ContinuousClock.now < deadline {
			let devices = try discoverDevices()
			if let first = devices.first {
				return first
			}
			try await Task.sleep(for: .seconds(1))
		}
		throw FidoError.deviceNotFound
	}

	/// Queries the device for its capabilities.
	public func getInfo(_ device: FidoDevice) async throws -> DeviceInfo {
		let context = try await openAndInit(device)
		defer { context.close() }
		let result = try await core.getInfo(context)
		return DeviceInfo(from: result)
	}

	/// Sends a GetAssertion command to the device.
	/// The user will need to touch the key when it blinks.
	public func getAssertion(_ device: FidoDevice, request: AssertionRequest) async throws
		-> AssertionResponse
	{
		let context = try await openAndInit(device)
		defer { context.close() }

		let coreRequest = swiftfido2Core.AssertionRequest(
			rpId: request.rpId,
			clientDataHash: request.clientDataHash,
			allowCredentials: request.allowCredentials.map {
				swiftfido2Core.CredentialDescriptor(id: $0.id, type: $0.type)
			},
			userPresence: request.userPresence,
			userVerification: request.userVerification
		)

		let coreResponse = try await core.getAssertion(context, request: coreRequest)

		return AssertionResponse(
			credentialId: coreResponse.credentialId,
			authData: coreResponse.authData,
			signature: coreResponse.signature,
			userHandle: coreResponse.userHandle
		)
	}

	/// Closes a device and releases resources.
	public func close(_ device: FidoDevice) {
		// Device context is opened per-operation in the explicit API,
		// so this is a no-op currently. Reserved for future persistent connections.
	}

	// MARK: - Internal

	private func openAndInit(_ device: FidoDevice) async throws -> FidoDeviceContext {
		let uninitContext = try FidoDeviceDiscovery.open(device.raw)
		return try await core.initializeDevice(uninitContext)
	}
}
