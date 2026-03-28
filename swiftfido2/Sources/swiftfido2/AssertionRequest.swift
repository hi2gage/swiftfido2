//
//  AssertionRequest.swift
//  swiftfido2
//
//  Created by Gage Halverson on 3/27/26.
//

import Foundation

/// A FIDO2 GetAssertion request (authentication).
public struct AssertionRequest: Sendable {
	/// The relying party identifier (e.g. "apple.com")
	public let rpId: String
	/// SHA-256 hash of the client data JSON
	public let clientDataHash: Data
	/// Credentials the server will accept (empty = discoverable credentials)
	public let allowCredentials: [CredentialDescriptor]
	/// Whether user presence (touch) is required
	public let userPresence: Bool
	/// Whether user verification (PIN/biometric) is required
	public let userVerification: Bool

	public init(
		rpId: String,
		clientDataHash: Data,
		allowCredentials: [CredentialDescriptor] = [],
		userPresence: Bool = true,
		userVerification: Bool = false
	) {
		self.rpId = rpId
		self.clientDataHash = clientDataHash
		self.allowCredentials = allowCredentials
		self.userPresence = userPresence
		self.userVerification = userVerification
	}
}

/// Identifies a credential by its type and ID.
public struct CredentialDescriptor: Sendable {
	public let type: String
	public let id: Data

	public init(id: Data, type: String = "public-key") {
		self.type = type
		self.id = id
	}
}
