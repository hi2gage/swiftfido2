//
//  FidoDevice.swift
//  swiftfido2
//
//  Created by Gage Halverson on 10/23/24.
//

struct FidoCTAPInfo {
    var nonce: UInt64             // Echoed nonce
    var cid: UInt32               // Channel ID
    var protocolId: UInt8         // CTAPHID protocol ID
    var major: UInt8              // Major version number
    var minor: UInt8              // Minor version number
    var build: UInt8              // Build version number
    var flags: UInt8              // Capabilities flags
}

