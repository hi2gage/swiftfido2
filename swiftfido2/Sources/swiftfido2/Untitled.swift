import CryptoKit
import Foundation
//
//  Untitled.swift
//  swiftfido2
//
//  Created by Gage Halverson on 10/23/24.
//
import IOKit.hid
import SwiftCBOR

final public class FIDO {
  public func respondToChallenge(args: ChallengeArgs) async throws -> ChallengeResponse {
    let manager = Fido2Manager()
    let initManager = InitManager()

    // Discover the first available FIDO HID device
    print("🔌 Looking for your security key…")
    guard let device: FidoDeviceInfo = try manager.waitForDevice().first else {
      throw FidoError.deviceNotFound
    }
    var context = try manager.open(withHidDevice: device)
    print("✅ Device opened")

    let channelId = try await initManager.performCTAPHIDInit(device: device, context: context)
    context.channelId = channelId

    let payload = try args.convertToPayload()

    let command: UInt8 = 0x10

    let frame = CTAPHIDCborFrame(channelId: channelId, command: command, payload: payload)

    let report = HIDPackageReport(frame)

    try context.transport.sendReportPackets(report)

    print("🖐️ Waiting for user touch...")

    let assertion = try await manager.waitForAssertionResponse(
      device: device,
      context: context,
      timeout: 5000
    )

    // Clean up when done
    try manager.close(withHidDevice: device, context: &context)
    print("🧹 Device closed")

    let challenge = args.challenge
    let clientDataInput = ClientData(
      challenge: FIDO2.base64ToBase64url(base64: challenge),
      origin: args.origin
    )
    let clientDataJsonData = Data(clientDataInput.json.utf8)
    let clientDataBase64Encoded = (clientDataJsonData).base64EncodedString()

    let signatureData = assertion.signature.base64EncodedString()
    let authenticatorData = assertion.authData.base64EncodedString()
    guard let userHandle = assertion.userHandle else {
      throw FidoError.missingUserHandle
    }
    let credentialID = assertion.credentialID.base64EncodedString()

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

  func extractUserHandle(from cborResponse: Data) throws -> String {
    // 1) Drop the CTAP2 status byte
    let bytes = Array(cborResponse.dropFirst())

    // 2) Decode CBOR
    guard let top = try CBOR.decode(bytes),
      case let CBOR.map(m) = top
    else {
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
      case let CBOR.map(topMap) = top
    else {
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

  public init(
    rpId: String,
    validCredentials: [String],
    devPin: String,
    challenge: String,
    origin: String
  ) {
    self.rpId = rpId
    self.validCredentials = validCredentials
    self.devPin = devPin
    self.challenge = challenge
    self.origin = origin
  }
}

extension ChallengeArgs {
  func convertToPayload() throws -> Data {
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
    let assertion = FidoAssertion(
      rpId: rpId,
      appId: nil,
      clientData: clientData,
      clientDataHash: clientDataHash,
      allowList: allowList,
      userPresence: true,
      userVerification: false
    )

    // Step 4: Encode to CBOR and prepend CTAP2 command (0x02 for GetAssertion)
    let cbor = try assertion.toCBOR()
    var payload = Data([0x02])
    payload.append(cbor)
    return payload
  }
}

struct FidoCredentialDescriptor {
  var id: Data  // The credential ID as raw bytes
  var type: String = "public-key"
  // You could add `transports: [String]?` later if needed
}

struct FidoAssertion {
  var rpId: String  // relying party id
  var appId: String? = nil  // u2f appid, optional
  var clientData: Data = Data()  // client data (JSON)
  var clientDataHash: Data = Data()  // client data SHA-256
  var allowList: [FidoCredentialDescriptor] = []  // allow list
  var userPresence: Bool? = nil
  var userVerification: Bool? = nil
}

extension FidoAssertion {
  func toCBOR() throws -> Data {
    var map: [CBOR: CBOR] = [:]

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
      CBOR.utf8String("id"): CBOR.byteString([UInt8](id)),
    ])
  }
}
