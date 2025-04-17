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

class Fido2Manager {
    func fidoHidDevices(max: Int) throws -> [FidoDeviceInfo] {
        let manager: IOHIDManager = IOHIDManagerCreate(kCFAllocatorDefault, 0)

        IOHIDManagerSetDeviceMatching(manager, nil)
        if let deviceSet = IOHIDManagerCopyDevices(manager) as? Set<IOHIDDevice>, !deviceSet.isEmpty {
            return deviceSet.prefix(max).compactMap { FidoDeviceInfo(from: $0) }
        } else {
            throw FidoError.noDevicesFound
        }
    }

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

        print("🔐 Nonce: \(nonce.map { String(format: "%02x", $0) }.joined(separator: " "))")

        let frame = buildCtapHidInitFrame(channelId: broadcastCID, nonce: nonce)
        try sendToHidDevice(device: device, reportID: reportID, data: frame, reportType: kIOHIDReportTypeOutput)
        print("📨 INIT packet \(frame) sent")

        // Run I/O loop to allow the device to respond
        scheduleIOLoop(device: device, ms: 5000)

        // Wait for response on the pipe using poll
        let rawResponse = try readFromPipe(
            fd: context.reportPipe[0],
            bufferSize: context.reportInLen,
            timeoutMs: 5000
        )

        print("📥 Raw INIT response: \(rawResponse.map { String(format: "%02x", $0) }.joined(separator: " "))")

        // Skip report ID byte at index 0
        guard rawResponse.count >= 1 else {
            print("❌ Response too short to contain report ID.")
            throw FidoError.internalError
        }

        let ctapResponse = rawResponse.dropFirst() // skip report ID
        guard ctapResponse.count >= 17 else {
            print("⚠️ INIT response too short")
            throw FidoError.internalError
        }

        // Skip report ID + 7-byte CTAPHID header
        let payload = rawResponse.dropFirst().dropFirst(7)
        let initResponse = try CTAPHIDInitResponse(data: Data(payload))

        // ✅ Compare echoed nonce
        guard initResponse.nonce == nonce else {
            print("🚨 Nonce mismatch!")
            print("Expected: \(nonce.map { String(format: "%02x", $0) }.joined())")
            print("Got     : \(initResponse.nonce.map { String(format: "%02x", $0) }.joined())")
            throw FidoError.internalError
        }

        print("🆔 Assigned Channel ID: \(String(format: "%08x", initResponse.cid))")

        let newCID = ctapResponse[15..<19].withUnsafeBytes { $0.load(as: UInt32.self).bigEndian }
        print("🆔 Assigned Channel ID: \(String(format: "%08x", newCID))")

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
                    usleep(50_000) // ⏸️ Sleep 50ms
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

    func scheduleIOLoop(device: IOHIDDevice, ms: Int) {
        let loopID = CFRunLoopMode.defaultMode.rawValue
        // Schedule the device with the current run loop
        IOHIDDeviceScheduleWithRunLoop(device, CFRunLoopGetCurrent(), loopID)

        var timeout: Double = (ms == -1) ? 5.0 : Double(ms) / 1000.0 // Wait 5 seconds by default if ms is -1

        // Run the current run loop for the specified timeout
        CFRunLoopRunInMode(CFRunLoopMode.defaultMode, timeout, true)

        // Unschedule the device from the current run loop
//        IOHIDDeviceUnscheduleFromRunLoop(device, CFRunLoopGetCurrent(), loopID)
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

//func decodeGetAssertionCBOR(_ payload: Data) throws -> AssertionCBOR {
//    let cbor = try CBOR.decode(payload)
//
//    guard case let .map(map) = cbor else {
//        throw FidoError.internalError
//    }
//
//    guard
//        let credential = map[CBOR.unsignedInt(1)],
//        case let .map(credMap) = credential,
//        let credId = credMap[CBOR.utf8String("id")],
//        case let .byteString(idBytes) = credId,
//        let authData = map[CBOR.unsignedInt(2)],
//        case let .byteString(authBytes) = authData,
//        let signature = map[CBOR.unsignedInt(3)],
//        case let .byteString(sigBytes) = signature
//    else {
//        throw FidoError.internalError
//    }
//
//    var userHandleData: Data? = nil
//    if let userHandle = map[CBOR.unsignedInt(4)], case let .byteString(userBytes) = userHandle {
//        userHandleData = Data(userBytes)
//    }
//
//    return AssertionCBOR(
//        authData: Data(authBytes),
//        signature: Data(sigBytes),
//        userHandle: userHandleData,
//        credentialId: Data(idBytes)
//    )
//}

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
}



extension Fido2Manager {
    func sendToHidDevice(
        device: IOHIDDevice,
        reportID: CFIndex = 0,
        data: Data,
        reportType: IOHIDReportType
    ) throws {
        var fullReport = Data([UInt8(reportID)]) // 1-byte report ID
        fullReport.append(data)

        let result = fullReport.withUnsafeBytes { (buffer: UnsafeRawBufferPointer) -> IOReturn in
            let reportPtr = buffer.bindMemory(to: UInt8.self).baseAddress!
            return IOHIDDeviceSetReport(device, reportType, reportID, reportPtr, buffer.count)
        }

        guard result == kIOReturnSuccess else {
            print("❌ Failed to send report. IOReturn: \(result)")
            throw FidoError.txError
        }

        print("📨 INIT packet \(fullReport.count) bytes sent")
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

extension Fido2Manager {
    public func respondToChallenge(args: ChallengeArgs) throws -> ChallengeResponse {
        let challenge = args.challenge
        let rpId = args.rpId
        let devPin = args.devPin

        let clientDataInput = ClientData(challenge: FIDO2.base64ToBase64url(base64: challenge), origin: args.origin)
        let clientDataJsonData = Data(clientDataInput.json.utf8)
        let clientDataBase64Encoded = (clientDataJsonData).base64EncodedString()

        let clientDataHash = [UInt8](SHA256.hash(data: clientDataJsonData))

        let validCredentials = args.validCredentials

        let fa: OpaquePointer? = nil

        try setValidCredentials(validCredentials, forAssertion: fa)


        // Find First HIDDevice
        guard let device = try self.fidoHidDevices(max: 12).first else {
            throw FidoError.noDevicesFound
        }
        let context = try self.open(withHidDevice: device)



        guard let matchingCredId = try getMatchingCredId(
            from: device,
            validCredentials: validCredentials,
            rpId: rpId,
            devPin: devPin
        ) else {
            // The device has no valid credentials, we cannot continue
            throw FidoError.errorNoValidCredentials
        }

        let signatureDataBase64Str = ""
        let authDataBase64Str = ""
        let userHandleBase64Str = ""


        return ChallengeResponse(
            challenge: challenge,
            clientData: clientDataBase64Encoded,
            signatureData: signatureDataBase64Str,
            authenticatorData: authDataBase64Str,
            userHandle: userHandleBase64Str,
            credentialID: matchingCredId,
            rpId: rpId
        )
    }

    private func getMatchingCredId(
        from device: FidoDeviceInfo, // Changed from OpaquePointer? to a more specific type
        validCredentials: [String],
        rpId: String,
        devPin: String
    ) throws -> String? {
//        var residentKeys = fido_credman_rk_new() // Resident credentials array
//        defer { fido_credman_rk_free(&residentKeys) }
//
//        // Call the function to get resident keys from the device
//        let result = fido_credman_get_dev_rk(device.hidDevice, rpId, residentKeys, devPin)
//        guard result == FIDO_OK else {
//            throw FidoError.libfido2ErrorInternal(result)
//        }
//
//        // Get the count of resident keys
//        let rkCount = fido_credman_rk_count(residentKeys)
//        for i in 0..<rkCount {
//            let credential = fido_credman_rk(residentKeys, i)
//
//            // Get the credential ID pointer and length
//            guard let idPtr = fido_cred_id_ptr(credential) else {
//                throw FidoError.internalError
//            }
//            let idLen = fido_cred_id_len(credential)
//
//            // Create Data from the credential ID bytes
//            let idData = Data(bytes: idPtr, count: idLen)
//            let idBase64 = idData.base64EncodedString()
//
//            // Check if the base64 encoded ID is in the valid credentials
//            if validCredentials.contains(idBase64) {
//                return idBase64 // Return the first found, valid credential
//            }
//        }

        return nil // No valid credentials found
    }

    private func setValidCredentials(_ validCredentials: [String], forAssertion fa: OpaquePointer?) throws {
        for cred in validCredentials {
            guard let credD = Data(base64Encoded: cred) else {
                throw FidoError.inputErrorInvalidCredentialsArray
            }
            let ptr = credD.withUnsafeBytes { rawPtr in
                return rawPtr.baseAddress?.assumingMemoryBound(to: UInt8.self)
            }
//            fido_assert_allow_cred(fa, ptr, credD.count)
        }
    }
}

private struct ClientData {
    let type: String = "webauthn.get"
    let challenge: String
    let origin: String
    let crossOrigin: Bool = true

    var json: String {
"""
{"type":"\(type)","challenge":"\(challenge)","origin":"\(origin)","crossOrigin":\(crossOrigin)}
"""
    }
}

public struct ChallengeResponse: Encodable {
    public let challenge: String
    public let clientData: String
    public let signatureData: String
    public let authenticatorData: String
    public let userHandle: String
    public let credentialID: String
    public let rpId: String
}

public struct ChallengeArgs {
    public let rpId: String
    public let validCredentials: [String]
    public let devPin: String
    public let challenge: String
    public let origin: String

    public init(rpId: String, validCredentials: [String], devPin: String, challenge: String, origin: String) {
        self.rpId = rpId
        self.validCredentials = validCredentials
        self.devPin = devPin
        self.challenge = challenge
        self.origin = origin
    }
}

extension ChallengeArgs {
    func toGetAssertionPayload() throws -> Data {
        // Step 1: Build clientDataJSON
        let clientDataJSON = """
        {"type":"webauthn.get","challenge":"\(FIDO2.base64ToBase64url(base64: challenge))","origin":"\(origin)","crossOrigin":true}
        """
        let clientData = Data(clientDataJSON.utf8)
        let clientDataHash = Data(SHA256.hash(data: clientData))

        // Step 2: Convert validCredentials to [FidoCredentialDescriptor]
        let allowList: [FidoCredentialDescriptor] = try validCredentials.map { base64 in
            guard let data = Data(base64Encoded: base64) else {
                throw FidoError.inputErrorInvalidCredentialsArray
            }
            return FidoCredentialDescriptor(id: data)
        }

        // Step 3: Fill FidoAssertion with ChallengeArgs
        var assertion = FidoAssertion()
        assertion.setRpId(rpId)
        assertion.clientData = clientData
        assertion.clientDataHash = clientDataHash
        assertion.allowList = allowList
        assertion.userPresence = true
        assertion.userVerification = true

        // Step 4: Encode to CBOR and prepend CTAP2 command (0x02 for GetAssertion)
        let cbor = try assertion.toCBOR()
        var payload = Data([0x02])
        payload.append(cbor)
        return payload
    }
}


struct FIDO2 {
    public static func base64urlToBase64(base64url: String) -> String {
        var base64 = base64url
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        if base64.count % 4 != 0 {
            base64.append(String(repeating: "=", count: 4 - base64.count % 4))
        }
        return base64
    }

    public static func base64ToBase64url(base64: String) -> String {
        let base64url = base64
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
        return base64url
    }
}
