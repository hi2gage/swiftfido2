//
//  Fido2Manager.swift
//  swiftfido2
//
//  Created by Gage Halverson on 10/23/24.
//
import IOKit.hid
import Foundation
import CryptoKit
import SwiftCBOR

extension Fido2Manager {
    var CTAP_MAX_REPORT_LEN: Int { 64 }
}

// MARK: Find Device:

extension Fido2Manager {
    func fidoHidDevices(max: Int) throws -> [FidoDeviceInfo] {
        let manager: IOHIDManager = IOHIDManagerCreate(kCFAllocatorDefault, 0)

        IOHIDManagerSetDeviceMatching(manager, nil)
        if let deviceSet = IOHIDManagerCopyDevices(manager) as? Set<IOHIDDevice>, !deviceSet.isEmpty {
            return deviceSet.prefix(max).compactMap { FidoDeviceInfo(from: $0) }
        } else {
            throw FidoError.noDevicesFound
        }
    }
}

// MARK: Utilities

extension Fido2Manager {
    // Utility to get report length
    private func getReportLength(device: IOHIDDevice, direction: Int) throws -> Int {
        let key: CFString
        let reportKey: String

        if direction == 0 {
            // Input report
            key = kIOHIDMaxInputReportSizeKey as CFString
            reportKey = "Input Report"
        } else {
            // Output report
            key = kIOHIDMaxOutputReportSizeKey as CFString
            reportKey = "Output Report"
        }

        // Use a utility function to get the report length
        let reportLength = try getInt32(device: device, key: key)
        if reportLength < 0 {
            print("\(reportKey): Failed to retrieve report length")
            throw FidoError.failedToGetReportLength
        }

        // Check for valid report length
        guard reportLength <= CTAP_MAX_REPORT_LEN else {
            print("\(reportKey): report length \(reportLength) exceeds maximum allowed")
            throw FidoError.invalidReportLength
        }

        return Int(reportLength)
    }

    // Utility function to retrieve an integer value from the HID device
    private func getInt32(device: IOHIDDevice, key: CFString) throws -> Int32 {
        guard let result = IOHIDDeviceGetProperty(device, key) as? NSNumber else {
            throw FidoError.propertyRetrievalFailed
        }
        return result.int32Value // Success, return the value
    }
}

class Fido2Manager {


    func buildCtapHidCborFrame(channelId: UInt32, command: UInt8, payload: Data) -> [Data] {
        let reportSize = 64

        // Header: 4-byte CID + 1-byte CMD (0x80 | command) + 2-byte payload length
        var frames: [Data] = []

        // Initial packet
        var initialHeader = Data()
        initialHeader.append(contentsOf: withUnsafeBytes(of: channelId.bigEndian, Array.init))
        initialHeader.append(0x80 | command) // High bit set
        initialHeader.append(UInt8((payload.count >> 8) & 0xff))
        initialHeader.append(UInt8(payload.count & 0xff))

        let initialPayloadLen = reportSize - initialHeader.count
        let initialPayload = payload.prefix(initialPayloadLen)
        var firstPacket = initialHeader
        firstPacket.append(contentsOf: initialPayload)
        firstPacket.append(contentsOf: repeatElement(0, count: reportSize - firstPacket.count)) // Pad if needed
        frames.append(firstPacket)

        // Continuation packets
        var seq: UInt8 = 0
        var offset = initialPayloadLen
        while offset < payload.count {
            var contHeader = Data()
            contHeader.append(contentsOf: withUnsafeBytes(of: channelId.bigEndian, Array.init))
            contHeader.append(seq)
            let contPayloadLen = min(reportSize - contHeader.count, payload.count - offset)
            let contPayload = payload[offset..<offset+contPayloadLen]

            var contPacket = contHeader
            contPacket.append(contentsOf: contPayload)
            contPacket.append(contentsOf: repeatElement(0, count: reportSize - contPacket.count)) // Pad if needed

            frames.append(contPacket)
            offset += contPayloadLen
            seq += 1
        }

        return frames
    }

    func buildCtapHidFrame(channelId: UInt32, command: UInt8, payload: Data) -> [Data] {
        let reportSize = 64
        var frames: [Data] = []

        // INIT packet header: 4-byte CID, 1-byte (0x80 | CMD), 2-byte payload length
        var initialHeader = Data()
        initialHeader.append(contentsOf: withUnsafeBytes(of: channelId.bigEndian, Array.init))
        initialHeader.append(0x80 | command)
        initialHeader.append(UInt8((payload.count >> 8) & 0xff))
        initialHeader.append(UInt8(payload.count & 0xff))

        let initialPayloadLen = reportSize - initialHeader.count
        let initialPayload = payload.prefix(initialPayloadLen)

        var firstPacket = initialHeader + initialPayload
        firstPacket.append(contentsOf: repeatElement(0, count: reportSize - firstPacket.count))
        frames.append(firstPacket)

        // CONTINUATION packets
        var offset = initialPayloadLen
        var seq: UInt8 = 0

        while offset < payload.count {
            var contHeader = Data()
            contHeader.append(contentsOf: withUnsafeBytes(of: channelId.bigEndian, Array.init))
            contHeader.append(seq)

            let contPayloadLen = min(reportSize - contHeader.count, payload.count - offset)
            let contPayload = payload[offset..<offset + contPayloadLen]

            var contPacket = contHeader + contPayload
            contPacket.append(contentsOf: repeatElement(0, count: reportSize - contPacket.count))
            frames.append(contPacket)

            offset += contPayloadLen
            seq += 1
        }

        return frames
    }

    func buildCtapHidInitFrame(channelId: UInt32, nonce: Data) -> Data {
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


    func open(withHidDevice deviceInfo: FidoDeviceInfo) throws -> FidoDeviceContext {
        let device = deviceInfo.hidDevice

        // Open the device first to ensure it's usable
        let openResult = IOHIDDeviceOpen(device, IOOptionBits(kIOHIDOptionsTypeSeizeDevice))
        guard openResult == kIOReturnSuccess else {
            throw FidoError.failedToOpenDevice
        }

        IOHIDDeviceScheduleWithRunLoop(device, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)

        // Create non-blocking pipe
        var pipeFD: [Int32] = [-1, -1]
        guard Darwin.pipe(&pipeFD) == 0 else {
            throw FidoError.failedToCreatePipe
        }

        setNonBlocking(fd: pipeFD[0])
        setNonBlocking(fd: pipeFD[1])

        print("🛠️ Pipe FDs — read end: \(pipeFD[0]), write end: \(pipeFD[1])")

        // Get input/output report sizes
        let inLen = try getReportLength(device: device, direction: 0)
        let outLen = try getReportLength(device: device, direction: 1)

        // Setup callbacks
        var context = FidoDeviceContext(
            reportInLen: inLen,
            reportOutLen: outLen,
            reportInData: nil,
            reportPipe: pipeFD
        )

        setupHidCallbacks(device: device, context: &context)

        return context
    }

    func setNonBlocking(fd: Int32) {
        var flags = fcntl(fd, F_GETFL, 0)
        if flags != -1 {
            fcntl(fd, F_SETFL, flags | O_NONBLOCK)
        }
    }

    

    func close(
        withHidDevice deviceInfo: FidoDeviceInfo,
        context: inout FidoDeviceContext
    ) throws {
        let device = deviceInfo.hidDevice

        guard var reportData = context.reportInData else {
            throw FidoError.failedToFindReport
        }

        // Ensure reportData is large enough to match the expected report length.
        guard reportData.count >= context.reportInLen else {
            throw FidoError.failedToFindReport
        }

        // Create a mutable pointer to the data
        try reportData.withUnsafeMutableBytes { (rawBufferPointer: UnsafeMutableRawBufferPointer) in
            // Ensure the base address is non-nil and is of the correct type
            guard let reportPointer = rawBufferPointer.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                throw FidoError.failedToFindReport
            }

            // Deregister input report callback
            IOHIDDeviceRegisterInputReportCallback(
                device,
                reportPointer,
                context.reportInLen,
                nil,
                nil
            )
        }

        // Deregister removal callback
        IOHIDDeviceRegisterRemovalCallback(device, nil, nil)

        // Close the HID device
        let closeResult = IOHIDDeviceClose(
            device,
            IOOptionBits(kIOHIDOptionsTypeSeizeDevice)
        )
        if closeResult != kIOReturnSuccess {
            print("Failed to close HID device with error: \(closeResult)")
        }

        // Optionally nil out the context object for safety
        context = FidoDeviceContext()  // Or handle it differently if needed
    }



    func readData(
        from deviceInfo: FidoDeviceInfo,
        context: FidoDeviceContext,
        timeout: Int = 5000
    ) throws -> Data {
        let device = deviceInfo.hidDevice
        var buffer = [UInt8](repeating: 0, count: context.reportInLen)
        var bytesRead = 0
        let startTime = Date()
        let timeoutSeconds = Double(timeout) / 1000.0

        repeat {
            bytesRead = read(context.reportPipe[0], &buffer, context.reportInLen)

            if bytesRead == -1 {
                if errno == EAGAIN || errno == EWOULDBLOCK {
                    usleep(50_000)
                    if Date().timeIntervalSince(startTime) > timeoutSeconds {
                        throw FidoError.readTimedOut
                    }
                    continue
                } else {
                    print("Read error: \(String(cString: strerror(errno)))")
                    throw FidoError.failedToReadPendingFrame
                }
            }

            if bytesRead > 0 {
                let nonZeroBytes = buffer.prefix(bytesRead).contains { $0 != 0 }
                if nonZeroBytes {
                    print("📥 Received data: \(buffer.prefix(bytesRead).map { String(format: "%02x", $0) }.joined(separator: " "))")

                    // ✅ Check for CBOR response
                    let data = Data(buffer.prefix(bytesRead))
                    let payload = data.dropFirst().dropFirst(7) // drop report ID and CTAPHID header

                    if buffer[4] & 0x7F == 0x10 { // command byte masked
                        do {
                            let payloadBytes = [UInt8](payload)
                            print("📦 Raw CBOR bytes: \(payloadBytes.map { String(format: "%02x", $0) }.joined(separator: " "))")

                            let decoded = try CBOR.decode(payloadBytes)
                            print("📦 Top-level decoded CBOR: \(decoded)")

                            if case let .map(cborMap) = decoded {
                                print("📦 Decoded CBOR Map:")
                                for (key, value) in cborMap {
                                    print("🔑 \(key) → \(value)")
                                }
                            } else {
                                print("⚠️ Not a map — likely a raw response code: \(decoded)")
                            }
                        } catch {
                            print("⚠️ CBOR decode error: \(error)")
                        }
                    }
                }
                break
            }

        } while true

        if bytesRead < 0 || bytesRead != context.reportInLen {
            print("Bytes read is not as expected. Read: \(bytesRead), Expected: \(context.reportInLen)")
            throw FidoError.failedToReadData
        }

        return Data(buffer.prefix(bytesRead))
    }


    func waitForAssertionResponse(
        device: FidoDeviceInfo,
        context: FidoDeviceContext,
        timeout: Int = 10000
    ) throws -> Data {
        let deadline = Date().addingTimeInterval(Double(timeout) / 1000.0)

        while Date() < deadline {
            scheduleIOLoop(device: device.hidDevice, ms: 5000)

            let response = try readData(from: device, context: context)

            // Strip report ID and header
            let ctaphid = response.dropFirst()
            guard ctaphid.count >= 7 else { continue }

            let cmd = ctaphid[4] & 0x7F
            let len = Int(ctaphid[5]) << 8 | Int(ctaphid[6])
            let payload = ctaphid.dropFirst(7).prefix(len)

            switch cmd {
            case 0x3B:
                let status = payload.first ?? 0
                print("⏳ KEEPALIVE: \(status == 1 ? "PROCESSING" : "TOUCH REQUIRED")")
            case 0x10:
                print("✅ Got CTAPHID_CBOR response!")
                return Data(payload)
            default:
                print("⚠️ Unexpected response cmd: \(cmd)")
            }
        }

        throw FidoError.readTimedOut
    }


    func scheduleIOLoop(device: IOHIDDevice, ms: Int) {
        let loopID = CFRunLoopMode.defaultMode.rawValue
        // Schedule the device with the current run loop
        IOHIDDeviceScheduleWithRunLoop(device, CFRunLoopGetCurrent(), loopID)

        var timeout: Double = (ms == -1) ? 5.0 : Double(ms) / 1000.0 // Wait 5 seconds by default if ms is -1

        // Run the current run loop for the specified timeout
        CFRunLoopRunInMode(CFRunLoopMode.defaultMode, timeout, true)

        // Unschedule the device from the current run loop
        IOHIDDeviceUnscheduleFromRunLoop(device, CFRunLoopGetCurrent(), loopID)
    }

    // Set up input report and removal callbacks
    private func setupHidCallbacks(device: IOHIDDevice, context: inout FidoDeviceContext) {
        let hidContext = HIDContext(bufferLength: 64, sharedPipe: context.reportPipe)
        context.hidContext = hidContext  // ✅ Retain here

        // Set up input report callback
        context.reportInData = Data(count: context.reportInLen)
        context.reportInData?.withUnsafeMutableBytes { reportPointer in
            IOHIDDeviceRegisterInputReportCallback(
                device,
                hidContext.buffer,
                hidContext.bufferLength,
                inputReportCallback, // This doesn't work
                UnsafeMutableRawPointer(Unmanaged.passUnretained(hidContext).toOpaque())
            )
        }

        // Set up removal callback
        IOHIDDeviceRegisterRemovalCallback(device, { _, _, _  in
            // Handle device removal
        }, nil)
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

struct AssertionCBOR {
    let authData: Data
    let signature: Data
    let userHandle: Data?
    let credentialId: Data
}

struct CtapHidResponse {
    let channelId: UInt32
    let command: UInt8
    let payload: Data
}

func parseCtapHidResponse(_ data: Data) throws -> CtapHidResponse {
    guard data.count >= 7 else {
        throw FidoError.failedToReadData
    }

    let channelId = UInt32(bigEndian: data.prefix(4).withUnsafeBytes { $0.load(as: UInt32.self) })
    let commandByte = data[4]
    let isInit = commandByte & 0x80 != 0
    let command = isInit ? commandByte & 0x7F : commandByte

    let length = Int(data[5]) << 8 | Int(data[6])
    let payload = data.dropFirst(7).prefix(length)

    return CtapHidResponse(channelId: channelId, command: command, payload: payload)
}

func inputReportCallback(
    context: UnsafeMutableRawPointer?,
    result: IOReturn,
    sender: UnsafeMutableRawPointer?,
    type: IOHIDReportType,
    reportID: UInt32,
    report: UnsafeMutablePointer<UInt8>,
    reportLength: CFIndex
) {
    print("inputReportCallback triggered")
    guard let context = context, reportLength > 0 else { return }

    print("📥 Callback report: \(Data(bytes: report, count: reportLength).map { String(format: "%02x", $0) }.joined())")

    let ctx = Unmanaged<HIDContext>.fromOpaque(context).takeUnretainedValue()
    let written = write(ctx.pipe[1], report, reportLength)

    if written == -1 {
        print("❌ Write to pipe failed: \(String(cString: strerror(errno)))")
    } else {
        print("✅ Wrote \(written) bytes to pipe")
    }
}

final class HIDContext {
    let buffer: UnsafeMutablePointer<UInt8>
    let bufferLength: Int
    let pipe: [Int32] // [readFD, writeFD]

    init(bufferLength: Int, sharedPipe: [Int32]) {
        self.bufferLength = bufferLength
        self.buffer = .allocate(capacity: bufferLength)
        self.pipe = sharedPipe
    }

    deinit {
        buffer.deallocate()
        close(pipe[0])
        close(pipe[1])
    }
}

@discardableResult
func setNonBlocking(fd: Int32) -> Bool {
    let flags = fcntl(fd, F_GETFL)
    if flags == -1 { return false }
    return fcntl(fd, F_SETFL, flags | O_NONBLOCK) != -1
}

// Safer FidoDeviceContext using Data
struct FidoDeviceContext {
    var reportInLen: Int = 0
    var reportOutLen: Int = 0
    var reportInData: Data? // Data buffer to store the report

    var reportPipe: [Int32] = [] // Assuming you want to store the pipe file descriptors
    var hidContext: HIDContext?
    var channelId: UInt32?
}



extension Fido2Manager {
    func sendToHidDevice(
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

    func sendCtapHidCborCommand(
        device: IOHIDDevice,
        context: FidoDeviceContext,
        channelId: UInt32,
        payload: Data,
        reportId: CFIndex = 0
    ) throws {
        let command: UInt8 = 0x10 // CTAPHID_CBOR
        let packets = buildCtapHidCborFrame(channelId: channelId, command: command, payload: payload)

        for (i, packet) in packets.enumerated() {
            try sendToHidDevice(
                device: device,
                reportID: reportId,
                data: packet,
                reportType: kIOHIDReportTypeOutput
            )
            print("📨 Sent CBOR packet \(i)")
        }
        scheduleIOLoop(device: device, ms: 5000)
    }


    func initializeCommunication(with device: FidoDeviceInfo) throws {
        let nonce = try Data.random(length: 8) // Generate nonce
        let command: UInt8 = 0x06 // Example command ID for init (replace with actual)
        let reportID: CFIndex = 0 // Define report ID based on your protocol
        let reportType: IOHIDReportType = kIOHIDReportTypeOutput

        var commandData = Data([command])
        commandData.append(nonce) // Append command data with nonce

        try sendToHidDevice(
            device: device.hidDevice,
            reportID: reportID,
            data: commandData,
            reportType: reportType
        )
    }
}

