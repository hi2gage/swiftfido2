//
//  InitManager.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/18/25.
//
import IOKit.hid
import Foundation

class InitManager {
    func performCTAPHIDInit(
        device: IOHIDDevice,
        context: FidoDeviceContext,
        reportID: CFIndex = 0
    ) throws -> UInt32 {
        let broadcastCID: UInt32 = 0xFFFFFFFF
        let command: UInt8 = 0x06 // CTAPHID_INIT
        let nonce = try Data.random(length: 8)

        print("🔐 Nonce (generated): \(nonce.map { String(format: "%02x", $0) }.joined(separator: " "))")

        let frame = buildCtapHidInitFrame(channelId: broadcastCID, nonce: nonce)
        print("📤 Sending INIT frame: \(frame.map { String(format: "%02x", $0) }.joined(separator: " "))")

        try sendToHidDevice(
            device: device,
            reportID: reportID,
            data: frame,
            reportType: kIOHIDReportTypeOutput
        )

        // Run I/O loop to allow the device to respond
        scheduleIOLoop(device: device, ms: 5000)

        // Wait for response on the pipe using poll
        let rawResponse = try readFromPipe(
            fd: context.reportPipe[0],
            bufferSize: context.reportInLen,
            timeoutMs: 5000
        )

        print("📥 Raw INIT response (with report ID): \(rawResponse.map { String(format: "%02x", $0) }.joined(separator: " "))")

        // Ensure we have enough data to strip report ID
        guard rawResponse.count > 1 else {
            print("❌ Response too short to contain report ID and payload.")
            throw FidoError.internalError
        }

        let ctapResponse = rawResponse.dropFirst() // skip report ID (byte 0)
        print("📦 CTAPHID response (without report ID): \(ctapResponse.map { String(format: "%02x", $0) }.joined(separator: " "))")

        guard ctapResponse.count >= 7 + CTAPHIDInitResponse.expectedLength else {
            print("⚠️ INIT response too short. Got \(ctapResponse.count) bytes.")
            throw FidoError.internalError
        }

        // Sanity check: display CTAPHID header
        let header = ctapResponse.prefix(7)
        print("📄 CTAPHID header: \(header.map { String(format: "%02x", $0) }.joined(separator: " "))")

        // Extract and log INIT payload
        let payload = ctapResponse[7..<7 + CTAPHIDInitResponse.expectedLength]
        print("📨 Decoded INIT payload (17 bytes): \(payload.map { String(format: "%02x", $0) }.joined(separator: " "))")

        let initResponse = try CTAPHIDInitResponse(data: Data(payload))

        // ✅ Compare echoed nonce
        if initResponse.nonce != nonce {
            print("🚨 Nonce mismatch!")
            print("🔐 Expected nonce: \(nonce.map { String(format: "%02x", $0) }.joined())")
            print("📥 Received nonce: \(initResponse.nonce.map { String(format: "%02x", $0) }.joined())")
            throw FidoError.internalError
        } else {
            print("✅ Nonce match confirmed.")
        }

        print("🆔 Assigned Channel ID (from payload): \(String(format: "%08x", initResponse.cid))")

        // Optionally extract channel ID directly from raw response for comparison
        let cidBytes = ctapResponse[15..<19]
        let newCID = Data(ctapResponse[15..<19]).withUnsafeBytes {
            $0.load(as: UInt32.self).bigEndian
        }
        print("🆔 Assigned Channel ID (manual extract): \(String(format: "%08x", newCID))")

        return newCID
    }


    private func scheduleIOLoop(device: IOHIDDevice, ms: Int) {
        let loopID = CFRunLoopMode.defaultMode.rawValue
        // Schedule the device with the current run loop
        IOHIDDeviceScheduleWithRunLoop(device, CFRunLoopGetCurrent(), loopID)

        var timeout: Double = (ms == -1) ? 5.0 : Double(ms) / 1000.0

        // Run the current run loop for the specified timeout
        CFRunLoopRunInMode(CFRunLoopMode.defaultMode, timeout, true)

        // Unschedule the device from the current run loop
        IOHIDDeviceUnscheduleFromRunLoop(device, CFRunLoopGetCurrent(), loopID)
    }

    private func buildCtapHidInitFrame(channelId: UInt32, nonce: Data) -> Data {
        let reportSize = 64

        var frame = Data()
        frame.append(contentsOf: withUnsafeBytes(of: channelId.bigEndian, Array.init))
        frame.append(0x86) // 0x80 | 0x06 (CTAPHID_INIT)
        frame.append(UInt8((nonce.count >> 8) & 0xFF))
        frame.append(UInt8(nonce.count & 0xFF))
        frame.append(nonce)

        // Pad to report size
        if frame.count < reportSize {
            frame.append(contentsOf: repeatElement(0, count: reportSize - frame.count))
        }

        return frame
    }

    private func sendToHidDevice(
        device: IOHIDDevice,
        reportID: CFIndex = 0,
        data: Data,
        reportType: IOHIDReportType
    ) throws {
        // ✅ Don't prepend reportID to the data
        let result = data.withUnsafeBytes { (buffer: UnsafeRawBufferPointer) -> IOReturn in
            let reportPtr = buffer.bindMemory(to: UInt8.self).baseAddress!
            return IOHIDDeviceSetReport(device, reportType, reportID, reportPtr, buffer.count)
        }

        guard result == kIOReturnSuccess else {
            print("❌ Failed to send report. IOReturn: \(result)")
            throw FidoError.txError
        }

        print("📨 INIT packet \(data.count) bytes sent")
    }

    func readFromPipe(fd: Int32, bufferSize: Int, timeoutMs: Int) throws -> Data {
        print("🔍 Waiting to read from pipe fd=\(fd), timeout=\(timeoutMs)ms")

        var pollFD = pollfd(fd: fd, events: Int16(POLLIN), revents: 0)
        let pollResult = poll(&pollFD, 1, Int32(timeoutMs))

        if pollResult == 0 {
            print("⏱️ Poll timed out after \(timeoutMs)ms — no data available")
            throw FidoError.readTimedOut
        } else if pollResult < 0 {
            print("❌ Poll error: \(String(cString: strerror(errno)))")
            throw FidoError.failedToReadPendingFrame
        }

        print("📡 Poll returned: \(pollResult), revents: \(pollFD.revents)")

        var buffer = [UInt8](repeating: 0, count: bufferSize)
        print("📖 Attempting to read from pipe fd=\(fd)")
        let bytesRead = read(fd, &buffer, bufferSize)
        print("📦 Bytes read: \(bytesRead)")

        if bytesRead <= 0 {
            print("❌ Read failed or returned no bytes. errno: \(errno), message: \(String(cString: strerror(errno)))")
            throw FidoError.failedToReadData
        }

        let hexDump = buffer.prefix(bytesRead).map { String(format: "%02x", $0) }.joined(separator: " ")
        print("📥 Read \(bytesRead) bytes from pipe: \(hexDump)")

        return Data(buffer.prefix(bytesRead))
    }
}

struct CTAPHIDInitResponse {
    let nonce: Data      // 8 bytes
    let cid: UInt32      // 4 bytes
    let ctaphidProtocol: UInt8  // 1 byte
    let major: UInt8     // 1 byte
    let minor: UInt8     // 1 byte
    let build: UInt8     // 1 byte
    let flags: UInt8     // 1 byte

    static let expectedLength = 17

    init(data: Data) throws {
        guard data.count >= Self.expectedLength else {
            throw FidoError.internalError
        }

        self.nonce = data.prefix(8)

        let cidRange = 8..<12
        self.cid = data[cidRange].withUnsafeBytes {
            $0.load(as: UInt32.self).bigEndian
        }

        self.ctaphidProtocol = data[12]
        self.major    = data[13]
        self.minor    = data[14]
        self.build    = data[15]
        self.flags    = data[16]
    }
}
