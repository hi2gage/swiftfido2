//
//  Untitled.swift
//  swiftfido2
//
//  Created by Gage Halverson on 10/23/24.
//
import IOKit.hid
import Foundation
import SwiftCBOR
import CryptoKit

final public class FIDO {
    public func respondToChallenge(args: ChallengeArgs) throws -> ChallengeResponse {
        let manager = Fido2Manager()
        let initManager = InitManager()

        // Discover the first available FIDO HID device
        print("🔌 Looking for your security key…")
        guard let device = try manager.waitForDevice().first else {
            throw FidoError.deviceNotFound
        }
        print("🔌 Found device: \(device)")


        // Open and prepare the HID device
        var context = try manager.open(withHidDevice: device)
        print("✅ Device opened")

        let cid = try initManager.performCTAPHIDInit(device: device.hidDevice, context: context)
        print("channel Id: \(String(format: "%08x", cid))")
        context.channelId = cid


        let payload = try args.toGetAssertionPayload()

        // 🧪 Print the CTAP2 payload in hex
        print("📤 CTAP2 GetAssertion payload:")
        print(payload.map { String(format: "%02x", $0) }.joined(separator: " "))


        try manager.sendCtapHidCborCommand(
            device: device.hidDevice,
            context: context,
            channelId: cid,
            payload: payload,
            reportId: 0
        )


        print("🖐️ Waiting for user touch...")

        let cborResponse = try manager.waitForAssertionResponse(device: device, context: context, timeout: 5000)

        // Clean up when done
        try manager.close(withHidDevice: device, context: &context)
        print("🧹 Device closed")

        let challenge = args.challenge
        let clientDataInput = ClientData(challenge: FIDO2.base64ToBase64url(base64: challenge), origin: args.origin)
        let clientDataJsonData = Data(clientDataInput.json.utf8)
        let clientDataBase64Encoded = (clientDataJsonData).base64EncodedString()

        debugPrintCBORResponse(cborResponse)

        let signatureData = try extractSignature(from: cborResponse)
        let authenticatorData = try extractAuthData(from: cborResponse)
        let userHandle = try extractUserHandle(from: cborResponse)
        let credentialID = try extractCredentialID(from: cborResponse)

        return ChallengeResponse(
            challenge: args.challenge,
            clientData: clientDataBase64Encoded,
            signatureData: signatureData,
            authenticatorData: authenticatorData,
            userHandle: userHandle,
            credentialID: credentialID,
            rpId: args.rpId
        )
    }

    enum FIDO2Error: Error {
      case invalidCBOR
      case missingSignature
    }

    /// Given the raw CBOR payload from the CTAP2 GetAssertion response,
    /// decode it and pull out the "signature" byte string.
    func extractSignature(from cborResponse: Data) throws -> String {
        // Skip the one‑byte CTAP2 status (0x00)
        let cborBytes = [UInt8](cborResponse.dropFirst())

        // Decode the real CBOR map
        guard let topLevel = try CBOR.decode(cborBytes),
              case let .map(m) = topLevel
        else {
            throw FidoError.invalidCBOR
        }

        // Pull out the signature under key = 3
        guard let sigItem = m[.unsignedInt(3)],
              case let .byteString(bytes) = sigItem
        else {
            throw FidoError.missingSignature
        }

        // Base64‑encode and return
        return Data(bytes).base64EncodedString()
    }

    func extractAuthData(from cborResponse: Data) throws -> String {
        // 1) Skip the first status byte
        let payloadBytes = Array(cborResponse.dropFirst())

        // 2) Decode the remaining CBOR
        guard let cborValue = try CBOR.decode(payloadBytes) else {
            throw FidoError.invalidCBOR
        }

        // 3) Unwrap the top‑level map
        guard case let CBOR.map(m) = cborValue else {
            throw FidoError.invalidCBOR
        }

        // 4) Extract key=2 → authData
        guard case let CBOR.byteString(bytes)? = m[.unsignedInt(2)] else {
            throw FidoError.missingAuthData
        }

        // 5) Base64‑encode and return
        return Data(bytes).base64EncodedString()
    }

    func extractUserHandle(from cborResponse: Data) throws -> String {
        // 1) Drop the CTAP2 status byte
        let bytes = Array(cborResponse.dropFirst())

        // 2) Decode CBOR
        guard let top = try CBOR.decode(bytes),
              case let CBOR.map(m) = top else {
            throw FidoError.invalidCBOR
        }

        // 3) Find the nested map at key=4
        guard case let CBOR.map(userMap)? = m[.unsignedInt(4)] else {
            throw FidoError.missingUserHandle
        }

        // 4) From that map, grab the "id" field
        guard case let CBOR.byteString(idBytes)? = userMap[.utf8String("id")] else {
            throw FidoError.missingUserHandle
        }

        // 5) Convert to UTF‑8 string (or base64 if you really want)
        guard let handle = String(data: Data(idBytes), encoding: .utf8) else {
            throw FidoError.invalidUserHandle
        }

        return handle
    }


    func extractCredentialID(from cborResponse: Data) throws -> String {
        // 1) Strip off the CTAP2 status byte
        let payloadBytes = Array(cborResponse.dropFirst())

        // 2) Decode the CBOR
        guard let top = try CBOR.decode(payloadBytes),
              case let CBOR.map(topMap) = top else {
            throw FidoError.invalidCBOR
        }

        // 3) Look up key=1 → the credential descriptor map
        guard case let CBOR.map(credMap)? = topMap[.unsignedInt(1)] else {
            throw FidoError.missingCredentialID
        }

        // 4) From that map, grab the byteString at key="id"
        guard case let CBOR.byteString(idBytes)? = credMap[.utf8String("id")] else {
            throw FidoError.missingCredentialID
        }

        // 5) Base64‑encode (or UTF‑8 if you expect it to be text)
        return Data(idBytes).base64EncodedString()
    }

    func getSignatureBase64(from responseMap: [CBOR: CBOR]) throws -> String {
        let signatureKey = CBOR.unsignedInt(3)

        guard let signatureCBOR = responseMap[signatureKey] else {
            throw FidoError.missingField("signature")
        }

        guard case let .byteString(signatureBytes) = signatureCBOR else {
            throw FidoError.unexpectedFieldType("signature")
        }

        let signatureData = Data(signatureBytes)
        return signatureData.base64EncodedString()
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
    private var fidoDev: OpaquePointer?

    public init() {}
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

func debugPrintCBORResponse(_ data: Data) {
    guard data.count > 1 else {
        print("❌ Too short to contain a status + CBOR")
        return
    }

    // 1) Peel off the CTAP2 status
    let status = data[0]
    print("⚪️ CTAP2 status: 0x\(String(format: "%02x", status)) (\(status == 0 ? "success" : "error"))\n")

    // 2) The rest is actual CBOR
    let cborData = data.advanced(by: 1)
    let hex = cborData.map { String(format: "%02x", $0) }.joined(separator: " ")
    print("📦 Raw CBOR payload (\(cborData.count) bytes):\n\(hex)\n")

    // 3) Decode & pretty‐print
    do {
        guard let cbor = try CBOR.decode([UInt8](cborData)) else {
            print("❌ CBOR.decode returned nil")
            return
        }
        print("🗄️ Decoded CBOR:")
        printCBOR(cbor)
    } catch {
        print("❌ CBOR.decode error:", error)
    }
}

/// Recursively prints a CBOR value with indentation.
private func printCBOR(_ item: CBOR, indent: String = "") {
    switch item {
    case .map(let m):
        print("\(indent){")
        for (key, value) in m {
            print("\(indent)  Key:")
            printCBOR(key, indent: indent + "    ")
            print("\(indent)  Value:")
            printCBOR(value, indent: indent + "    ")
        }
        print("\(indent)}")

    case .array(let arr):
        print("\(indent)[")
        for v in arr {
            printCBOR(v, indent: indent + "  ")
        }
        print("\(indent)]")

    case .unsignedInt(let u):
        print("\(indent)\(u) (UInt)")

    case .negativeInt(let n):
        print("\(indent)\(n) (NInt)")

    case .byteString(let bytes):
        let h = bytes.map { String(format: "%02x", $0) }.joined(separator: " ")
        print("\(indent)Bytes(\(bytes.count)): <\(h)>")

    case .utf8String(let s):
        print("\(indent)String: “\(s)”")

    case .boolean(let b):
        print("\(indent)Bool: \(b)")

    case .null:
        print("\(indent)null")

    case .undefined:
        print("\(indent)undefined")

    case .half(let h):
        print("\(indent)Half‑float: \(h)")

    case .float(let f):
        print("\(indent)Float: \(f)")

    case .double(let d):
        print("\(indent)Double: \(d)")

    case .simple(let s):
        print("\(indent)Simple: \(s)")

    case .tagged(let tag, let v):
        print("\(indent)Tag(\(tag)):")
        printCBOR(v, indent: indent + "  ")
    case .break:
        print("\(indent)<break>")
    case .date(let date):
        print("\(indent)Date: \(date)")
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
        assertion.userVerification = false

        // Step 4: Encode to CBOR and prepend CTAP2 command (0x02 for GetAssertion)
        let cbor = try assertion.toCBOR()
        var payload = Data([0x02])
        payload.append(cbor)
        return payload
    }
}


struct FidoCredentialDescriptor {
    var id: Data   // The credential ID as raw bytes
    var type: String = "public-key"
    // You could add `transports: [String]?` later if needed
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

extension FidoCredentialDescriptor {
    func toCBOR() -> CBOR {
        return CBOR.map([
            CBOR.utf8String("type"): CBOR.utf8String(type),
            CBOR.utf8String("id"): CBOR.byteString([UInt8](id))
        ])
    }
}
