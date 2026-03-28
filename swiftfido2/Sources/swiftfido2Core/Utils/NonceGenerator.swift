//
//  NonceGenerator.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import Foundation

public enum NonceGenerator {
	/// Returns `count` cryptographically secure random bytes.
	public static func randomBytes(count: Int) -> Data {
		var buffer = [UInt8](repeating: 0, count: count)
		let status = SecRandomCopyBytes(kSecRandomDefault, count, &buffer)
		precondition(status == errSecSuccess, "Failed to generate secure random bytes")
		return Data(buffer)
	}
}
