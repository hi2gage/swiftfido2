import Foundation
import IOKit
import IOKit.usb
import IOKit.hid
import Security
import SwiftCBOR

extension Optional where Wrapped == CFTypeRef {
    var int16Value: Int16? {
        guard let value = self else { return nil }
        // Attempt to cast to NSNumber
        if let number = value as? NSNumber {
            return number.int16Value
        }
        return nil
    }
}

struct FidoCredentialDescriptor {
    var id: Data   // The credential ID as raw bytes
    var type: String = "public-key"
    // You could add `transports: [String]?` later if needed
}

extension FidoCredentialDescriptor {
    func toCBOR() -> CBOR {
        return CBOR.map([
            CBOR.utf8String("type"): CBOR.utf8String(type),
            CBOR.utf8String("id"): CBOR.byteString([UInt8](id))
        ])
    }
}

struct FidoAssertion {
    var rpId: String? = nil                  // relying party id
    var appId: String? = nil                 // u2f appid, optional
    var clientData: Data = Data()            // client data (JSON)
    var clientDataHash: Data = Data()        // client data SHA-256
    var allowList: [FidoCredentialDescriptor] = [] // allow list
    var userPresence: Bool? = nil
    var userVerification: Bool? = nil
    // stmt fields omitted for now

    init() {}

    mutating func setRpId(_ rpId: String) {
        self.rpId = rpId
    }

    mutating func setClientDataHash(_ hash: Data) {
        self.clientDataHash = hash
    }

    mutating func allowCredential(_ descriptor: FidoCredentialDescriptor) {
        self.allowList.append(descriptor)
    }

    mutating func setAllowList(_ list: [FidoCredentialDescriptor]) {
        self.allowList = list
    }

    mutating func requireUserPresence(_ required: Bool) {
        self.userPresence = required
    }

    mutating func requireUserVerification(_ required: Bool) {
        self.userVerification = required
    }
}

extension FidoAssertion {
    func toCBOR() throws -> Data {
        var map: [CBOR: CBOR] = [:]

        // Ensure rpId is present
        guard let rpId = self.rpId else {
            throw FidoError.missingRpId
        }

        // Map key 1: rpId
        map[CBOR.unsignedInt(1)] = CBOR.utf8String(rpId)

        // Map key 2: clientDataHash
        map[CBOR.unsignedInt(2)] = CBOR.byteString([UInt8](clientDataHash))

        // Map key 3: allowList (if not empty)
        if !allowList.isEmpty {
            let descriptors = allowList.map { $0.toCBOR() }
            map[CBOR.unsignedInt(3)] = CBOR.array(descriptors)
        }

        // Map key 5: options (if any)
        var optionsMap: [CBOR: CBOR] = [:]
        if let up = userPresence {
            optionsMap[CBOR.utf8String("up")] = CBOR.boolean(up)
        }
        if let uv = userVerification {
            optionsMap[CBOR.utf8String("uv")] = CBOR.boolean(uv)
        }
        if !optionsMap.isEmpty {
            map[CBOR.unsignedInt(5)] = CBOR.map(optionsMap)
        }

        // Encode the CBOR map to Data
        return Data(CBOR.map(map).encode())
    }
}

func buildCtapHidFrame(channelId: UInt32, command: UInt8, payload: Data) -> [Data] {
    let reportSize = 64
    var frames: [Data] = []

    // Initial header (CTAPHID framing)
    var initHeader = Data()
    initHeader.append(contentsOf: withUnsafeBytes(of: channelId.bigEndian, Array.init)) // 4-byte CID
    initHeader.append(command) // 1-byte command (no 0x80 prefix)
    initHeader.append(UInt8((payload.count >> 8) & 0xFF)) // payload length high byte
    initHeader.append(UInt8(payload.count & 0xFF))        // payload length low byte

    let initPayloadLen = reportSize - initHeader.count
    let firstChunk = payload.prefix(initPayloadLen)

    var firstPacket = initHeader
    firstPacket.append(firstChunk)
    firstPacket.append(contentsOf: repeatElement(0, count: reportSize - firstPacket.count)) // Padding
    frames.append(firstPacket)

    // Continuation packets
    var seq: UInt8 = 0
    var offset = initPayloadLen
    while offset < payload.count {
        var contHeader = Data()
        contHeader.append(contentsOf: withUnsafeBytes(of: channelId.bigEndian, Array.init)) // 4-byte CID
        contHeader.append(seq) // 1-byte sequence number

        let remaining = payload.count - offset
        let chunkSize = min(reportSize - contHeader.count, remaining)
        let chunk = payload[offset..<offset + chunkSize]

        var contPacket = contHeader
        contPacket.append(chunk)
        contPacket.append(contentsOf: repeatElement(0, count: reportSize - contPacket.count)) // Padding

        frames.append(contPacket)
        offset += chunkSize
        seq += 1
    }

    return frames
}


// Usage
do {
    let manager = Fido2Manager()

    // Discover the first available FIDO HID device
    guard let device = try manager.fidoHidDevices(max: 12).first else {
        throw FidoError.noDevicesFound
    }

    print("🔌 Found device: \(device)")


    // Open and prepare the HID device
    var context = try manager.open(withHidDevice: device)
    print("✅ Device opened")

    let cid = try manager.performCTAPHIDInit(device: device.hidDevice, context: context)
    print("channel Id: \(cid)")
//
//    let args = ChallengeArgs(
//        rpId: "apple.com",
//        validCredentials: [
//            "AWTfjKY41xtrsVg2ez/RQWCKyfGKaD7ynOPAvo6MYGSfY9DVPRmKAEoT5vXlG+J1",
//            "LYFamNBEyYpSMdk6/bZLzkdUpo++xOpf76Ripk932YKz1cqcIXMYaOw0KZPig6EC"
//        ],
//        devPin: "2593",
//        challenge: "IbT4WvTPiHHx722yD5QEKeMbqDSMcjmIak8HXnr6fn0=",
//        origin: "https://idmsa.apple.com"
//    )
//
//
//    let payload = try args.toGetAssertionPayload()
//
//    // 🧪 Print the CTAP2 payload in hex
//    print("📤 CTAP2 GetAssertion payload:")
//    print(payload.map { String(format: "%02x", $0) }.joined(separator: " "))
//
//
//    let packets = buildCtapHidCborFrame(channelId: 0xffffffff, payload: payload)
//    for (i, packet) in packets.enumerated() {
//        try packet.withUnsafeBytes { rawBuffer in
//            guard let ptr = rawBuffer.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
//                throw FidoError.txError
//            }
//
//            let result = IOHIDDeviceSetReport(
//                device.hidDevice,
//                kIOHIDReportTypeOutput,
//                0, // Report ID (0 unless using numbered reports)
//                ptr,
//                packet.count
//            )
//
//            if result != kIOReturnSuccess {
//                throw FidoError.txError
//            }
//
//            print("📨 Sent packet \(i)")
//        }
//    }
//
//    // 🧪 Next step: replace this with your own CTAP2 frame construction
//    // Instead of fido_assert_set_rp, you'll need to build the CTAP2 GetAssertion command
//    // which includes setting the rpId
//    print("🛠️ Ready to begin CTAP2 GetAssertion frame construction...")
//
//    let responseData = try manager.readData(from: device, context: context)
//    print("📥 Received response: \(responseData.map { String(format: "%02x", $0) }.joined(separator: " "))")

    // Clean up when done
    try manager.close(withHidDevice: device, context: &context)
    print("🧹 Device closed")

} catch {
    print("❌ Error: \(error)")
}


extension Data {
    /// Returns cryptographically secure random data.
    ///
    /// - Parameter length: Length of the data in bytes.
    /// - Returns: Generated data of the specified length.
    static func random(length: Int) throws -> Data {
        return Data((0 ..< length).map { _ in UInt8.random(in: UInt8.min ... UInt8.max) })
    }
}






