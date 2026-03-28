//
//  DeviceInfo.swift
//  swiftfido2
//
//  Created by Gage Halverson on 3/27/26.
//

import Foundation

/// Information about a FIDO2 device's capabilities.
public struct DeviceInfo: Sendable {
	/// Supported protocol versions (e.g. ["FIDO_2_0", "FIDO_2_1"])
	public let versions: [String]
	/// Supported extensions (e.g. ["hmac-secret", "credProtect"])
	public let extensions: [String]
	/// Authenticator Attestation GUID
	public let aaguid: Data
	/// Device options (e.g. ["rk": true, "clientPin": true])
	public let options: [String: Bool]
	/// Maximum message size in bytes
	public let maxMsgSize: UInt64?
	/// Supported PIN/UV auth protocols
	public let pinProtocols: [UInt64]?

	init(from result: GetInfoResult) {
		self.versions = result.versions
		self.extensions = result.extensions ?? []
		self.aaguid = result.aaguid
		self.options = result.options
		self.maxMsgSize = result.maxMsgSize
		self.pinProtocols = result.pinProtocols
	}
}
