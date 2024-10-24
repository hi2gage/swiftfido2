//
//  Fido2Manager.swift
//  swiftfido2
//
//  Created by Gage Halverson on 10/23/24.
//
import IOKit.hid
import Foundation

extension Fido2Manager {
    var CTAP_MAX_REPORT_LEN: Int { 64 }
}

class Fido2Manager {
    func fidoHidDevices(max: Int) throws -> [FidoDeviceInfo] {
        let manager: IOHIDManager = IOHIDManagerCreate(kCFAllocatorDefault, 0)

        IOHIDManagerSetDeviceMatching(manager, nil)
        if let deviceSet = IOHIDManagerCopyDevices(manager) as? Set<IOHIDDevice>, !deviceSet.isEmpty {
            return deviceSet.prefix(max).compactMap { FidoDeviceInfo(from: $0) }
        } else {
            throw FidoError.noDevicesFound
        }
    }

    func open(withHidDevice deviceInfo: FidoDeviceInfo) throws -> FidoDeviceContext {
        let device = deviceInfo.hidDevice

        // Create FidoDeviceContext to hold references
        var deviceContext = FidoDeviceContext()

        // Open the HID device
        let openResult = IOHIDDeviceOpen(device, IOOptionBits(kIOHIDOptionsTypeSeizeDevice))
        if openResult != kIOReturnSuccess {
            throw FidoError.failedToOpenDevice
        }

        // Get the report sizes
        deviceContext.reportInLen = try getReportLength(device: device, direction: 0)
        deviceContext.reportOutLen = try getReportLength(device: device, direction: 1)

        // Set up input report and removal callbacks
        setupHidCallbacks(device: device, context: &deviceContext)

        return deviceContext
    }

    func close(
        withHidDevice deviceInfo: FidoDeviceInfo,
        context: inout FidoDeviceContext
    ) throws {
        let device = deviceInfo.hidDevice

        guard var reportData = context.reportInData else {
            throw FidoError.failedToFindReport
        }

        // Ensure reportData is large enough to match the expected report length.
        guard reportData.count >= context.reportInLen else {
            throw FidoError.failedToFindReport
        }

        // Create a mutable pointer to the data
        try reportData.withUnsafeMutableBytes { (rawBufferPointer: UnsafeMutableRawBufferPointer) in
            // Ensure the base address is non-nil and is of the correct type
            guard let reportPointer = rawBufferPointer.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                throw FidoError.failedToFindReport
            }

            // Deregister input report callback
            IOHIDDeviceRegisterInputReportCallback(
                device,
                reportPointer,
                context.reportInLen,
                nil,
                nil
            )
        }

        // Deregister removal callback
        IOHIDDeviceRegisterRemovalCallback(device, nil, nil)

        // Close the HID device
        let closeResult = IOHIDDeviceClose(
            device,
            IOOptionBits(kIOHIDOptionsTypeSeizeDevice)
        )
        if closeResult != kIOReturnSuccess {
            print("Failed to close HID device with error: \(closeResult)")
        }

        // Optionally nil out the context object for safety
        context = FidoDeviceContext()  // Or handle it differently if needed
    }

    // Utility to get report length
    private func getReportLength(device: IOHIDDevice, direction: Int) throws -> Int {
        let key: CFString
        let reportKey: String

        if direction == 0 {
            // Input report
            key = kIOHIDMaxInputReportSizeKey as CFString
            reportKey = "Input Report"
        } else {
            // Output report
            key = kIOHIDMaxOutputReportSizeKey as CFString
            reportKey = "Output Report"
        }

        // Use a utility function to get the report length
        let reportLength = try getInt32(device: device, key: key)
        if reportLength < 0 {
            print("\(reportKey): Failed to retrieve report length")
            throw FidoError.failedToGetReportLength
        }

        // Check for valid report length
        guard reportLength <= CTAP_MAX_REPORT_LEN else {
            print("\(reportKey): report length \(reportLength) exceeds maximum allowed")
            throw FidoError.invalidReportLength
        }

        return Int(reportLength)
    }

    // Utility function to retrieve an integer value from the HID device
    private func getInt32(device: IOHIDDevice, key: CFString) throws -> Int32 {
        guard let result = IOHIDDeviceGetProperty(device, key) as? NSNumber else {
            throw FidoError.propertyRetrievalFailed
        }
        return result.int32Value // Success, return the value
    }

    func readData(from deviceInfo: FidoDeviceInfo, context: FidoDeviceContext) throws -> Data {
        let device = deviceInfo.hidDevice

        // Create a buffer to hold the report
        var buffer = [UInt8](repeating: 0, count: context.reportInLen)

        // Attempt to read from the device
        var reportLength = context.reportInLen
        let result = IOHIDDeviceGetReport(
            device,
            kIOHIDReportTypeInput,
            0x01,  // Use the appropriate report ID
            &buffer,
            &reportLength
        )

        // Check the result for errors
        if result != kIOReturnSuccess {
            if result == kIOReturnUnderrun {
                throw FidoError.kIOReturnUnderrun
            }
            throw FidoError.failedToReadData
        }

        // Ensure the length of the report received matches what we expected
        guard reportLength <= context.reportInLen else {
            throw FidoError.failedToReadData
        }

        // Return the Data object created from the buffer
        return Data(buffer.prefix(Int(reportLength)))
    }

    // Set up input report and removal callbacks
    private func setupHidCallbacks(device: IOHIDDevice, context: inout FidoDeviceContext) {
        // Set up input report callback
        context.reportInData = Data(count: context.reportInLen)
        context.reportInData?.withUnsafeMutableBytes { reportPointer in
            IOHIDDeviceRegisterInputReportCallback(device, reportPointer.baseAddress!.assumingMemoryBound(to: UInt8.self), context.reportInLen, { _, _, _, _, _, _, _  in
                // Handle the input report here
            }, nil)
        }

        // Set up removal callback
        IOHIDDeviceRegisterRemovalCallback(device, { _, _, _  in
            // Handle device removal
        }, nil)
    }
}

// Safer FidoDeviceContext using Data
struct FidoDeviceContext {
    var reportInLen: Int = 0
    var reportOutLen: Int = 0
    var reportInData: Data? // Data buffer to store the report
}



extension Fido2Manager {
    private func sendToHidDevice(
        device: IOHIDDevice,
        reportID: CFIndex,
        data: Data,
        reportType: IOHIDReportType
    ) throws {
        let result = data.withUnsafeBytes { (buffer: UnsafeRawBufferPointer) -> IOReturn in
            let reportPtr = buffer.bindMemory(to: UInt8.self).baseAddress!
            return IOHIDDeviceSetReport(device, reportType, reportID, reportPtr, data.count)
        }

        if result != kIOReturnSuccess {
            throw FidoError.txError // Handle appropriately
        }
    }

    private func initializeCommunication(with device: FidoDeviceInfo) throws {
        let nonce = try Data.random(length: 8) // Generate nonce
        let command: UInt8 = 0x06 // Example command ID for init (replace with actual)
        let reportID: CFIndex = 0 // Define report ID based on your protocol
        let reportType: IOHIDReportType = kIOHIDReportTypeOutput

        var commandData = Data([command])
        commandData.append(nonce) // Append command data with nonce

        try sendToHidDevice(
            device: device.hidDevice,
            reportID: reportID,
            data: commandData,
            reportType: reportType
        )
    }

}
