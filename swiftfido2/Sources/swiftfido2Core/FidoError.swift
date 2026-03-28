//
//  FidoError.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

public enum FidoError: Error {
	case device(DeviceError)
	case protocolError(ProtocolError)

	public enum DeviceError: Error {
		case notFidoCompliant
		case invalidPath
		case missingVendorOrProductId
		case missingMetadata
		case reportLengthUnavailable
		case reportLengthInvalid

		case failedToOpen
		case failedToCreatePipe
	}

	public enum ProtocolError: Error {
		case tooShort
		case invalidCommand
		case lengthMismatch
		case internalError
	}
}
