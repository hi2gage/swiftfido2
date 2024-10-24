import Foundation
import IOKit
import IOKit.usb
import IOKit.hid
import Security

extension Optional where Wrapped == CFTypeRef {
    var int16Value: Int16? {
        guard let value = self else { return nil }
        // Attempt to cast to NSNumber
        if let number = value as? NSNumber {
            return number.int16Value
        }
        return nil
    }
}


// Usage
do {
    let manager = Fido2Manager()

    // Find First HIDDevice
    guard let device = try manager.fidoHidDevices(max: 12).first else {
        throw FidoError.noDevicesFound
    }

    print("device: \(device)")

    var context = try manager.open(withHidDevice: device)

    print("context: \(context)")
    
    var data = try manager.readData(from: device, context: context)
    
    // Convert Data to a byte array
    let byteArray = [UInt8](data)
    
    // Print each byte in hexadecimal format
    let hexString = byteArray.map { String(format: "%02x", $0) }.joined(separator: " ")
    print("Raw Data: \(hexString)")
    
    
    try manager.close(withHidDevice: device, context: &context)

    print("contextNil: \(context)")

} catch {
    print("Error: \(error)")
}

extension Data {
    /// Returns cryptographically secure random data.
    ///
    /// - Parameter length: Length of the data in bytes.
    /// - Returns: Generated data of the specified length.
    static func random(length: Int) throws -> Data {
        return Data((0 ..< length).map { _ in UInt8.random(in: UInt8.min ... UInt8.max) })
    }
}






