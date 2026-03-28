//
//  File.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/19/25.
//

import Foundation
import SwiftCBOR

func debugPrintCBORResponse(_ data: Data) {
	guard data.count > 1 else {
		print("❌ Too short to contain a status + CBOR")
		return
	}

	// 1) Peel off the CTAP2 status
	let status = data[0]
	print(
		"⚪️ CTAP2 status: 0x\(String(format: "%02x", status)) (\(status == 0 ? "success" : "error"))\n"
	)

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
