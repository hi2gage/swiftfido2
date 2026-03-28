//
//  FidoCore.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import Foundation
import IOKit
import SwiftCBOR

final class FidoCore: Sendable {

	init() {}

	// MARK: - CTAPHID Init

	func initializeDevice(_ context: UninitializedFidoContext) async throws
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

	func getInfo(_ context: FidoDeviceContext) async throws -> GetInfoResult {
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

	func getAssertion(
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

// MARK: - GetInfo Result

struct GetInfoResult: Sendable {
	let versions: [String]
	let extensions: [String]?
	let aaguid: Data
	let options: [String: Bool]
	let maxMsgSize: UInt64?
	let pinProtocols: [UInt64]?

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
