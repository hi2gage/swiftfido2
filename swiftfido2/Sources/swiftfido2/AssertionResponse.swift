//
//  AssertionResponse.swift
//  swiftfido2
//
//  Created by Gage Halverson on 3/27/26.
//

import Foundation

/// The response from a FIDO2 GetAssertion operation.
public struct AssertionResponse: Sendable {
	/// The credential ID that was used
	public let credentialId: Data
	/// The authenticator data blob
	public let authData: Data
	/// The signature over the client data hash and authenticator data
	public let signature: Data
	/// The user handle associated with the credential (optional)
	public let userHandle: Data?
}
