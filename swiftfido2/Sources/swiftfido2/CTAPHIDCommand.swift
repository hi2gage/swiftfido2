//
//  File.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/18/25.
//

import Foundation

/// CTAP over HID command codes (without the 0x80 “init” bit).
public enum CTAPHIDCommand: UInt8 {
  case ping       = 0x01   // “echo” test
  case msg        = 0x03   // legacy U2F messages
  case lock       = 0x04   // locking (rarely used)
  case `init`     = 0x06   // initialize a channel
  case wink       = 0x08   // blink the device LED
  case cbor       = 0x10   // CTAP2 message
  case cancel     = 0x11   // cancel a long‑running CTAP2 command
  case keepAlive  = 0x3B   // sent by device to show it’s still processing
  case error      = 0x3F   // error response

  /// When sending an “initial” packet, you always OR the command with 0x80.
  public var initialPacket: UInt8 {
    return rawValue | 0x80
  }
}
