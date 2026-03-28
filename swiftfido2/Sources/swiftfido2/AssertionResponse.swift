//
//  AssertionResponse.swift
//  swiftfido2
//
//  Created by Gage Halverson on 3/27/26.
//

import Foundation
import SwiftCBOR

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
	/// Number of credentials available (optional)
	public let numberOfCredentials: UInt64?

	init(raw: Data) throws {
		guard raw.count > 1 else {
			throw Ctap2ResponseError.tooShort
		}

		let status = raw[0]
		guard status == 0x00 else {
			throw Ctap2ResponseError.status(status)
		}

		let cborBytes = [UInt8](raw.dropFirst())
		guard let top = try CBOR.decode(cborBytes),
			case .map(let map) = top
		else {
			throw Ctap2ResponseError.invalidCBOR
		}

		guard case .map(let credMap)? = map[.unsignedInt(1)],
			case .byteString(let idBytes)? = credMap[.utf8String("id")]
		else {
			throw Ctap2ResponseError.missingField("credential.id")
		}
		self.credentialId = Data(idBytes)

		guard case .byteString(let ad)? = map[.unsignedInt(2)] else {
			throw Ctap2ResponseError.missingField("authData")
		}
		self.authData = Data(ad)

		guard case .byteString(let sig)? = map[.unsignedInt(3)] else {
			throw Ctap2ResponseError.missingField("signature")
		}
		self.signature = Data(sig)

		if case .map(let userMap)? = map[.unsignedInt(4)],
			case .byteString(let uhBytes)? = userMap[.utf8String("id")]
		{
			self.userHandle = Data(uhBytes)
		} else {
			self.userHandle = nil
		}

		if case .unsignedInt(let n)? = map[.unsignedInt(5)] {
			self.numberOfCredentials = n
		} else {
			self.numberOfCredentials = nil
		}
	}
}

enum Ctap2ResponseError: Error {
	case tooShort
	case status(UInt8)
	case invalidCBOR
	case missingField(String)
}
