//
//  File.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/19/25.
//

import Foundation
import SwiftCBOR

/// A generic CTAP2 response: status + CBOR map
struct Ctap2Response {
	/// The one‑byte status returned by the authenticator (0x00 = success)
	let status: UInt8

	/// The CBOR‑decoded map of remaining fields
	let map: [CBOR: CBOR]

	/// Throw if status ≠ 0
	func ensureSuccess() throws {
		guard status == 0x00 else {
			throw Ctap2Error.responseStatus(status)
		}
	}

	init(raw: Data) throws {
		guard raw.count > 1 else {
			throw Ctap2Error.tooShort
		}
		status = raw.first!
		let cborBytes = [UInt8](raw.dropFirst())
		guard let top = try CBOR.decode(cborBytes),
			case .map(let m) = top
		else {
			throw Ctap2Error.invalidCBOR
		}
		map = m
	}
}

/// Common CTAP2 decoding errors
enum Ctap2Error: Error {
	case tooShort
	case responseStatus(UInt8)
	case invalidCBOR
	case missingField(String)
	case unexpectedFieldType(String)
}

/// 1) authenticatorMakeCredential_Response (CBOR keys 1–3)
struct MakeCredentialResponse {
	let fmt: String  // CBOR key=1
	let authData: Data  // CBOR key=2
	let attStmt: [CBOR: CBOR]  // CBOR key=3

	init(from resp: Ctap2Response) throws {
		try resp.ensureSuccess()

		guard case .utf8String(let fmt)? = resp.map[.unsignedInt(1)] else {
			throw Ctap2Error.missingField("fmt")
		}
		self.fmt = fmt

		guard case .byteString(let ad)? = resp.map[.unsignedInt(2)] else {
			throw Ctap2Error.missingField("authData")
		}
		self.authData = Data(ad)

		guard case .map(let stmt)? = resp.map[.unsignedInt(3)] else {
			throw Ctap2Error.missingField("attStmt")
		}
		self.attStmt = stmt
	}
}

/// 2) authenticatorGetAssertion_Response (CBOR keys 1–5)
struct GetAssertionResponse {
	/// the raw CBOR map for “GetAssertion” (status already checked)
	private let map: [CBOR: CBOR]

	/// The `id` field from the credential descriptor (key=1 → map→"id")
	let credentialID: Data
	/// The authenticator data blob (key=2)
	let authData: Data
	/// The signature blob (key=3)
	let signature: Data
	/// The user‑handle (if any) as UTF‑8 text (key=4 → map→"id")
	let userHandle: String?
	/// numberOfCredentials (key=5)
	let numberOfCredentials: UInt64?

	enum FieldError: Error {
		case missingField(String)
		case wrongType(String)
		case invalidUTF8(String)
	}

	init(from resp: Ctap2Response) throws {
		try resp.ensureSuccess()
		self.map = resp.map

		// 1) credentialID
		guard case .map(let credMap)? = map[.unsignedInt(1)],
			case .byteString(let idBytes)? = credMap[.utf8String("id")]
		else {
			throw FieldError.missingField("credential.id")
		}
		credentialID = Data(idBytes)

		// 2) authData
		guard case .byteString(let ad)? = map[.unsignedInt(2)] else {
			throw FieldError.missingField("authData")
		}
		authData = Data(ad)

		// 3) signature
		guard case .byteString(let sig)? = map[.unsignedInt(3)] else {
			throw FieldError.missingField("signature")
		}
		signature = Data(sig)

		// 4) userHandle (optional)
		if case .map(let userMap)? = map[.unsignedInt(4)],
			case .byteString(let uhBytes)? = userMap[.utf8String("id")]
		{
			guard let str = String(data: Data(uhBytes), encoding: .utf8) else {
				throw FieldError.invalidUTF8("userEntity.id")
			}
			userHandle = str
		} else {
			userHandle = nil
		}

		// 5) numberOfCredentials (optional)
		if case .unsignedInt(let n)? = map[.unsignedInt(5)] {
			numberOfCredentials = n
		} else {
			numberOfCredentials = nil
		}
	}
}

/// 3) authenticatorGetNextAssertion_Response uses the same structure as GetAssertionResponse:
typealias GetNextAssertionResponse = GetAssertionResponse

/// 4) authenticatorGetInfo_Response (CBOR keys 1–6)
struct GetInfoResponse {
	let versions: [String]  // key=1
	let extensions: [String]?  // key=2
	let aaguid: Data  // key=3
	let options: [String: Bool]  // key=4
	let maxMsgSize: UInt64  // key=5
	let pinProtocols: [UInt64]?  // key=6

	init(from resp: Ctap2Response) throws {
		try resp.ensureSuccess()

		guard case .array(let vs)? = resp.map[.unsignedInt(1)] else {
			throw Ctap2Error.missingField("versions")
		}
		versions = vs.compactMap {
			if case .utf8String(let s) = $0 { return s } else { return nil }
		}

		if case .array(let exts)? = resp.map[.unsignedInt(2)] {
			extensions = exts.compactMap {
				if case .utf8String(let s) = $0 { return s } else { return nil }
			}
		} else {
			extensions = nil
		}

		guard case .byteString(let ag)? = resp.map[.unsignedInt(3)], ag.count == 16 else {
			throw Ctap2Error.missingField("aaguid")
		}
		aaguid = Data(ag)

		guard case .map(let opts)? = resp.map[.unsignedInt(4)] else {
			throw Ctap2Error.missingField("options")
		}
		options = opts.reduce(into: [:]) { dict, pair in
			if case .utf8String(let key) = pair.key,
				case .boolean(let val) = pair.value
			{
				dict[key] = val
			}
		}

		guard case .unsignedInt(let max)? = resp.map[.unsignedInt(5)] else {
			throw Ctap2Error.missingField("maxMsgSize")
		}
		maxMsgSize = max

		if case .array(let pps)? = resp.map[.unsignedInt(6)] {
			pinProtocols = pps.compactMap {
				if case .unsignedInt(let p) = $0 { return p } else { return nil }
			}
		} else {
			pinProtocols = nil
		}
	}
}

/// 5) authenticatorClientPIN_Response (CBOR keys 1–3)
//struct ClientPINResponse {
//    let keyAgreement: CBOR        // key=1, COSE_Key map (you can decode further)
//    let pinToken:     Data        // key=2
//    let retries:      UInt64      // key=3
//
//    init(from resp: Ctap2Response) throws {
//        try resp.ensureSuccess()
//
//        guard case let .map(kam)? = resp.map[.unsignedInt(1)] else {
//            throw Ctap2Error.missingField("keyAgreement")
//        }
//        keyAgreement = kam
//
//        guard case let .byteString(pt)? = resp.map[.unsignedInt(2)] else {
//            throw Ctap2Error.missingField("pinToken")
//        }
//        pinToken = Data(pt)
//
//        guard case let .unsignedInt(r)? = resp.map[.unsignedInt(3)] else {
//            throw Ctap2Error.missingField("retries")
//        }
//        retries = r
//    }
//}
