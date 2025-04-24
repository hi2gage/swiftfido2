import Foundation
import IOKit.hid

class InitManager {
    func performCTAPHIDInit(
        device: FidoDeviceInfo, context: FidoDeviceContext, reportID: CFIndex = 0, timeoutMs: Int = 5000
    ) async throws -> UInt32 {
        let nonce = try Data.random(length: CTAPHIDInitFrame.nonceSize)
        
        let initFrame = CTAPHIDInitFrame(
            channelId: CTAPHIDInitFrame.broadcastCID,
            nonce: nonce
        )
        let report = HIDReport(initFrame)
        try context.transport.sendReport(report)
        
        // Wait for response
        
        let response = try await readInitResponse(context: context, timeoutMs: timeoutMs)
        
        guard response.nonce == nonce else {
            throw FidoError.nonceMismatch
        }
        
        return response.channelId
    }
    
    private func readInitResponse(
        context: FidoDeviceContext,
        timeoutMs: Int
    ) async throws -> CTAPHIDInitPayload {
        let raw = try await context.transport.readAsync(timeoutMs: timeoutMs)
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
            nonce = payload[0..<8]
            channelId = payload[8..<12].withUnsafeBytes { $0.load(as: UInt32.self).bigEndian }
            protocolVersion = payload[12]
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
            let length = Int(packet[5]) << 8 | Int(packet[6])
            guard packet.count >= 7 + length, length >= 17
            else { throw FidoError.lengthMismatch }
            // 3. take the 17‑byte payload
            let payload = packet[7..<7 + 17]
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
