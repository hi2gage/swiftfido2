import IOKit.hid
import Foundation

class InitManager {
    func performCTAPHIDInit(
        device: IOHIDDevice,
        context: FidoDeviceContext,
        reportID: CFIndex = 0,
        timeoutMs: Int = 5000
    ) throws -> UInt32 {
        let nonce = try Data.random(length: CTAPHIDInitFrame.nonceSize)

        let initFrame = CTAPHIDInitFrame(
            channelId: CTAPHIDInitFrame.broadcastCID,
            nonce: nonce
        )
        let report = HIDReport(initFrame)
        try device.sendReport(report)

        // Wait for response
        scheduleIOLoop(device: device, ms: timeoutMs)

        let response = try readInitResponse(
            fd: context.reportPipe[0],
            bufferSize: context.reportInLen,
            timeoutMs: timeoutMs
        )

        guard response.nonce == nonce else {
            throw FidoError.nonceMismatch
        }

        return response.channelId
    }

    private func scheduleIOLoop(device: IOHIDDevice, ms: Int) {
        IOHIDDeviceScheduleWithRunLoop(device, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)
        CFRunLoopRunInMode(CFRunLoopMode.defaultMode, Double(ms)/1000.0, true)
        IOHIDDeviceUnscheduleFromRunLoop(device, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)
    }

    private func rawReadFromPipe(
        fd: Int32,
        bufferSize: Int,
        timeoutMs: Int
    ) throws -> Data {
        var pfd = pollfd(fd: fd, events: Int16(POLLIN), revents: 0)
        let result = poll(&pfd, 1, Int32(timeoutMs))
        guard result > 0 else {
            throw result == 0 ? CTAPHIDError.timedOut : CTAPHIDError.ioError(errno: errno)
        }

        var buf = [UInt8](repeating: 0, count: bufferSize)
        let n = read(fd, &buf, bufferSize)
        guard n > 0 else {
            throw CTAPHIDError.ioError(errno: errno)
        }

        return Data(buf.prefix(n))
    }


    private func readInitResponse(
        fd: Int32,
        bufferSize: Int,
        timeoutMs: Int
    ) throws -> CTAPHIDInitPayload {
        let raw = try rawReadFromPipe(fd: fd, bufferSize: bufferSize, timeoutMs: timeoutMs)
        return try CTAPHIDInitPayload(rawReport: raw)
    }

    struct FirmwareVersion {
        let major: UInt8
        let minor: UInt8
        let build: UInt8
    }


    struct CTAPHIDInitPayload {
        let nonce: Data
        let channelId: UInt32
        let protocolVersion: UInt8
        let firmware: FirmwareVersion
        let flags: CapabilityFlags
        
        init(payload: Data) throws {
            guard payload.count >= 17 else { throw FidoError.internalError }
            nonce            = payload[0..<8]
            channelId        = payload[8..<12].withUnsafeBytes { $0.load(as: UInt32.self).bigEndian }
            protocolVersion  = payload[12]
            firmware = FirmwareVersion(
                major: payload[13],
                minor: payload[14],
                build: payload[15]
            )
            flags = CapabilityFlags(rawValue: payload[16])
        }
        
        init(rawReport: Data) throws {
            // 1. strip 1‑byte reportID
            let packet = rawReport.dropFirst()
            // 2. parse header & length
            guard packet.count >= 7 else { throw FidoError.tooShort }
            let cmdByte = packet[4]
            guard cmdByte & 0x80 != 0, (cmdByte & 0x7F) == CTAPHIDCommand.`init`.rawValue
            else { throw FidoError.invalidCommand }
            let length = Int(packet[5])<<8 | Int(packet[6])
            guard packet.count >= 7 + length, length >= 17
            else { throw FidoError.lengthMismatch }
            // 3. take the 17‑byte payload
            let payload = packet[7..<7+17]
            // now hand off to your existing init(data:)
            try self.init(payload: Data(payload))
        }
    }
}


enum CTAPHIDError: Error {
    case timedOut
    case ioError(errno: Int32)
    case invalidPacket
    case unexpectedCommand(CTAPHIDCommand)
    case txError(IOReturn)
}

extension Data {
    var hex: String { map { String(format: "%02x", $0) }.joined(separator: " ") }
}


struct CapabilityFlags: OptionSet {
    let rawValue: UInt8
    static let wink = CapabilityFlags(rawValue: 0x01)
    static let cbor = CapabilityFlags(rawValue: 0x04)
    static let nmsg = CapabilityFlags(rawValue: 0x08)
    // …future bits reserved
}

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
    )
    {
        self.reportID   = reportID
        self.reportType = reportType
        self.data       = initFrame.raw
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

extension IOHIDDevice {
    /// Send a HID report, throwing a nice error on failure.
    func sendReport(_ report: HIDReport) throws {
        let result = report.data.withUnsafeBytes { buf -> IOReturn in
            IOHIDDeviceSetReport(
                self,
                report.reportType,
                report.reportID,
                buf.bindMemory(to: UInt8.self).baseAddress!,
                buf.count
            )
        }
        guard result == kIOReturnSuccess else {
            throw CTAPHIDError.txError(result)
        }
    }
}
