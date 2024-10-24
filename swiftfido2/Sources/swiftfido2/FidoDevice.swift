//
//  Untitled.swift
//  swiftfido2
//
//  Created by Gage Halverson on 10/23/24.
//

import Foundation

struct FidoDevice {
    var nonce: Data                  // Issued nonce
    var attr: FidoCTAPInfo             // Device attributes (you'll need to define this struct)
    var cid: UInt32                    // Assigned channel ID
    var path: String                   // Device path
    var ioHandle: UnsafeMutableRawPointer? // Abstract I/O handle
    var io: FidoDeviceIO               // I/O functions
    var ioOwn: Bool                    // Device has own I/O/transport
    var rxLen: UInt                    // Length of HID input reports
    var txLen: UInt                    // Length of HID output reports
    var flags: Int                     // Internal flags
    var transport: FidoDeviceTransport  // Transport functions
    var maxMsgSize: UInt64             // Max message size
    var timeoutMs: Int                 // Read timeout in milliseconds
}


extension FidoDevice {

    mutating func openWait(path: String, ms: Int) throws {
            try openTx(path: path, ms: ms)
//            try openRx(ms: ms)
        }

    private mutating func openTx(path: String, ms: Int) throws {
//        guard ioHandle == nil else {
//            throw FidoError.invalidArgument
//        }

        guard let open = io.open, let close = io.close else {
            throw FidoError.invalidArgument
        }

        guard cid == Self.CTAP_CID_BROADCAST else {
            throw FidoError.invalidArgument
        }

        guard let nonceResult = try? Data.random(length: UInt64.bitWidth) else {
            throw FidoError.internalError
        }
        nonce = nonceResult

        // Open the device using the I/O function
        ioHandle = open(path)

        guard ioHandle != nil else {
            throw FidoError.internalError
        }

        // You need to define your own logic for setting rx_len and tx_len
        // Assuming they are defined as properties of this struct
        // Example:
        // rxLen = fido_hid_report_in_len(ioHandle)
        // txLen = fido_hid_report_out_len(ioHandle)

//        // Validate lengths
//        if rxLen < Self.CTAP_MIN_REPORT_LEN || rxLen > Self.CTAP_MAX_REPORT_LEN {
//            close(ioHandle)
//            ioHandle = nil
//            throw FidoError.rxError
//        }
//
//        if txLen < Self.CTAP_MIN_REPORT_LEN || txLen > Self.CTAP_MAX_REPORT_LEN {
//            close(ioHandle)
//            ioHandle = nil
//            throw FidoError.txError
//        }
//
//        // Send the initial command to the device
//        guard tx(command: Self.CTAP_CMD_INIT, data: nonce, ms: ms) else {
//            close(ioHandle)
//            ioHandle = nil
//            throw FidoError.txError
//        }
    }

    static var CTAP_CID_BROADCAST = 0xffffffff
    static var CTAP_INIT_HEADER_LEN = 7
    static var CTAP_CONT_HEADER_LEN = 5

    /* Maximum length of a CTAP HID report in bytes. */
    static var CTAP_MAX_REPORT_LEN = 64

    /* Minimum length of a CTAP HID report in bytes. */
    static var CTAP_MIN_REPORT_LEN: Int { CTAP_INIT_HEADER_LEN + 1 }

    /* CTAPHID command opcodes. */

    static var CTAP_CMD_INIT = 0x06
}
