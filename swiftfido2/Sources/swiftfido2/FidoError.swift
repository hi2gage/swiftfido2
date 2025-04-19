//
//  Untitled.swift
//  swiftfido2
//
//  Created by Gage Halverson on 10/23/24.
//

enum FidoError: Error {
    case invalidArgument
    case internalError
    case txError
    case rxError
    case noDevicesFound
    case deviceNotFound
    case failedToOpenDevice
    case failedToGetReportLength

    case failedToFindReport

    case FidoDeviceContext
    case failedToReadData
    case kIOReturnUnderrun

    case invalidReportLength

    case propertyRetrievalFailed
    case operationTimedOut

    case failedToReadPendingFrame

    case failedToCreatePipe
    case errorNoValidCredentials

    case inputErrorInvalidCredentialsArray
    case libfido2ErrorInternal(Int32)

    case missingRpId
    case readTimedOut

    case missingAuthData
    case invalidCBOR
    case missingField(String)
    case unexpectedFieldType(String)


    case missingCredential
    case missingSignature
    case missingUserHandle
    case invalidUserHandle

    case missingCredentialID
    
}
