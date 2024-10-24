//
//  File.swift
//  swiftfido2
//
//  Created by Gage Halverson on 10/23/24.
//

import Foundation
import IOKit.hid

struct FidoDeviceInfo: CustomStringConvertible {
    var path: String           // Device path
    var vendorID: UInt16        // 2-byte vendor ID
    var productID: UInt16       // 2-byte product ID
    var manufacturer: String   // Manufacturer string
    var product: String        // Product string
    var io: FidoDeviceIO       // I/O functions (we'll create this as a struct)
    var transport: FidoDeviceTransport // Transport functions (as another struct)
    var hidDevice: IOHIDDevice

    var description: String {
        return """
        FidoDeviceInfo:
        Path: \(path)
        Vendor ID: \(vendorID)
        Product ID: \(productID)
        Manufacturer: \(manufacturer)
        Product: \(product)
        IO: \(io)
        Transport: \(transport)
        """
    }
}


extension FidoDeviceInfo {
    // Initialize from an IOHIDDeviceRef
    init?(from hidDevice: IOHIDDevice) {
        // Check if the device is a FIDO device
        guard hidDevice.isFido else {
            return nil // Return nil if it's not a FIDO device
        }

        // Get device path
        guard let path = Self.getPath(for: hidDevice) else {
            return nil
        }

        // Get vendor ID
        guard let vendorID = IOHIDDeviceGetProperty(hidDevice, kIOHIDVendorIDKey as CFString) as? UInt16 else {
            return nil
        }

        // Get product ID
        guard let productID = IOHIDDeviceGetProperty(hidDevice, kIOHIDProductIDKey as CFString) as? UInt16 else {
            return nil
        }

        // Get manufacturer string
        guard let manufacturer = IOHIDDeviceGetProperty(hidDevice, kIOHIDManufacturerKey as CFString) as? String else {
            return nil
        }

        // Get product string
        guard let product = IOHIDDeviceGetProperty(hidDevice, kIOHIDProductKey as CFString) as? String else {
            return nil
        }

        // Define I/O functions (replace with actual implementations)
        let ioFunctions = FidoDeviceIO(
            open: { _ in print("Opening device..."); return nil},
            close: { print("Closing device...") },
            read: { length in
                // Implement read logic here
                return nil // Placeholder
            },
            write: { data in
                // Implement write logic here
                return data.count // Placeholder
            }
        )

        // Initialize the transport struct
        let transportFunctions = FidoDeviceTransport()

        // Initialize properties
        self.path = path
        self.vendorID = vendorID
        self.productID = productID
        self.manufacturer = manufacturer
        self.product = product
        self.io = ioFunctions
        self.transport = transportFunctions
        self.hidDevice = hidDevice
    }
}


extension FidoDeviceInfo {

    // Function to get the device path
    private static func getPath(for device: IOHIDDevice) -> String? {
        let service = IOHIDDeviceGetService(device)
        var id: UInt64 = 0

        if service != MACH_PORT_NULL, IORegistryEntryGetRegistryEntryID(service, &id) == KERN_SUCCESS {
            return "\(Self.IOREG)\(id)"
        } else {
            return nil
        }
    }

    static var IOREG: String = "ioreg://"
}
