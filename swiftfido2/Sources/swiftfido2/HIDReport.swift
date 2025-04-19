//
//  File.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/19/25.
//

import Foundation
import IOKit

struct HIDReport {
    let reportID: CFIndex
    let reportType: IOHIDReportType
    let data: Data
}

extension HIDReport {
    init(
        _ initFrame: CTAPHIDInitFrame,
        reportID: CFIndex = 0,
        reportType: IOHIDReportType = kIOHIDReportTypeOutput
    ) {
        self.reportID   = reportID
        self.reportType = reportType
        self.data       = initFrame.raw
    }
}

/// A generic HID report sequence—one or more 64‑byte USB HID packets.
struct HIDPackageReport {
  let reportID:   CFIndex
  let reportType: IOHIDReportType
  let packets:    [Data]
}


extension HIDPackageReport {
    init(
        _ hidFrame: CTAPHIDCborFrame,
        reportID: CFIndex = 0,
        reportType: IOHIDReportType = kIOHIDReportTypeOutput
    ) {
        self.reportID   = reportID
        self.reportType = reportType
        self.packets    = hidFrame.packets
    }
}


struct CTAPHIDInitFrame {
    static let broadcastCID: UInt32 = 0xFFFFFFFF
    static let reportSize = 64
    static let nonceSize = 8

    let channelId: UInt32    // 0xFFFF_FFFF for allocate
    let nonce: Data          // 8 bytes

    /// The raw bytes you put into the HID report (after the reportID)
    var raw: Data {
        var d = Data()
        d.append(contentsOf: withUnsafeBytes(of: channelId.bigEndian, Array.init))
        d.append(0x80 | CTAPHIDCommand.`init`.rawValue)     // INIT with high‑bit
        d.append(UInt8((nonce.count >> Self.nonceSize) & 0xff))
        d.append(UInt8(nonce.count & 0xff))
        d.append(nonce)
        // pad to exactly 64 bytes
        d.append(contentsOf: repeatElement(0, count: Self.reportSize - d.count))
        return d
    }
}

struct CTAPHIDCborFrame {
  static let reportSize = 64

  let channelId: UInt32
  let command: UInt8        // e.g. CTAP2Command.getAssertion.rawValue
  let payload: Data

  /// All the HID‑report payloads you must send, in order.
  var packets: [Data] {
    var frames: [Data] = []

    // ------- initial packet -------
    var initHeader = Data()
    initHeader.append(contentsOf: withUnsafeBytes(of: channelId.bigEndian, Array.init))
    initHeader.append(0x80 | command)                         // high‑bit set → INIT packet
    initHeader.append(UInt8((payload.count >> 8) & 0xff))     // length hi
    initHeader.append(UInt8(payload.count & 0xff))            // length lo

    let firstChunkSize = Self.reportSize - initHeader.count
    let firstChunk = payload.prefix(firstChunkSize)

    var firstPacket = initHeader
    firstPacket.append(firstChunk)
    firstPacket.append(contentsOf: repeatElement(0, count: Self.reportSize - firstPacket.count))
    frames.append(firstPacket)

    // ------- continuation packets -------
    var seq: UInt8 = 0
    var offset = firstChunkSize
    while offset < payload.count {
      var contHeader = Data()
      contHeader.append(contentsOf: withUnsafeBytes(of: channelId.bigEndian, Array.init))
      contHeader.append(seq)  // sequence number

      let chunkSize = min(Self.reportSize - contHeader.count,
                          payload.count - offset)
      contHeader.append(payload[offset..<offset+chunkSize])
      contHeader.append(contentsOf: repeatElement(0, count: Self.reportSize - contHeader.count))

      frames.append(contHeader)
      offset += chunkSize
      seq += 1
    }

    return frames
  }
}
