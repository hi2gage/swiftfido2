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
}
