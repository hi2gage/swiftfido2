//
//  Untitled.swift
//  swiftfido2
//
//  Created by Gage Halverson on 10/23/24.
//
import Foundation

// Define the FidoDeviceIO struct for I/O operations
struct FidoDeviceIO {
    var open: ((String) -> UnsafeMutableRawPointer?)?       // Replace these with appropriate Swift closures
    var close: (() -> Void)?
    var read: (Int) -> Data?
    var write: (Data) -> Int
}

