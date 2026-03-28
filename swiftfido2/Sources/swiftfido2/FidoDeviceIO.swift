//
//  Untitled.swift
//  swiftfido2
//
//  Created by Gage Halverson on 10/23/24.
//
import Foundation

// Define the FidoDeviceIO struct for I/O operations
struct FidoDeviceIO {
	var open: ((String) -> UnsafeMutableRawPointer?)?  // Replace these with appropriate Swift closures
	var close: (() -> Void)?
	var read: (Int) -> Data?
	var write: (Data) -> Int

	init(
		open: (
			(String) -> UnsafeMutableRawPointer?
		)? = nil,
		close: (() -> Void)? = nil,
		read: @escaping (Int) -> Data?,
		write: @escaping (Data) -> Int
	) {
		self.open = open
		self.close = close
		self.read = read
		self.write = write
	}

	init() {
		self.open = nil
		self.close = nil
		self.read = { _ in return nil }
		self.write = { _ in return 1 }
	}
}
