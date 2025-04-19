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

public class Fido2Manager {


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
      timeout: Int = 10_000
    ) throws -> Data {
      let deadline = Date().addingTimeInterval(Double(timeout)/1000)
      var assembled     = Data()
      var expectedLength: Int?
      var cid: Data?

      while Date() < deadline {
        scheduleIOLoop(device: deviceInfo.hidDevice, ms: 10)

        var buf = [UInt8](repeating: 0, count: context.reportInLen)
        let n   = read(context.reportPipe[0], &buf, context.reportInLen)

        guard n > 0 else {
          if errno == EAGAIN || errno == EWOULDBLOCK {
            usleep(50_000)
            continue
          }
          throw FidoError.failedToReadPendingFrame
        }

        let raw = Data(buf.prefix(n))
        print("📥 Received data: \(raw.map { String(format: "%02x", $0) }.joined(separator: " "))")

        // must be at least 7 bytes for header+length
        guard raw.count >= 7 else {
          print("⚠️ Packet too short, skipping")
          continue
        }

        // parse the CTAPHID packet in-place (no dropFirst!)
        let packetCID = raw[0..<4]
        let cmdByte   = raw[4]
        let isInit    = (cmdByte & 0x80) != 0
        let cmd       = cmdByte & 0x7F

        // remember which channel we’re on
        if cid == nil {
          cid = packetCID
        } else if cid! != packetCID {
          print("⚠️ CID mismatch, skipping packet")
          continue
        }

        // continuation = any packet where high‑bit is cleared
        if !isInit {
          guard let total = expectedLength else {
            print("⚠️ Continuation before INIT – skipping")
            continue
          }
          let fullPayload = raw.dropFirst(5)             // [CID(4), SEQ(1)] gone
          let remaining   = total - assembled.count      // how many bytes we really need
          let chunk       = fullPayload.prefix(remaining)
          assembled.append(contentsOf: chunk)
          print("➕ CONT frame appended: \(assembled.count)/\(total)")

          if assembled.count == total {
            print("✅ Full CBOR payload received (\(total) bytes)")
            return assembled
          }
          continue
        }

        // INIT packet – switch on actual command
        switch cmd {
        case 0x10:  // CTAPHID_CBOR initial packet
          let len = Int(raw[5])<<8 | Int(raw[6])
          expectedLength = len
          let firstPayload = raw.dropFirst(7).prefix(len)
          assembled = Data(firstPayload)
          print("📦 CBOR INIT frame: expected total \(len) bytes")

          if assembled.count == len {
            print("✅ Full CBOR payload received (\(len) bytes)")
            return assembled
          }

        case 0x3B:  // KEEPALIVE
          let status = raw[7]
          print("⏳ KEEPALIVE: \(status == 1 ? "Processing" : "Touch Required")")
          continue

        default:
          print("⚠️ Unexpected CTAPHID_INIT cmd: 0x\(String(cmd, radix: 16))")
          continue
        }
      }

      throw FidoError.readTimedOut
    }

    func waitForAssertionResponse(
        device: FidoDeviceInfo,
        context: FidoDeviceContext,
        timeout: Int = 10_000
    ) throws -> Data {
        // readData already blocks until it has the *entire* CBOR payload
        let cborPayload = try readData(from: device, context: context, timeout: timeout)
        return cborPayload
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

