//
//  KnownFidoDevices.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import Foundation

struct KnownFidoDevices: Hashable {
	let vendor: KnownVendors
	let product: KnownProduct

	static var all: Set<KnownFidoDevices> {
		return Set(
			KnownVendors.allCases.flatMap { vendor in
				vendor.products.map { product in
					KnownFidoDevices(vendor: vendor, product: product)
				}
			}
		)
	}
}

struct KnownProduct: Hashable {
	let productId: UInt16
	let name: String

	func hash(into hasher: inout Hasher) {
		hasher.combine(productId)
	}
}

// List of known vendors
enum KnownVendors: UInt16, Hashable, CaseIterable {
	case STMICRO = 0x0483
	case INFINEON = 0x058b
	case SYNAPTICS = 0x06cb
	case FEITIAN = 0x096e
	case YUBICO = 0x1050
	case SILICON = 0x10c4
	case PIDCODES = 0x1209
	case GOOGLE = 0x18d1
	case VASCO = 0x1a44
	case OPENMOKO = 0x1d50
	case NEOWAVE = 0x1e0d
	case EXCELSECU = 0x1ea8
	case NXP = 0x1fc9
	case CLAYLOGIC = 0x20a0
	case ALLADIN = 0x24dc
	case PLUGUP = 0x2581
	case BLUINK = 0x2abe
	case LEDGER = 0x2c97
	case HYPERSECU = 0x2ccf
	case EWBM = 0x311f
	case GOTRUST = 0x32a3
	case UNKNOWN1 = 0x4c4d
	case SATOSHI = 0x534c

	var products: Set<KnownProduct> {
		switch self {
		case .STMICRO:
			return [
				.init(productId: 0xa2ac, name: "ellipticSecure MIRKey"),
				.init(productId: 0xa2ca, name: "Unknown product"),
				.init(productId: 0xcdab, name: "Unknown product"),
			]
		case .INFINEON:
			return [
				.init(productId: 0x022d, name: "Infineon FIDO")
			]
		case .SYNAPTICS:
			return [
				.init(productId: 0x0088, name: "Kensington VeriMark")
			]
		case .FEITIAN:
			return [
				.init(productId: 0x0850, name: "FS ePass FIDO"),
				.init(productId: 0x0852, name: "Unknown product"),
				.init(productId: 0x0853, name: "Unknown product"),
				.init(productId: 0x0854, name: "Unknown product"),
				.init(productId: 0x0856, name: "Unknown product"),
				.init(productId: 0x0858, name: "Unknown product"),
				.init(productId: 0x085a, name: "FS MultiPass FIDO U2F"),
				.init(productId: 0x085b, name: "Unknown product"),
				.init(productId: 0x085d, name: "Unknown product"),
				.init(productId: 0x0866, name: "BioPass FIDO2 K33"),
				.init(productId: 0x0867, name: "BioPass FIDO2 K43"),
				.init(productId: 0x0880, name: "Hypersecu HyperFIDO"),
			]
		case .YUBICO:
			return [
				.init(productId: 0x0113, name: "YubiKey NEO FIDO"),
				.init(productId: 0x0114, name: "YubiKey NEO OTP+FIDO"),
				.init(productId: 0x0115, name: "YubiKey NEO FIDO+CCID"),
				.init(productId: 0x0116, name: "YubiKey NEO OTP+FIDO+CCID"),
				.init(productId: 0x0120, name: "Security Key by Yubico"),
				.init(productId: 0x0121, name: "Unknown product"),
				.init(productId: 0x0200, name: "Gnubby U2F"),
				.init(productId: 0x0402, name: "YubiKey 4 FIDO"),
				.init(productId: 0x0403, name: "YubiKey 4 OTP+FIDO"),
				.init(productId: 0x0406, name: "YubiKey 4 FIDO+CCID"),
				.init(productId: 0x0407, name: "YubiKey 4 OTP+FIDO+CCID"),
				.init(productId: 0x0410, name: "YubiKey Plus"),
			]
		case .SILICON:
			return [
				.init(productId: 0x8acf, name: "U2F Zero")
			]
		case .PIDCODES:
			return [
				.init(productId: 0x5070, name: "SoloKeys SoloHacker"),
				.init(productId: 0x50b0, name: "SoloKeys SoloBoot"),
				.init(productId: 0x53c1, name: "SatoshiLabs TREZOR"),
				.init(productId: 0xbeee, name: "SoloKeys v2"),
			]
		case .GOOGLE:
			return [
				.init(productId: 0x5026, name: "Google Titan U2F")
			]
		case .VASCO:
			return [
				.init(productId: 0x00bb, name: "VASCO SecureClick")
			]
		case .OPENMOKO:
			return [
				.init(productId: 0x60fc, name: "OnlyKey (FIDO2/U2F)")
			]
		case .NEOWAVE:
			return [
				.init(productId: 0xf1ae, name: "Neowave Keydo AES"),
				.init(productId: 0xf1d0, name: "Neowave Keydo"),
			]
		case .EXCELSECU:
			return [
				.init(productId: 0xf025, name: "Thethis Key"),
				.init(productId: 0xfc25, name: "ExcelSecu FIDO2 Security Key"),
			]
		case .NXP:
			return [
				.init(productId: 0xf143, name: "GoTrust Idem Key")
			]
		case .CLAYLOGIC:
			return [
				.init(productId: 0x4287, name: "Nitrokey FIDO U2F"),
				.init(productId: 0x42b1, name: "Nitrokey FIDO2"),
				.init(productId: 0x42b2, name: "Nitrokey 3C NFC"),
				.init(productId: 0x42b3, name: "Safetech SafeKey"),
				.init(productId: 0x42d4, name: "CanoKey"),
			]
		case .ALLADIN:
			return [
				.init(productId: 0x0101, name: "JaCarta U2F"),
				.init(productId: 0x0501, name: "JaCarta U2F"),
			]
		case .PLUGUP:
			return [
				.init(productId: 0xf1d0, name: "Happlink Security Key")
			]
		case .BLUINK:
			return [
				.init(productId: 0x1002, name: "Bluink Key")
			]
		case .LEDGER:
			return [
				.init(productId: 0x0000, name: "Ledger Blue"),
				.init(productId: 0x0001, name: "Ledger Nano S Old firmware"),
				.init(productId: 0x0004, name: "Ledger Nano X Old firmware"),
				.init(productId: 0x0011, name: "Ledger Blue"),
				.init(productId: 0x0015, name: "Ledger Blue Legacy"),
				.init(productId: 0x1005, name: "Ledger Nano S HID+U2F"),
				.init(productId: 0x1011, name: "Ledger Nano S HID+WEBUSB"),
				.init(productId: 0x1015, name: "Ledger Nano S HID+U2F+WEBUSB"),
				.init(productId: 0x4005, name: "Ledger Nano X HID+U2F"),
				.init(productId: 0x4011, name: "Ledger Nano X HID+WEBUSB"),
				.init(productId: 0x4015, name: "Ledger Nano X HID+U2F+WEBUSB"),
				.init(productId: 0x5005, name: "Ledger Nano S+ HID+U2F"),
				.init(productId: 0x5011, name: "Ledger Nano S+ HID+WEBUSB"),
				.init(productId: 0x5015, name: "Ledger Nano S+ HID+U2F+WEBUSB"),
				.init(productId: 0x6005, name: "Ledger Stax HID+U2F"),
				.init(productId: 0x6011, name: "Ledger Stax HID+WEBUSB"),
				.init(productId: 0x6015, name: "Ledger Stax HID+U2F+WEBUSB"),
			]
		case .HYPERSECU:
			return [
				.init(productId: 0x0880, name: "Hypersecu HyperFIDO")
			]
		case .EWBM:
			return [
				.init(productId: 0x4a1a, name: "TrustKey Solutions FIDO2 G310"),
				.init(
					productId: 0x4a2a,
					name: "TrustKey Solutions FIDO2 G310H/G320H"
				),
				.init(productId: 0x4c2a, name: "TrustKey Solutions FIDO2 G320"),
				.init(productId: 0x5c2f, name: "eWBM FIDO2 Goldengate G500"),
				.init(productId: 0xa6e9, name: "TrustKey Solutions FIDO2 T120"),
				.init(productId: 0xa7f9, name: "TrustKey Solutions FIDO2 T110"),
				.init(productId: 0xf47c, name: "eWBM FIDO2 Goldengate G450"),
			]
		case .GOTRUST:
			return [
				.init(productId: 0x3201, name: "Idem Key")
			]
		case .UNKNOWN1:
			return [
				.init(productId: 0xf703, name: "Longmai mFIDO")
			]
		case .SATOSHI:
			return [
				.init(productId: 0x0001, name: "SatoshiLabs TREZOR")
			]
		}
	}

	var fullName: String {
		switch self {
		case .STMICRO:
			"STMicroelectronics"
		case .INFINEON:
			"Infineon Technologies"
		case .SYNAPTICS:
			"Synaptics Inc."
		case .FEITIAN:
			"Feitian Technologies Co., Ltd."
		case .YUBICO:
			"Yubico AB"
		case .SILICON:
			"Silicon Laboratories, Inc."
		case .PIDCODES:
			"pid.codes"
		case .GOOGLE:
			"Google Inc."
		case .VASCO:
			"VASCO Data Security NV"
		case .OPENMOKO:
			"OpenMoko, Inc."
		case .NEOWAVE:
			"NEOWAVE"
		case .EXCELSECU:
			"Shenzhen Excelsecu Data Technology Co., Ltd."
		case .NXP:
			"NXP Semiconductors"
		case .CLAYLOGIC:
			"Clay Logic"
		case .ALLADIN:
			"Aladdin Software Security R.D."
		case .PLUGUP:
			"Plug‐up"
		case .BLUINK:
			"Bluink Ltd"
		case .LEDGER:
			"LEDGER"
		case .HYPERSECU:
			"Hypersecu Information Systems, Inc."
		case .EWBM:
			"eWBM Co., Ltd."
		case .GOTRUST:
			"GoTrustID Inc."
		case .UNKNOWN1:
			"Unknown vendor"
		case .SATOSHI:
			"SatoshiLabs"
		}
	}
}
