//
//  File.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/17/25.
//

import Foundation

/*

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




 */

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





