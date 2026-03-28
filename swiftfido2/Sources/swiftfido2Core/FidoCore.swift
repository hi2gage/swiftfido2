//
//  FidoCore.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import CryptoKit
import Foundation
import IOKit
import SwiftCBOR

package final class FidoCore: Sendable {

	package init() {}

	// MARK: - CTAPHID Init

	package func initializeDevice(_ context: UninitializedFidoContext) async throws
		-> FidoDeviceContext
	{
		let nonce = NonceGenerator.randomBytes(count: CTAPHIDSpec.nonceLength)

		let initFrame = CTAPHIDFramer.buildInitialFrame(
			channelId: CTAPHIDSpec.broadcastChannelId,
			nonce: nonce,
			reportSize: context.device.outputReportSize
		)

		let report = initFrame.asHIDReport()
		try context.transport.sendReport(report)

		let rawReport = try await context.transport.readAsync(timeoutMs: 1000)

		let payload = try CTAPHIDInitPayload(rawReport: rawReport)

		try payload.assertValidNonce(nonce)

		return FidoDeviceContext(from: context, channelId: payload.channelId)
	}

	// MARK: - GetInfo

	package func getInfo(_ context: FidoDeviceContext) async throws -> GetInfoResult {
		let payload = Data([0x04])  // authenticatorGetInfo command byte

		let frame = CTAPHIDCborFrame(
			channelId: context.device.channelId,
			command: CTAPHIDSpec.Command.cbor.rawValue,
			payload: payload
		)

		let report = HIDPackageReport(frame)
		try context.transport.sendReportPackets(report)

		let response = try await CTAPHIDResponseReader.readResponse(
			from: context.transport,
			channelId: context.device.channelId,
			timeoutMs: 5000
		)

		return try GetInfoResult(raw: response)
	}

	// MARK: - GetAssertion

	package func getAssertion(
		_ context: FidoDeviceContext,
		request: AssertionRequest
	) async throws -> AssertionResponse {
		let cborPayload = try request.toCBOR()
		var payload = Data([0x02])  // authenticatorGetAssertion command byte
		payload.append(cborPayload)

		let frame = CTAPHIDCborFrame(
			channelId: context.device.channelId,
			command: CTAPHIDSpec.Command.cbor.rawValue,
			payload: payload
		)

		let report = HIDPackageReport(frame)
		try context.transport.sendReportPackets(report)

		// Longer timeout — user needs to physically touch the key
		let response = try await CTAPHIDResponseReader.readResponse(
			from: context.transport,
			channelId: context.device.channelId,
			timeoutMs: 30_000
		)

		return try AssertionResponse(raw: response)
	}
}

// MARK: - Assertion Request

package struct AssertionRequest: Sendable {
	package let rpId: String
	package let clientDataHash: Data
	package let allowCredentials: [CredentialDescriptor]
	package let userPresence: Bool
	package let userVerification: Bool

	package init(
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

	func toCBOR() throws -> Data {
		var map: [CBOR: CBOR] = [:]

		map[CBOR.unsignedInt(1)] = CBOR.utf8String(rpId)
		map[CBOR.unsignedInt(2)] = CBOR.byteString([UInt8](clientDataHash))

		if !allowCredentials.isEmpty {
			let descriptors = allowCredentials.map { cred in
				CBOR.map([
					CBOR.utf8String("type"): CBOR.utf8String(cred.type),
					CBOR.utf8String("id"): CBOR.byteString([UInt8](cred.id)),
				])
			}
			map[CBOR.unsignedInt(3)] = CBOR.array(descriptors)
		}

		var options: [CBOR: CBOR] = [:]
		options[CBOR.utf8String("up")] = CBOR.boolean(userPresence)
		if userVerification {
			options[CBOR.utf8String("uv")] = CBOR.boolean(true)
		}
		if !options.isEmpty {
			map[CBOR.unsignedInt(5)] = CBOR.map(options)
		}

		return Data(CBOR.map(map).encode())
	}
}

package struct CredentialDescriptor: Sendable {
	package let type: String
	package let id: Data

	package init(id: Data, type: String = "public-key") {
		self.type = type
		self.id = id
	}
}

// MARK: - Assertion Response

package struct AssertionResponse: Sendable {
	package let credentialId: Data
	package let authData: Data
	package let signature: Data
	package let userHandle: Data?
	package let numberOfCredentials: UInt64?

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

		// Key 1: credential descriptor → id
		guard case .map(let credMap)? = map[.unsignedInt(1)],
			case .byteString(let idBytes)? = credMap[.utf8String("id")]
		else {
			throw Ctap2ResponseError.missingField("credential.id")
		}
		self.credentialId = Data(idBytes)

		// Key 2: authData
		guard case .byteString(let ad)? = map[.unsignedInt(2)] else {
			throw Ctap2ResponseError.missingField("authData")
		}
		self.authData = Data(ad)

		// Key 3: signature
		guard case .byteString(let sig)? = map[.unsignedInt(3)] else {
			throw Ctap2ResponseError.missingField("signature")
		}
		self.signature = Data(sig)

		// Key 4: user handle (optional)
		if case .map(let userMap)? = map[.unsignedInt(4)],
			case .byteString(let uhBytes)? = userMap[.utf8String("id")]
		{
			self.userHandle = Data(uhBytes)
		} else {
			self.userHandle = nil
		}

		// Key 5: numberOfCredentials (optional)
		if case .unsignedInt(let n)? = map[.unsignedInt(5)] {
			self.numberOfCredentials = n
		} else {
			self.numberOfCredentials = nil
		}
	}
}

// MARK: - GetInfo Result

package struct GetInfoResult: Sendable {
	package let versions: [String]
	package let extensions: [String]?
	package let aaguid: Data
	package let options: [String: Bool]
	package let maxMsgSize: UInt64?
	package let pinProtocols: [UInt64]?

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

		guard case .array(let vs)? = map[.unsignedInt(1)] else {
			throw Ctap2ResponseError.missingField("versions")
		}
		self.versions = vs.compactMap {
			if case .utf8String(let s) = $0 { return s } else { return nil }
		}

		if case .array(let exts)? = map[.unsignedInt(2)] {
			self.extensions = exts.compactMap {
				if case .utf8String(let s) = $0 { return s } else { return nil }
			}
		} else {
			self.extensions = nil
		}

		guard case .byteString(let ag)? = map[.unsignedInt(3)] else {
			throw Ctap2ResponseError.missingField("aaguid")
		}
		self.aaguid = Data(ag)

		if case .map(let opts)? = map[.unsignedInt(4)] {
			self.options = opts.reduce(into: [:]) { dict, pair in
				if case .utf8String(let key) = pair.key,
					case .boolean(let val) = pair.value
				{
					dict[key] = val
				}
			}
		} else {
			self.options = [:]
		}

		if case .unsignedInt(let max)? = map[.unsignedInt(5)] {
			self.maxMsgSize = max
		} else {
			self.maxMsgSize = nil
		}

		if case .array(let pps)? = map[.unsignedInt(6)] {
			self.pinProtocols = pps.compactMap {
				if case .unsignedInt(let p) = $0 { return p } else { return nil }
			}
		} else {
			self.pinProtocols = nil
		}
	}
}

// MARK: - Errors

package enum Ctap2ResponseError: Error {
	case tooShort
	case status(UInt8)
	case invalidCBOR
	case missingField(String)
}
