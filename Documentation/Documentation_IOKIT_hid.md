Here is the documentation from `import IOKit.hid`


import CoreFoundation
import IOKit
import _Builtin_stdint

public var kIOHIDPointerAccelerationKey: String { get }

public var kIOHIDTrackpadScrollAccelerationKey: String { get }

public var kIOHIDTrackpadAccelerationType: String { get }

public var kIOHIDPointerAccelerationTypeKey: String { get }

public var kIOHIDMouseScrollAccelerationKey: String { get }

public var kIOHIDMouseAccelerationTypeKey: String { get }

public var kIOHIDScrollAccelerationKey: String { get }

public var kIOHIDScrollAccelerationTypeKey: String { get }

public var kIOHIDDigitizerTipThresholdKey: String { get }

public var kIOHIDSurfaceDimensionsKey: String { get }

public var kIOHIDWidthKey: String { get }

public var kIOHIDHeightKey: String { get }

public var kIOHIDEventDriverHandlesReport: String { get }

public var kIOHIDServiceAccelerationProperties: String { get }

public var kIOHIDPointerAccelerationMultiplierKey: String { get }

public var kHIDPointerReportRateKey: String { get }

public var kIOHIDScrollReportRateKey: String { get }

public var kHIDAccelParametricCurvesKey: String { get }

public var kHIDScrollAccelParametricCurvesKey: String { get }

public var kIOHIDScrollResolutionKey: String { get }

public var kIOHIDDropAccelPropertyEventsKey: String { get }

public var kIOHIDScrollResolutionXKey: String { get }

public var kIOHIDScrollResolutionYKey: String { get }

public var kIOHIDScrollResolutionZKey: String { get }

public var kIOHIDUseLinearScalingMouseAccelerationKey: String { get }

public var kIOHIDPointerAccelerationSupportKey: String { get }

public var kIOHIDScrollAccelerationSupportKey: String { get }

public var kIOHIDEventServiceSensorControlOptionsKey: String { get }

public var kIOHIDMouseAccelerationType: String { get }

public var kIOHIDPointerButtonMode: String { get }

public var kIOHIDPointerButtonModeKey: String { get }

public var kIOHIDUserKeyUsageMapKey: String { get }

public var kIOHIDKeyboardCapsLockDelayOverride: String { get }

public var kIOHIDKeyboardCapsLockDelayOverrideKey: String { get }

public var kIOHIDServiceEjectDelayKey: String { get }

public var kIOHIDServiceLockKeyDelayKey: String { get }

public var kIOHIDServiceInitialKeyRepeatDelayKey: String { get }

public var kIOHIDServiceKeyRepeatDelayKey: String { get }

public var kIOHIDIdleTimeMicrosecondsKey: String { get }

public var kIOHIDServiceCapsLockStateKey: String { get }

/**
 * @typedef IOHIDReportType
 *
 * @abstract
 * Describes different type of HID reports.
 */
public struct IOHIDReportType : Hashable, Equatable, RawRepresentable {

    public init(_ rawValue: UInt32)

    public init(rawValue: UInt32)

    public var rawValue: UInt32
}

public var kIOHIDReportTypeInput: IOHIDReportType { get }

public var kIOHIDReportTypeOutput: IOHIDReportType { get }

public var kIOHIDReportTypeFeature: IOHIDReportType { get }

public var kIOHIDReportTypeCount: IOHIDReportType { get }

/**
 * @typedef IOHIDElementCommitDirection
 *
 * @abstract
 * Commit direction passed in to the commit() function of an IOHIDElement.
 *
 * @field kIOHIDElementCommitDirectionIn
 * Passing in kIOHIDElementCommitDirectionIn will issue a getReport call to the
 * device, and the element  will be updated with the value retrieved by the
 * device. The value can be accessed via the getValue() or getDataValue()
 * functions.
 *
 * @field kIOHIDElementCommitDirectionOut
 * Passing in kIOHIDElementCommitDirectionOut will issue a setReport call to the
 * device. Before issuing this call, the desired value should be set on the
 * element with the setValue() or setDataValue() functions.
 */
public struct IOHIDElementCommitDirection : Hashable, Equatable, RawRepresentable {

    public init(_ rawValue: UInt32)

    public init(rawValue: UInt32)

    public var rawValue: UInt32
}

public var kIOHIDElementCommitDirectionIn: IOHIDElementCommitDirection { get }

public var kIOHIDElementCommitDirectionOut: IOHIDElementCommitDirection { get }

/**
 * @typedef IOHIDElementCookie
 *
 * @abstract
 * Abstract data type used as a unique identifier for an element.
 */
public typealias IOHIDElementCookie = UInt32

/**
 * @typedef IOHIDElementType
 *
 * @abstract
 * Describes different types of HID elements.
 *
 * @discussion
 * Used by the IOHIDFamily to identify the type of element processed.
 * Represented by the key kIOHIDElementTypeKey in the dictionary describing the
 * element.
 *
 * @field kIOHIDElementTypeInput_Misc
 * Misc input data field or varying size.
 *
 * @field kIOHIDElementTypeInput_Button
 * One bit input data field.
 *
 * @field kIOHIDElementTypeInput_Axis
 * Input data field used to represent an axis.
 *
 * @field kIOHIDElementTypeInput_ScanCodes
 * Input data field used to represent a scan code or usage selector.
 *
 * @field kIOHIDElementTypeInput_NULL
 * Input data field used to represent the end of an input report when receiving
 * input elements.
 *
 * @field kIOHIDElementTypeOutput
 * Used to represent an output data field in a report.
 *
 * @field kIOHIDElementTypeFeature
 * Describes input and output elements not intended for consumption by the end
 * user.
 *
 * @field kIOHIDElementTypeCollection
 * Element used to identify a relationship between two or more elements.
 */
public struct IOHIDElementType : Hashable, Equatable, RawRepresentable {

    public init(_ rawValue: UInt32)

    public init(rawValue: UInt32)

    public var rawValue: UInt32
}

public var kIOHIDElementTypeInput_Misc: IOHIDElementType { get }

public var kIOHIDElementTypeInput_Button: IOHIDElementType { get }

public var kIOHIDElementTypeInput_Axis: IOHIDElementType { get }

public var kIOHIDElementTypeInput_ScanCodes: IOHIDElementType { get }

public var kIOHIDElementTypeInput_NULL: IOHIDElementType { get }

public var kIOHIDElementTypeOutput: IOHIDElementType { get }

public var kIOHIDElementTypeFeature: IOHIDElementType { get }

public var kIOHIDElementTypeCollection: IOHIDElementType { get }

public var kIOHIDElementFlagsConstantMask: Int { get }

public var kIOHIDElementFlagsVariableMask: Int { get }

public var kIOHIDElementFlagsRelativeMask: Int { get }

public var kIOHIDElementFlagsWrapMask: Int { get }

public var kIOHIDElementFlagsNonLinearMask: Int { get }

public var kIOHIDElementFlagsNoPreferredMask: Int { get }

public var kIOHIDElementFlagsNullStateMask: Int { get }

public var kIOHIDElementFlagsVolativeMask: Int { get }

public var kIOHIDElementFlagsBufferedByteMask: Int { get }

public typealias IOHIDElementFlags = UInt32

/**
 * @typedef IOHIDElementCollectionType
 *
 * @abstract
 * Describes different types of HID collections.
 *
 * @discussion
 * Collections identify a relationship between two or more elements.
 *
 * @field kIOHIDElementCollectionTypePhysical
 * Used for a set of data items that represent data points collected at one
 * geometric point.
 *
 * @field kIOHIDElementCollectionTypeApplication
 * Identifies item groups serving different purposes in a single device.
 *
 * @field kIOHIDElementCollectionTypeLogical
 * Used when a set of data items form a composite data structure.
 *
 * @field kIOHIDElementCollectionTypeReport
 * Wraps all the fields in a report.
 *
 * @field kIOHIDElementCollectionTypeNamedArray
 * Contains an array of selector usages.
 *
 * @field kIOHIDElementCollectionTypeUsageSwitch
 * Modifies the meaning of the usage it contains.
 *
 * @field kIOHIDElementCollectionTypeUsageModifier
 * Modifies the meaning of the usage attached to the encompassing collection.
 */
public struct IOHIDElementCollectionType : Hashable, Equatable, RawRepresentable {

    public init(_ rawValue: UInt32)

    public init(rawValue: UInt32)

    public var rawValue: UInt32
}

public var kIOHIDElementCollectionTypePhysical: IOHIDElementCollectionType { get }

public var kIOHIDElementCollectionTypeApplication: IOHIDElementCollectionType { get }

public var kIOHIDElementCollectionTypeLogical: IOHIDElementCollectionType { get }

public var kIOHIDElementCollectionTypeReport: IOHIDElementCollectionType { get }

public var kIOHIDElementCollectionTypeNamedArray: IOHIDElementCollectionType { get }

public var kIOHIDElementCollectionTypeUsageSwitch: IOHIDElementCollectionType { get }

public var kIOHIDElementCollectionTypeUsageModifier: IOHIDElementCollectionType { get }

public var kIOHIDValueScaleTypeCalibrated: Int { get }

public var kIOHIDValueScaleTypePhysical: Int { get }

public var kIOHIDValueScaleTypeExponent: Int { get }

public typealias IOHIDValueScaleType = UInt32

public var kIOHIDValueOptionsFlagRelativeSimple: Int { get }

public var kIOHIDValueOptionsFlagPrevious: Int { get }

public var kIOHIDValueOptionsUpdateElementValues: Int { get }

public typealias IOHIDValueOptions = UInt32

/**
 * @typedef IOHIDCompletionAction
 *
 * @abstract Function called when set/get report completes
 *
 * @param target
 * The target specified in the IOHIDCompletion struct.
 *
 * @param parameter
 * The parameter specified in the IOHIDCompletion struct.
 *
 * @param status
 * Completion status
 */
public typealias IOHIDCompletionAction = @convention(c) (UnsafeMutableRawPointer?, UnsafeMutableRawPointer?, IOReturn, UInt32) -> Void

/**
 * @typedef IOHIDCompletion
 *
 * @abstract
 * Struct specifying action to perform when set/get report completes.
 *
 * @var target
 * The target to pass to the action function.
 *
 * @var action
 * The function to call.
 *
 * @var parameter
 * The parameter to pass to the action function.
 */
public struct IOHIDCompletion {

    public init()

    public init(target: UnsafeMutableRawPointer!, action: IOHIDCompletionAction!, parameter: UnsafeMutableRawPointer!)

    public var target: UnsafeMutableRawPointer!

    public var action: IOHIDCompletionAction!

    public var parameter: UnsafeMutableRawPointer!
}

public var kIOHIDReportOptionNotInterrupt: Int { get }

public var kIOHIDReportOptionVariableSize: Int { get }

/**
 * @typedef HIDReportCommandType
 *
 * @abstract
 * Type of the report command for DriverKit driver
 */
public struct HIDReportCommandType : Hashable, Equatable, RawRepresentable {

    public init(_ rawValue: UInt32)

    public init(rawValue: UInt32)

    public var rawValue: UInt32
}

public var kIOHIDReportCommandSetReport: HIDReportCommandType { get }

public var kIOHIDReportCommandGetReport: HIDReportCommandType { get }

public var kIOHIDDeviceDefaultAsyncRequestTimeout: UInt64 { get }

public var kIOHIDDeviceMinAsyncRequestTimeout: UInt64 { get }

public var kIOHIDDeviceMaxAsyncRequestTimeout: UInt64 { get }

public var kIOHIDTransportKey: String { get }

public var kIOHIDVendorIDKey: String { get }

public var kIOHIDProductIDKey: String { get }

public var kIOHIDVersionNumberKey: String { get }

public var kIOHIDManufacturerKey: String { get }

public var kIOHIDProductKey: String { get }

public var kIOHIDSerialNumberKey: String { get }

public var kIOHIDCountryCodeKey: String { get }

public var kIOHIDLocationIDKey: String { get }

public var kIOHIDDeviceUsagePairsKey: String { get }

public var kIOHIDDeviceUsageKey: String { get }

public var kIOHIDDeviceUsagePageKey: String { get }

public var kIOHIDPrimaryUsageKey: String { get }

public var kIOHIDPrimaryUsagePageKey: String { get }

public var kIOHIDMaxInputReportSizeKey: String { get }

public var kIOHIDMaxOutputReportSizeKey: String { get }

public var kIOHIDMaxFeatureReportSizeKey: String { get }

public var kIOHIDReportIntervalKey: String { get }

public var kIOHIDBatchIntervalKey: String { get }

public var kIOHIDRequestTimeoutKey: String { get }

public var kIOHIDReportDescriptorKey: String { get }

public var kIOHIDBuiltInKey: String { get }

public var kIOHIDPhysicalDeviceUniqueIDKey: String { get }

public var kIOHIDDeviceAccessEntitlementKey: String { get }

public var kIOHIDDeviceKey: String { get }

public var kIOHIDVendorIDSourceKey: String { get }

public var kIOHIDStandardTypeKey: String { get }

public var kIOHIDSampleIntervalKey: String { get }

public var kIOHIDResetKey: String { get }

public var kIOHIDKeyboardLanguageKey: String { get }

public var kIOHIDAltHandlerIdKey: String { get }

public var kIOHIDDisplayIntegratedKey: String { get }

public var kIOHIDProductIDMaskKey: String { get }

public var kIOHIDProductIDArrayKey: String { get }

public var kIOHIDPowerOnDelayNSKey: String { get }

public var kIOHIDCategoryKey: String { get }

public var kIOHIDMaxResponseLatencyKey: String { get }

public var kIOHIDUniqueIDKey: String { get }

public var kIOHIDModelNumberKey: String { get }

public var kIOHIDTransportUSBValue: String { get }

public var kIOHIDTransportBluetoothValue: String { get }

public var kIOHIDTransportBluetoothLowEnergyValue: String { get }

public var kIOHIDTransportAIDBValue: String { get }

public var kIOHIDTransportI2CValue: String { get }

public var kIOHIDTransportSPIValue: String { get }

public var kIOHIDTransportSerialValue: String { get }

public var kIOHIDTransportIAPValue: String { get }

public var kIOHIDTransportAirPlayValue: String { get }

public var kIOHIDTransportSPUValue: String { get }

public var kIOHIDTransportBTAACPValue: String { get }

public var kIOHIDTransportFIFOValue: String { get }

public var kIOHIDTransportVirtualValue: String { get }

public var kIOHIDTransportInductiveInBandValue: String { get }

public var kIOHIDCategoryAutomotiveValue: String { get }

public var kIOHIDElementKey: String { get }

public var kIOHIDElementCookieKey: String { get }

public var kIOHIDElementTypeKey: String { get }

public var kIOHIDElementCollectionTypeKey: String { get }

public var kIOHIDElementUsageKey: String { get }

public var kIOHIDElementUsagePageKey: String { get }

public var kIOHIDElementMinKey: String { get }

public var kIOHIDElementMaxKey: String { get }

public var kIOHIDElementScaledMinKey: String { get }

public var kIOHIDElementScaledMaxKey: String { get }

public var kIOHIDElementSizeKey: String { get }

public var kIOHIDElementReportSizeKey: String { get }

public var kIOHIDElementReportCountKey: String { get }

public var kIOHIDElementReportIDKey: String { get }

public var kIOHIDElementIsArrayKey: String { get }

public var kIOHIDElementIsRelativeKey: String { get }

public var kIOHIDElementIsWrappingKey: String { get }

public var kIOHIDElementIsNonLinearKey: String { get }

public var kIOHIDElementHasPreferredStateKey: String { get }

public var kIOHIDElementHasNullStateKey: String { get }

public var kIOHIDElementFlagsKey: String { get }

public var kIOHIDElementUnitKey: String { get }

public var kIOHIDElementUnitExponentKey: String { get }

public var kIOHIDElementNameKey: String { get }

public var kIOHIDElementValueLocationKey: String { get }

public var kIOHIDElementDuplicateIndexKey: String { get }

public var kIOHIDElementParentCollectionKey: String { get }

public var kIOHIDElementVariableSizeKey: String { get }

public var kIOHIDElementVendorSpecificKey: String { get }

public var kIOHIDElementCookieMinKey: String { get }

public var kIOHIDElementCookieMaxKey: String { get }

public var kIOHIDElementUsageMinKey: String { get }

public var kIOHIDElementUsageMaxKey: String { get }

public var kIOHIDElementCalibrationMinKey: String { get }

public var kIOHIDElementCalibrationMaxKey: String { get }

public var kIOHIDElementCalibrationSaturationMinKey: String { get }

public var kIOHIDElementCalibrationSaturationMaxKey: String { get }

public var kIOHIDElementCalibrationDeadZoneMinKey: String { get }

public var kIOHIDElementCalibrationDeadZoneMaxKey: String { get }

public var kIOHIDElementCalibrationGranularityKey: String { get }

public var kIOHIDKeyboardSupportsEscKey: String { get }

public var kIOHIDKeyboardSupportsDoNotDisturbKey: String { get }

public var kIOHIDOptionsTypeNone: Int { get }

public var kIOHIDOptionsTypeSeizeDevice: Int { get }

public var kIOHIDOptionsTypeMaskPrivate: Int { get }

public typealias IOHIDOptionsType = UInt32

public var kIOHIDQueueOptionsTypeNone: Int { get }

public var kIOHIDQueueOptionsTypeEnqueueAll: Int { get }

public typealias IOHIDQueueOptionsType = UInt32

public var kIOHIDStandardTypeANSI: UInt32 { get }

public var kIOHIDStandardTypeISO: UInt32 { get }

public var kIOHIDStandardTypeJIS: UInt32 { get }

public var kIOHIDStandardTypeUnspecified: UInt32 { get }

public typealias IOHIDStandardType = UInt32

public var kIOHIDKeyboardPhysicalLayoutTypeUnknown: Int { get }

public var kIOHIDKeyboardPhysicalLayoutType101: Int { get }

public var kIOHIDKeyboardPhysicalLayoutType103: Int { get }

public var kIOHIDKeyboardPhysicalLayoutType102: Int { get }

public var kIOHIDKeyboardPhysicalLayoutType104: Int { get }

public var kIOHIDKeyboardPhysicalLayoutType106: Int { get }

public var kIOHIDKeyboardPhysicalLayoutTypeVendor: Int { get }

public typealias IOHIDKeyboardPhysicalLayoutType = UInt32

public var kIOHIDDigitizerGestureCharacterStateKey: String { get }

public var kIOHIDKeyboardCapsLockDelay: String { get }

public var kIOHIDKeyboardEjectDelay: String { get }

public var kFnFunctionUsageMapKey: String { get }

public var kFnKeyboardUsageMapKey: String { get }

public var kNumLockKeyboardUsageMapKey: String { get }

public var kKeyboardUsageMapKey: String { get }

public var kIOHIDDeviceOpenedByEventSystemKey: String { get }

public var kIOHIDDeviceSuspendKey: String { get }

public var kIOHIDMaxReportBufferCountKey: String { get }

public var kIOHIDReportBufferEntrySizeKey: String { get }

public var kIOHIDSensorPropertyReportIntervalKey: String { get }

public var kIOHIDSensorPropertySampleIntervalKey: String { get }

public var kIOHIDSensorPropertyBatchIntervalKey: String { get }

public var kIOHIDSensorPropertyReportLatencyKey: String { get }

public var kIOHIDSensorPropertyMaxFIFOEventsKey: String { get }

public var kIOHIDDigitizerSurfaceSwitchKey: String { get }

public var kIOHIDKeyboardLayoutValueKey: String { get }

public var kIOHIDPointerAccelerationAlgorithmKey: String { get }

public var kIOHIDScrollAccelerationAlgorithmKey: String { get }

public var kIOHIDAccelerationAlgorithmTypeTable: Int { get }

public var kIOHIDAccelerationAlgorithmTypeParametric: Int { get }

public var kIOHIDAccelerationAlgorithmTypeDefault: Int { get }

public typealias IOHIDAccelerationAlgorithmType = UInt8

public var kIOHIDPointerAccelerationMinimumKey: String { get }

public var kIOHIDPrimaryTrackpadCanBeDisabledKey: String { get }

public var kIOHIDKeyboardFunctionKeyCountKey: String { get }

/** @typedef IOHIDDeviceRef
    This is the type of a reference to the IOHIDDevice.
*/
public class IOHIDDevice : Hashable {
}

/** @typedef IOHIDElementRef
    This is the type of a reference to the IOHIDElement.
*/
public class IOHIDElement : Hashable {
}

/** @typedef IOHIDValueRef
    This is the type of a reference to the IOHIDValue.
*/
public class IOHIDValue : Hashable {
}

/**
    @typedef    IOHIDTransactionDirectionType
    @abstract   Direction for an IOHIDDeviceTransactionInterface.
    @constant   kIOHIDTransactionDirectionTypeInput Transaction direction used for requesting element values from a device. 
    @constant   kIOHIDTransactionDirectionTypeOutput Transaction direction used for dispatching element values to a device. 
*/
public enum IOHIDTransactionDirectionType : UInt32, @unchecked Sendable {

    case input = 0

    case output = 1
}

/**
    @enum       IOHIDTransactionOption
    @abstract   Options to be used in conjuntion with an IOHIDDeviceTransactionInterface.
    @constant   kIOHIDTransactionOptionDefaultOutputValue Option to set the default element value to be used with an
                IOHIDDeviceTransactionInterface of direction kIOHIDTransactionDirectionTypeOutput. 
*/
public let kIOHIDTransactionOptionDefaultOutputValue: IOOptionBits

/** @typedef IOHIDCallback
    @discussion Type and arguments of callout C function that is used when a completion routine is called.
    @param context void * pointer to your data, often a pointer to an object.
    @param result Completion result of desired operation.
    @param sender Interface instance sending the completion routine.
*/
public typealias IOHIDCallback = @convention(c) (UnsafeMutableRawPointer?, IOReturn, UnsafeMutableRawPointer?) -> Void

/** @typedef IOHIDReportCallback
    @discussion Type and arguments of callout C function that is used when a HID report completion routine is called.
    @param context void * pointer to your data, often a pointer to an object.
    @param result Completion result of desired operation.
    @param sender Interface instance sending the completion routine.
    @param type The type of the report that was completed.
    @param reportID The ID of the report that was completed.
    @param report Pointer to the buffer containing the contents of the report.
    @param reportLength Size of the buffer received upon completion.
*/
public typealias IOHIDReportCallback = @convention(c) (UnsafeMutableRawPointer?, IOReturn, UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutablePointer<UInt8>, CFIndex) -> Void

/** @typedef IOHIDReportCallback
    @discussion Type and arguments of callout C function that is used when a HID report completion routine is called.
    @param context void * pointer to your data, often a pointer to an object.
    @param result Completion result of desired operation.
    @param sender Interface instance sending the completion routine.
    @param type The type of the report that was completed.
    @param reportID The ID of the report that was completed.
    @param report Pointer to the buffer containing the contents of the report.
    @param reportLength Size of the buffer received upon completion.
    @param timeStamp The time at which the report arrived.
*/
public typealias IOHIDReportWithTimeStampCallback = @convention(c) (UnsafeMutableRawPointer?, IOReturn, UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutablePointer<UInt8>, CFIndex, UInt64) -> Void

/** @typedef IOHIDValueCallback
    @discussion Type and arguments of callout C function that is used when an element value completion routine is called.
    @param context void * pointer to more data.
    @param result Completion result of desired operation.
    @param sender Interface instance sending the completion routine.
    @param value IOHIDValueRef containing the returned element value.
*/
public typealias IOHIDValueCallback = @convention(c) (UnsafeMutableRawPointer?, IOReturn, UnsafeMutableRawPointer?, IOHIDValue) -> Void

/** @typedef IOHIDValueMultipleCallback
    @discussion Type and arguments of callout C function that is used when an element value completion routine is called.
    @param context void * pointer to more data.
    @param result Completion result of desired operation.
    @param sender Interface instance sending the completion routine.
    @param multiple CFDictionaryRef containing the returned element key value pairs.
*/
public typealias IOHIDValueMultipleCallback = @convention(c) (UnsafeMutableRawPointer?, IOReturn, UnsafeMutableRawPointer?, CFDictionary) -> Void

/** @typedef IOHIDDeviceCallback
    @discussion Type and arguments of callout C function that is used when a device routine is called.
    @param context void * pointer to more data.
    @param result Completion result of desired operation.
    @param device IOHIDDeviceRef containing the sending device.
*/
public typealias IOHIDDeviceCallback = @convention(c) (UnsafeMutableRawPointer?, IOReturn, UnsafeMutableRawPointer?, IOHIDDevice) -> Void

/** @typedef IOHIDQueueRef
    This is the type of a reference to the IOHIDQueue.
*/
public class IOHIDQueue : Hashable {
}

/**
    @function   IOHIDQueueGetTypeID
    @abstract   Returns the type identifier of all IOHIDQueue instances.
*/
@available(macOS 10.5, *)
public func IOHIDQueueGetTypeID() -> CFTypeID

/**
    @function   IOHIDQueueCreate
    @abstract   Creates an IOHIDQueue object for the specified device.
    @discussion Take care in specifying an appropriate depth to prevent dropping
                events.
    @param      allocator Allocator to be used during creation.
    @param      device IOHIDDevice object 
    @param      depth The number of values that can be handled by the queue.
    @param      options Reserved for future use.
    @result     Returns a new IOHIDQueueRef.
*/
@available(macOS 10.5, *)
public func IOHIDQueueCreate(_ allocator: CFAllocator?, _ device: IOHIDDevice, _ depth: CFIndex, _ options: IOOptionBits) -> IOHIDQueue?

/**
    @function   IOHIDQueueGetDevice
    @abstract   Obtain the device associated with the queue.
    @param      queue IOHIDQueue to be queried. 
    @result     Returns the a reference to the device.
*/
@available(macOS 10.5, *)
public func IOHIDQueueGetDevice(_ queue: IOHIDQueue) -> IOHIDDevice

/**
    @function   IOHIDQueueGetDepth
    @abstract   Obtain the depth of the queue.
    @param      queue IOHIDQueue to be queried. 
    @result     Returns the queue depth.
*/
@available(macOS 10.5, *)
public func IOHIDQueueGetDepth(_ queue: IOHIDQueue) -> CFIndex

/**
    @function   IOHIDQueueSetDepth
    @abstract   Sets the depth of the queue.
    @discussion Set the appropriate depth value based on the number of elements
                contained in a queue.
    @param      queue IOHIDQueue object to be modified.
    @param      depth The new queue depth.
*/
@available(macOS 10.5, *)
public func IOHIDQueueSetDepth(_ queue: IOHIDQueue, _ depth: CFIndex)

/**
    @function   IOHIDQueueAddElement
    @abstract   Adds an element to the queue
    @param      queue IOHIDQueue object to be modified.
    @param      element Element to be added to the queue.
*/
@available(macOS 10.5, *)
public func IOHIDQueueAddElement(_ queue: IOHIDQueue, _ element: IOHIDElement)

/**
    @function   IOHIDQueueRemoveElement
    @abstract   Removes an element from the queue
    @param      queue IOHIDQueue object to be modified.
    @param      element Element to be removed from the queue.
*/
@available(macOS 10.5, *)
public func IOHIDQueueRemoveElement(_ queue: IOHIDQueue, _ element: IOHIDElement)

/**
    @function   IOHIDQueueContainsElement
    @abstract   Queries the queue to determine if elemement has been added.
    @param      queue IOHIDQueue object to be queried.
    @param      element Element to be queried.
    @result     Returns true or false depending if element is present.
*/
@available(macOS 10.5, *)
public func IOHIDQueueContainsElement(_ queue: IOHIDQueue, _ element: IOHIDElement) -> Bool

/** 
    @function   IOHIDQueueStart
    @abstract   Starts element value delivery to the queue.
    @discussion When a dispatch queue is assocaited with the IOHIDQueue
                via IOHIDQueueSetDispatchQueue, the queue does not need
                to be explicity started, this will be done during activation
                when IOHIDQueueActivate is called.
    @param      queue IOHIDQueue object to be started.
*/
@available(macOS 10.5, *)
public func IOHIDQueueStart(_ queue: IOHIDQueue)

/** 
    @function   IOHIDQueueStop
    @abstract   Stops element value delivery to the queue.
    @discussion When a dispatch queue is assocaited with the IOHIDQueue
                via IOHIDQueueSetDispatchQueue, the queue does not need
                to be explicity stopped, this will be done during cancellation
                when IOHIDQueueCancel is called.
    @param      queue IOHIDQueue object to be stopped.
*/
@available(macOS 10.5, *)
public func IOHIDQueueStop(_ queue: IOHIDQueue)

/**
    @function   IOHIDQueueScheduleWithRunLoop
    @abstract   Schedules queue with run loop.
    @discussion Formally associates queue with client's run loop. Scheduling
                this queue with the run loop is necessary before making 
                use of any asynchronous APIs.
    @param      queue IOHIDQueue object to be modified.
    @param      runLoop RunLoop to be used when scheduling any asynchronous 
                activity.
    @param      runLoopMode Run loop mode to be used when scheduling any 
                asynchronous activity.
*/
@available(macOS 10.5, *)
public func IOHIDQueueScheduleWithRunLoop(_ queue: IOHIDQueue, _ runLoop: CFRunLoop, _ runLoopMode: CFString)

/**
    @function   IOHIDQueueUnscheduleFromRunLoop
    @abstract   Unschedules queue with run loop.
    @discussion Formally disassociates queue with client's run loop.
    @param      queue IOHIDQueue object to be modified.
    @param      runLoop RunLoop to be used when scheduling any asynchronous 
                activity.
    @param      runLoopMode Run loop mode to be used when scheduling any 
                asynchronous activity.
*/
@available(macOS 10.5, *)
public func IOHIDQueueUnscheduleFromRunLoop(_ queue: IOHIDQueue, _ runLoop: CFRunLoop, _ runLoopMode: CFString)

/**
 * @function IOHIDQueueSetDispatchQueue
 *
 * @abstract
 * Sets the dispatch queue to be associated with the IOHIDQueue.
 * This is necessary in order to receive asynchronous events from the kernel.
 *
 * @discussion
 * An IOHIDQueue should not be associated with both a runloop and
 * dispatch queue. A call to IOHIDQueueSetDispatchQueue should only be made once.
 *
 * After a dispatch queue is set, the IOHIDQueue must make a call to activate
 * via IOHIDQueueActivate and cancel via IOHIDQueueCancel. All calls to "Register"
 * functions should be done before activation and not after cancellation.
 *
 * @param queue
 * Reference to an IOHIDQueue
 *
 * @param dispatchQueue
 * The dispatch queue to which the event handler block will be submitted.
 */
@available(macOS 10.15, *)
public func IOHIDQueueSetDispatchQueue(_ queue: IOHIDQueue, _ dispatchQueue: dispatch_queue_t)

/**
 * @function IOHIDQueueSetCancelHandler
 *
 * @abstract
 * Sets a cancellation handler for the dispatch queue associated with
 * IOHIDQueueSetDispatchQueue.
 *
 * @discussion
 * The cancellation handler (if specified) will be will be submitted to the
 * queue's dispatch queue in response to a call to IOHIDQueueCancel after all
 * the events have been handled.
 *
 * IOHIDQueueSetCancelHandler should not be used when scheduling with
 * a run loop.
 *
 * The IOHIDQueueRef should only be released after the queue has been
 * cancelled, and the cancel handler has been called. This is to ensure all
 * asynchronous objects are released. For example:
 *
 *     dispatch_block_t cancelHandler = dispatch_block_create(0, ^{
 *         CFRelease(queue);
 *     });
 *     IOHIDQueueSetCancelHandler(queue, cancelHandler);
 *     IOHIDQueueActivate(queue);
 *     IOHIDQueueCancel(queue);
 *
 * @param queue
 * Reference to an IOHIDQueue.
 *
 * @param handler
 * The cancellation handler block to be associated with the dispatch queue.
 */
@available(macOS 10.15, *)
public func IOHIDQueueSetCancelHandler(_ queue: IOHIDQueue, _ handler: @escaping () -> Void)

/**
 * @function IOHIDQueueActivate
 *
 * @abstract
 * Activates the IOHIDQueue object.
 *
 * @discussion
 * An IOHIDQueue object associated with a dispatch queue is created
 * in an inactive state. The object must be activated in order to
 * receive asynchronous events from the kernel.
 *
 * A dispatch queue must be set via IOHIDQueueSetDispatchQueue before
 * activation.
 *
 * An activated queue must be cancelled via IOHIDQueueCancel. All calls
 * to "Register" functions should be done before activation
 * and not after cancellation.
 *
 * Calling IOHIDQueueActivate on an active IOHIDQueue has no effect.
 *
 * @param queue
 * Reference to an IOHIDQueue
 */
@available(macOS 10.15, *)
public func IOHIDQueueActivate(_ queue: IOHIDQueue)

/**
 * @function IOHIDQueueCancel
 *
 * @abstract
 * Cancels the IOHIDQueue preventing any further invocation
 * of its event handler block.
 *
 * @discussion
 * Cancelling prevents any further invocation of the event handler block for
 * the specified dispatch queue, but does not interrupt an event handler
 * block that is already in progress.
 *
 * Explicit cancellation of the IOHIDQueue is required, no implicit
 * cancellation takes place.
 *
 * Calling IOHIDQueueCancel on an already cancelled queue has no effect.
 *
 * The IOHIDQueueRef should only be released after the queue has been
 * cancelled, and the cancel handler has been called. This is to ensure all
 * asynchronous objects are released. For example:
 *
 *     dispatch_block_t cancelHandler = dispatch_block_create(0, ^{
 *         CFRelease(queue);
 *     });
 *     IOHIDQueueSetCancelHandler(queue, cancelHandler);
 *     IOHIDQueueActivate(queue);
 *     IOHIDQueueCancel(queue);
 *
 * @param queue
 * Reference to an IOHIDQueue
 */
@available(macOS 10.15, *)
public func IOHIDQueueCancel(_ queue: IOHIDQueue)

/**
    @function   IOHIDQueueRegisterValueAvailableCallback
    @abstract   Sets callback to be used when the queue transitions to non-empty.
    @discussion In order to make use of asynchronous behavior, the queue needs
                to be scheduled with the run loop or dispatch queue.
                If a dispatch queue is set, this call must occur before activation.
    @param      queue IOHIDQueue object to be modified.
    @param      callback Callback of type IOHIDCallback to be used when data is 
                placed on the queue.
    @param      context Pointer to data to be passed to the callback.
*/
@available(macOS 10.5, *)
public func IOHIDQueueRegisterValueAvailableCallback(_ queue: IOHIDQueue, _ callback: IOHIDCallback, _ context: UnsafeMutableRawPointer?)

/** 
    @function   IOHIDQueueCopyNextValue
    @abstract   Dequeues a retained copy of an element value from the head of an 
                IOHIDQueue.
    @discussion Because the value is a retained copy, it is up to the caller to 
                release the value using CFRelease. Use with setValueCallback to 
                avoid polling the queue for data.
    @param      queue IOHIDQueue object to be queried.
    @result     Returns valid IOHIDValueRef if data is available.
*/
@available(macOS 10.5, *)
public func IOHIDQueueCopyNextValue(_ queue: IOHIDQueue) -> IOHIDValue?

/** 
    @function   IOHIDQueueCopyNextValueWithTimeout
    @abstract   Dequeues a retained copy of an element value from the head of an 
                IOHIDQueue.  This method will block until either a value is
                available or it times out.
    @discussion Because the value is a retained copy, it is up to the caller to 
                release the value using CFRelease. Use with setValueCallback to 
                avoid polling the queue for data.
    @param      queue IOHIDQueue object to be queried.
    @param      timeout Timeout before aborting an attempt to dequeue a value 
                from the head of a queue.
    @result     Returns valid IOHIDValueRef if data is available.
*/
@available(macOS 10.5, *)
public func IOHIDQueueCopyNextValueWithTimeout(_ queue: IOHIDQueue, _ timeout: CFTimeInterval) -> IOHIDValue?

/**
    @function   IOHIDDeviceGetTypeID
    @abstract   Returns the type identifier of all IOHIDDevice instances.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceGetTypeID() -> CFTypeID

/**
    @function   IOHIDDeviceCreate
    @abstract   Creates an element from an io_service_t.
    @discussion The io_service_t passed in this method must reference an object 
                in the kernel of type IOHIDDevice.
    @param      allocator Allocator to be used during creation.
    @param      service Reference to service object in the kernel.
    @result     Returns a new IOHIDDeviceRef.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceCreate(_ allocator: CFAllocator?, _ service: io_service_t) -> IOHIDDevice?

/**
    @function   IOHIDDeviceGetService
    @abstract   Returns the io_service_t for an IOHIDDevice, if it has one.
    @discussion If the IOHIDDevice references an object in the kernel, this is
                used to get the io_service_t for that object.
    @param      device Reference to an IOHIDDevice.
    @result     Returns the io_service_t if the IOHIDDevice has one, or 
                MACH_PORT_NULL if it does not.
 */
@available(macOS 10.6, *)
public func IOHIDDeviceGetService(_ device: IOHIDDevice) -> io_service_t

/**
    @function   IOHIDDeviceOpen
    @abstract   Opens a HID device for communication.
    @discussion Before the client can issue commands that change the state of 
                the device, it must have succeeded in opening the device. This 
                establishes a link between the client's task and the actual 
                device.  To establish an exclusive link use the 
                kIOHIDOptionsTypeSeizeDevice option. 
    @param      device Reference to an IOHIDDevice.
    @param      options Option bits to be sent down to the device.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceOpen(_ device: IOHIDDevice, _ options: IOOptionBits) -> IOReturn

/**
    @function   IOHIDDeviceClose
    @abstract   Closes communication with a HID device.
    @discussion This closes a link between the client's task and the actual 
                device.
    @param      device Reference to an IOHIDDevice.
    @param      options Option bits to be sent down to the device.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceClose(_ device: IOHIDDevice, _ options: IOOptionBits) -> IOReturn

/**
    @function   IOHIDDeviceConformsTo
    @abstract   Convenience function that scans the Application Collection 
                elements to see if it conforms to the provided usagePage 
                and usage.
    @discussion Examples of Application Collection usages pairs are:
                <br>
                    usagePage = kHIDPage_GenericDesktop  <br>
                    usage = kHIDUsage_GD_Mouse
                <br>
                <b>or</b>
                <br>
                    usagePage = kHIDPage_GenericDesktop  <br>
                    usage = kHIDUsage_GD_Keyboard
    @param      device Reference to an IOHIDDevice.
    @param      usagePage Device usage page
    @param      usage Device usage
    @result     Returns TRUE if device conforms to provided usage.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceConformsTo(_ device: IOHIDDevice, _ usagePage: UInt32, _ usage: UInt32) -> Bool

/**
    @function   IOHIDDeviceGetProperty
    @abstract   Obtains a property from an IOHIDDevice.
    @discussion Property keys are prefixed by kIOHIDDevice and declared in 
                <IOKit/hid/IOHIDKeys.h>.
    @param      device Reference to an IOHIDDevice.
    @param      key CFStringRef containing key to be used when querying the 
                device.
    @result     Returns CFTypeRef containing the property.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceGetProperty(_ device: IOHIDDevice, _ key: CFString) -> CFTypeRef?

/**
    @function   IOHIDDeviceSetProperty
    @abstract   Sets a property for an IOHIDDevice.
    @discussion Property keys are prefixed by kIOHIDDevice and declared in 
                <IOKit/hid/IOHIDKeys.h>.
    @param      device Reference to an IOHIDDevice.
    @param      key CFStringRef containing key to be used when modifiying the 
                device property.
    @param      property CFTypeRef containg the property to be set.
    @result     Returns TRUE if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceSetProperty(_ device: IOHIDDevice, _ key: CFString, _ property: CFTypeRef) -> Bool

/**
    @function   IOHIDDeviceCopyMatchingElements
    @abstract   Obtains HID elements that match the criteria contained in the 
                matching dictionary.
    @discussion Matching keys are prefixed by kIOHIDElement and declared in 
                <IOKit/hid/IOHIDKeys.h>. Passing a NULL dictionary will result
                in all device elements being returned.
    @param      device Reference to an IOHIDDevice.
    @param      matching CFDictionaryRef containg element matching criteria.
    @param      options Reserved for future use.
    @result     Returns CFArrayRef containing multiple IOHIDElement object.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceCopyMatchingElements(_ device: IOHIDDevice, _ matching: CFDictionary?, _ options: IOOptionBits) -> CFArray?

/** @function   IOHIDDeviceScheduleWithRunLoop
    @abstract   Schedules HID device with run loop.
    @discussion Formally associates device with client's run loop. Scheduling
                this device with the run loop is necessary before making use of
                any asynchronous APIs.
    @param      device Reference to an IOHIDDevice.
    @param      runLoop RunLoop to be used when scheduling any asynchronous 
                activity.
    @param      runLoopMode Run loop mode to be used when scheduling any 
                asynchronous activity.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceScheduleWithRunLoop(_ device: IOHIDDevice, _ runLoop: CFRunLoop, _ runLoopMode: CFString)

/** @function   IOHIDDeviceUnscheduleFromRunLoop
    @abstract   Unschedules HID device with run loop.
    @discussion Formally disassociates device with client's run loop.
    @param      device Reference to an IOHIDDevice.
    @param      runLoop RunLoop to be used when unscheduling any asynchronous 
                activity.
    @param      runLoopMode Run loop mode to be used when unscheduling any 
                asynchronous activity.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceUnscheduleFromRunLoop(_ device: IOHIDDevice, _ runLoop: CFRunLoop, _ runLoopMode: CFString)

/** @function   IOHIDDeviceSetDispatchQueue
    @abstract   Sets the dispatch queue to be associated with the IOHIDDevice.
                This is necessary in order to receive asynchronous events from the kernel.
    @discussion An IOHIDDevice should not be associated with both a runloop and
                dispatch queue. A call to IOHIDDeviceSetDispatchQueue should only be made once.
                After a dispatch queue is set, the IOHIDDevice must make a call to activate
                via IOHIDDeviceActivate and cancel via IOHIDDeviceCancel. All calls to "Register"
                functions should be done before activation and not after cancellation.
    @param      device Reference to an IOHIDDevice
    @param      queue The dispatch queue to which the event handler block will be submitted.
*/
@available(macOS 10.15, *)
public func IOHIDDeviceSetDispatchQueue(_ device: IOHIDDevice, _ queue: dispatch_queue_t)

/** @function   IOHIDDeviceSetCancelHandler
    @abstract   Sets a cancellation handler for the dispatch queue associated with
                IOHIDDeviceSetDispatchQueue.
    @discussion The cancellation handler (if specified) will be will be submitted to the
                device's dispatch queue in response to a call to IOHIDDeviceCancel after
                all the events have been handled.
                IOHIDDeviceSetCancelHandler should not be used when scheduling with
                a run loop.
                The IOHIDDeviceRef should only be released after the device has been
                cancelled, and the cancel handler has been called. This is to ensure all
                asynchronous objects are released. For example:
                    dispatch_block_t cancelHandler = dispatch_block_create(0, ^{
                        CFRelease(device);
                    });
                    IOHIDDeviceSetCancelHandler(device, cancelHandler);
                    IOHIDDeviceActivate(device);
                    IOHIDDeviceCancel(device);
    @param      device Reference to an IOHIDDevice.
    @param      handler The cancellation handler block to be associated with the dispatch queue.
 */
@available(macOS 10.15, *)
public func IOHIDDeviceSetCancelHandler(_ device: IOHIDDevice, _ handler: @escaping () -> Void)

/** @function   IOHIDDeviceActivate
    @abstract   Activates the IOHIDDevice object.
    @discussion An IOHIDDevice object associated with a dispatch queue is created
                in an inactive state. The object must be activated in order to
                receive asynchronous events from the kernel.
                A dispatch queue must be set via IOHIDDeviceSetDispatchQueue before
                activation.
                An activated device must be cancelled via IOHIDDeviceCancel. All calls
                to "Register" functions should be done before activation
                and not after cancellation.
                Calling IOHIDDeviceActivate on an active IOHIDDevice has no effect.
    @param      device Reference to an IOHIDDevice
 */
@available(macOS 10.15, *)
public func IOHIDDeviceActivate(_ device: IOHIDDevice)

/** @function   IOHIDDeviceCancel
    @abstract   Cancels the IOHIDDevice preventing any further invocation
                of its event handler block.
    @discussion Cancelling prevents any further invocation of the event handler block for
                the specified dispatch queue, but does not interrupt an event handler
                block that is already in progress.
                Explicit cancellation of the IOHIDDevice is required, no implicit
                cancellation takes place.
                Calling IOHIDDeviceCancel on an already cancelled queue has no effect.
                The IOHIDDeviceRef should only be released after the device has been
                cancelled, and the cancel handler has been called. This is to ensure all
                asynchronous objects are released. For example:
                    dispatch_block_t cancelHandler = dispatch_block_create(0, ^{
                        CFRelease(device);
                    });
                    IOHIDDeviceSetCancelHandler(device, cancelHandler);
                    IOHIDDeviceActivate(device);
                    IOHIDDeviceCancel(device);
    @param      device Reference to an IOHIDDevice
 */
@available(macOS 10.15, *)
public func IOHIDDeviceCancel(_ device: IOHIDDevice)

/** @function   IOHIDDeviceRegisterRemovalCallback
    @abstract   Registers a callback to be used when a IOHIDDevice is removed.
    @discussion In most cases this occurs when a device is unplugged.
                If a dispatch queue is set, this call must occur before activation.
    @param      device Reference to an IOHIDDevice.
    @param      callback Pointer to a callback method of type IOHIDCallback.
    @param      context Pointer to data to be passed to the callback.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceRegisterRemovalCallback(_ device: IOHIDDevice, _ callback: IOHIDCallback?, _ context: UnsafeMutableRawPointer?)

/** @function   IOHIDDeviceRegisterInputValueCallback
    @abstract   Registers a callback to be used when an input value is issued by 
                the device.
    @discussion An input element refers to any element of type 
                kIOHIDElementTypeInput and is usually issued by interrupt driven
                reports. If more specific element values are desired, you can
                specify matching criteria via IOHIDDeviceSetInputValueMatching
                and IOHIDDeviceSetInputValueMatchingMultiple.
                If a dispatch queue is set, this call must occur before activation.
    @param      device Reference to an IOHIDDevice.
    @param      callback Pointer to a callback method of type IOHIDValueCallback.
    @param      context Pointer to data to be passed to the callback.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceRegisterInputValueCallback(_ device: IOHIDDevice, _ callback: IOHIDValueCallback?, _ context: UnsafeMutableRawPointer?)

/** @function   IOHIDDeviceRegisterInputReportCallback
    @abstract   Registers a callback to be used when an input report is issued 
                by the device.
    @discussion An input report is an interrupt driver report issued by the 
                device.
                If a dispatch queue is set, this call must occur before activation.
    @param      device Reference to an IOHIDDevice.
    @param      report Pointer to preallocated buffer in which to copy inbound
                report data.
    @param      reportLength Length of preallocated buffer.
    @param      callback Pointer to a callback method of type 
                IOHIDReportCallback.
    @param      context Pointer to data to be passed to the callback.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceRegisterInputReportCallback(_ device: IOHIDDevice, _ report: UnsafeMutablePointer<UInt8>, _ reportLength: CFIndex, _ callback: IOHIDReportCallback?, _ context: UnsafeMutableRawPointer?)

/** @function   IOHIDDeviceRegisterInputReportWithTimeStampCallback
    @abstract   Registers a timestamped callback to be used when an input report is issued 
                by the device.
    @discussion An input report is an interrupt driver report issued by the 
                device.
                If a dispatch queue is set, this call must occur before activation.
    @param      device Reference to an IOHIDDevice.
    @param      report Pointer to preallocated buffer in which to copy inbound
                report data.
    @param      reportLength Length of preallocated buffer.
    @param      callback Pointer to a callback method of type 
                IOHIDReportWithTimeStampCallback.
    @param      context Pointer to data to be passed to the callback.
*/
@available(macOS 10.10, *)
public func IOHIDDeviceRegisterInputReportWithTimeStampCallback(_ device: IOHIDDevice, _ report: UnsafeMutablePointer<UInt8>, _ reportLength: CFIndex, _ callback: IOHIDReportWithTimeStampCallback?, _ context: UnsafeMutableRawPointer?)

/** @function   IOHIDDeviceSetInputValueMatching
    @abstract   Sets matching criteria for input values received via 
                IOHIDDeviceRegisterInputValueCallback.
    @discussion Matching keys are prefixed by kIOHIDElement and declared in 
                <IOKit/hid/IOHIDKeys.h>. Passing a NULL dictionary will result
                in all devices being enumerated. Any subsequent calls will cause
                the hid manager to release previously matched input elements and 
                restart the matching process using the revised criteria. If
                interested in multiple, specific device elements, please defer to
                using IOHIDDeviceSetInputValueMatchingMultiple.
                If a dispatch queue is set, this call must occur before activation.
    @param      device Reference to an IOHIDDevice.
    @param      matching CFDictionaryRef containg device matching criteria.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceSetInputValueMatching(_ device: IOHIDDevice, _ matching: CFDictionary?)

/** @function   IOHIDDeviceSetInputValueMatchingMultiple
    @abstract   Sets multiple matching criteria for input values received via 
                IOHIDDeviceRegisterInputValueCallback.
    @discussion Matching keys are prefixed by kIOHIDElement and declared in 
                <IOKit/hid/IOHIDKeys.h>. This method is useful if interested
                in multiple, specific elements.
                If a dispatch queue is set, this call must occur before activation.
    @param      device Reference to an IOHIDDevice.
    @param      multiple CFArrayRef containing multiple CFDictionaryRef objects
                containg input element matching criteria.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceSetInputValueMatchingMultiple(_ device: IOHIDDevice, _ multiple: CFArray?)

/** @function   IOHIDDeviceSetValue
    @abstract   Sets a value for an element.
    @discussion This method behaves synchronously and will block until the
                report has been issued to the device. It is only relevent for
                either output or feature type elements. If setting values for
                multiple elements you may want to consider using 
                IOHIDDeviceSetValueMultiple or IOHIDTransaction.
    @param      device Reference to an IOHIDDevice.
    @param      element IOHIDElementRef whose value is to be modified.
    @param      value IOHIDValueRef containing value to be set.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceSetValue(_ device: IOHIDDevice, _ element: IOHIDElement, _ value: IOHIDValue) -> IOReturn

/** @function   IOHIDDeviceSetValueMultiple
    @abstract   Sets multiple values for multiple elements.
    @discussion This method behaves synchronously and will block until the
                report has been issued to the device. It is only relevent for
                either output or feature type elements.
    @param      device Reference to an IOHIDDevice.
    @param      multiple CFDictionaryRef where key is IOHIDElementRef and
                value is IOHIDValueRef.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceSetValueMultiple(_ device: IOHIDDevice, _ multiple: CFDictionary) -> IOReturn

/** @function   IOHIDDeviceSetValueWithCallback
    @abstract   Sets a value for an element.
    @discussion This method currently only behaves synchronously and will not
                invoke the callback. It is only relevent for either output or
                feature type elements. If setting values for multiple elements
                you may want to consider using
                IOHIDDeviceSetValueMultipleWithCallback or IOHIDTransaction.
    @param      device Reference to an IOHIDDevice.
    @param      element IOHIDElementRef whose value is to be modified.
    @param      value IOHIDValueRef containing value to be set.
    @param      timeout Currently unused.
    @param      callback Currently unused.
    @param      context Pointer to data to be passed to the callback.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceSetValueWithCallback(_ device: IOHIDDevice, _ element: IOHIDElement, _ value: IOHIDValue, _ timeout: CFTimeInterval, _ callback: IOHIDValueCallback?, _ context: UnsafeMutableRawPointer?) -> IOReturn

/** @function   IOHIDDeviceSetValueMultipleWithCallback
    @abstract   Sets multiple values for multiple elements and returns status 
                via a completion callback.
    @discussion This method behaves asynchronously and will invoke the callback
                once the report has been issued to the device. It is only
                relevent for either output or feature type elements.  
    @param      device Reference to an IOHIDDevice.
    @param      multiple CFDictionaryRef where key is IOHIDElementRef and
                value is IOHIDValueRef.
    @param      timeout CFTimeInterval containing the timeout in milliseconds.
    @param      callback Pointer to a callback method of type 
                IOHIDValueMultipleCallback.
    @param      context Pointer to data to be passed to the callback.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceSetValueMultipleWithCallback(_ device: IOHIDDevice, _ multiple: CFDictionary, _ timeout: CFTimeInterval, _ callback: IOHIDValueMultipleCallback?, _ context: UnsafeMutableRawPointer?) -> IOReturn

/** @function   IOHIDDeviceGetValue
    @abstract   Gets a value for an element.
    @discussion This method behaves synchronously and returns immediately
                for input type elements. If requesting a value for a feature
                element, this will block until the report has been issued to the
                device. If obtaining values for multiple elements you may want
                to consider using IOHIDDeviceCopyValueMultiple or IOHIDTransaction.
    @param      device Reference to an IOHIDDevice.
    @param      element IOHIDElementRef whose value is to be obtained.
    @param      pValue Pointer to IOHIDValueRef to be obtained.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceGetValue(_ device: IOHIDDevice, _ element: IOHIDElement, _ pValue: UnsafeMutablePointer<Unmanaged<IOHIDValue>>) -> IOReturn

public enum IOHIDDeviceGetValueOptions : UInt32, @unchecked Sendable {

    case withUpdate = 131072

    case withoutUpdate = 262144
}

/** @function   IOHIDDeviceGetValueWithOptions
    @abstract   Gets a value for an element.
    @discussion This method behaves synchronously and returns immediately
                for input type elements. If requesting a value for a feature
                element, this will block until the report has been issued to the
                device. If obtaining values for multiple elements you may want
                to consider using IOHIDDeviceCopyValueMultiple or IOHIDTransaction.
    @param      device Reference to an IOHIDDevice.
    @param      element IOHIDElementRef whose value is to be obtained.
    @param      pValue Pointer to IOHIDValueRef to be obtained.
    @param      options (see IOHIDDeviceGetValueOptions).
    @result     Returns kIOReturnSuccess if successful.
 */
@available(macOS 10.13, *)
public func IOHIDDeviceGetValueWithOptions(_ device: IOHIDDevice, _ element: IOHIDElement, _ pValue: UnsafeMutablePointer<Unmanaged<IOHIDValue>>, _ options: UInt32) -> IOReturn

/** @function   IOHIDDeviceCopyValueMultiple
    @abstract   Copies a values for multiple elements.
    @discussion This method behaves synchronously and returns immediately
                for input type elements. If requesting a value for a feature
                element, this will block until the report has been issued to the
                device.
    @param      device Reference to an IOHIDDevice.
    @param      elements CFArrayRef containing multiple IOHIDElementRefs whose 
                values are to be obtained.
    @param      pMultiple Pointer to CFDictionaryRef where the keys are the 
                provided elements and the values are the requested values.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceCopyValueMultiple(_ device: IOHIDDevice, _ elements: CFArray, _ pMultiple: UnsafeMutablePointer<Unmanaged<CFDictionary>?>?) -> IOReturn

/** @function   IOHIDDeviceGetValueWithCallback
    @abstract   Gets a value for an element.
    @discussion This method currently only behaves synchronously and will not
                invoke the callback. It is only relevent for either output or
                feature type elements. If setting values for multiple elements
                you may want to consider using
                IOHIDDeviceCopyValueMultipleWithCallback or IOHIDTransaction.
    @param      device Reference to an IOHIDDevice.
    @param      element IOHIDElementRef whose value is to be obtained.
    @param      pValue Pointer to IOHIDValueRef to be passedback.
    @param      timeout Currently unused.
    @param      callback Currently unused.
    @param      context Pointer to data to be passed to the callback.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceGetValueWithCallback(_ device: IOHIDDevice, _ element: IOHIDElement, _ pValue: UnsafeMutablePointer<Unmanaged<IOHIDValue>>, _ timeout: CFTimeInterval, _ callback: IOHIDValueCallback?, _ context: UnsafeMutableRawPointer?) -> IOReturn

/** @function   IOHIDDeviceCopyValueMultipleWithCallback
    @abstract   Copies a values for multiple elements and returns status via a 
                completion callback.
    @discussion This method behaves asynchronusly and is only relevent for 
                either output or feature type elements.
    @param      device Reference to an IOHIDDevice.
    @param      elements CFArrayRef containing multiple IOHIDElementRefs whose 
                values are to be obtained.
    @param      pMultiple Pointer to CFDictionaryRef where the keys are the 
                provided elements and the values are the requested values.
    @param      timeout CFTimeInterval containing the timeout in milliseconds.
    @param      callback Pointer to a callback method of type 
                IOHIDValueMultipleCallback.
    @param      context Pointer to data to be passed to the callback.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceCopyValueMultipleWithCallback(_ device: IOHIDDevice, _ elements: CFArray, _ pMultiple: UnsafeMutablePointer<Unmanaged<CFDictionary>?>?, _ timeout: CFTimeInterval, _ callback: IOHIDValueMultipleCallback?, _ context: UnsafeMutableRawPointer?) -> IOReturn

/** @function   IOHIDDeviceSetReport
    @abstract   Sends a report to the device.
    @discussion This method behaves synchronously and will block until the
                report has been issued to the device. It is only relevent for
                either output or feature type reports.
    @param      device Reference to an IOHIDDevice.
    @param      reportType Type of report being sent.
    @param      reportID ID of the report being sent.  If the device supports
                multiple reports, this should also be set in the first byte of
                the report.
    @param      report The report bytes to be sent to the device.
    @param      reportLength The length of the report to be sent to the device.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceSetReport(_ device: IOHIDDevice, _ reportType: IOHIDReportType, _ reportID: CFIndex, _ report: UnsafePointer<UInt8>, _ reportLength: CFIndex) -> IOReturn

/** @function   IOHIDDeviceSetReportWithCallback
    @abstract   Sends a report to the device.
    @discussion This method behaves asynchronously. It is only relevent for
                either output or feature type reports.
    @param      device Reference to an IOHIDDevice.
    @param      reportType Type of report being sent.
    @param      reportID ID of the report being sent. If the device supports
                multiple reports, this should also be set in the first byte of
                the report.
    @param      report The report bytes to be sent to the device.
    @param      reportLength The length of the report to be sent to the device.
    @param      timeout CFTimeInterval containing the timeout in milliseconds.
    @param      callback Pointer to a callback method of type 
                IOHIDReportCallback.
    @param      context Pointer to data to be passed to the callback.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceSetReportWithCallback(_ device: IOHIDDevice, _ reportType: IOHIDReportType, _ reportID: CFIndex, _ report: UnsafePointer<UInt8>, _ reportLength: CFIndex, _ timeout: CFTimeInterval, _ callback: IOHIDReportCallback?, _ context: UnsafeMutableRawPointer?) -> IOReturn

/** @function   IOHIDDeviceGetReport
    @abstract   Obtains a report from the device.
    @discussion This method behaves synchronously and will block until the
                report has been received from the device. It is only relevent for
                either output or feature type reports. Please defer to using
                IOHIDDeviceRegisterInputReportCallback for obtaining input 
                reports.
    @param      device Reference to an IOHIDDevice.
    @param      reportType Type of report being requested.
    @param      reportID ID of the report being requested.
    @param      report Pointer to preallocated buffer in which to copy inbound
                report data.
    @param      pReportLength Pointer to length of preallocated buffer.  This
                value will be modified to refect the length of the returned 
                report.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceGetReport(_ device: IOHIDDevice, _ reportType: IOHIDReportType, _ reportID: CFIndex, _ report: UnsafeMutablePointer<UInt8>, _ pReportLength: UnsafeMutablePointer<CFIndex>) -> IOReturn

/** @function   IOHIDDeviceGetReportWithCallback
    @abstract   Obtains a report from the device.
    @discussion This method behaves asynchronously. It is only relevent for
                either output or feature type reports. Please defer to using
                IOHIDDeviceRegisterInputReportCallback for obtaining input
                reports.
    @param      device Reference to an IOHIDDevice.
    @param      reportType Type of report being requested.
    @param      reportID ID of the report being requested.
    @param      report Pointer to preallocated buffer in which to copy inbound
                report data.
    @param      pReportLength Pointer to length of preallocated buffer. This
                value will be modified to refect the length of the returned 
                report.
    @param      timeout CFTimeInterval containing the timeout in milliseconds.
    @param      callback Pointer to a callback method of type 
                IOHIDReportCallback.
    @param      context Pointer to data to be passed to the callback.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDDeviceGetReportWithCallback(_ device: IOHIDDevice, _ reportType: IOHIDReportType, _ reportID: CFIndex, _ report: UnsafeMutablePointer<UInt8>, _ pReportLength: UnsafeMutablePointer<CFIndex>, _ timeout: CFTimeInterval, _ callback: IOHIDReportCallback, _ context: UnsafeMutableRawPointer) -> IOReturn

/**
    @function   IOHIDElementGetTypeID
    @abstract   Returns the type identifier of all IOHIDElement instances.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetTypeID() -> CFTypeID

/**
    @function   IOHIDElementCreateWithDictionary
    @abstract   Creates an element from a dictionary.
    @discussion The dictionary should contain keys defined in IOHIDKeys.h and start with kIOHIDElement.  This call is meant be used by a IOHIDDeviceDeviceInterface object.
    @param      allocator Allocator to be used during creation.
    @param      dictionary dictionary containing values in which to create element.
    @result     Returns a new IOHIDElementRef.
*/
@available(macOS 10.5, *)
public func IOHIDElementCreateWithDictionary(_ allocator: CFAllocator?, _ dictionary: CFDictionary) -> IOHIDElement

/**
    @function   IOHIDElementGetDevice
    @abstract   Obtain the device associated with the element.
    @param      element IOHIDElement to be queried. 
    @result     Returns the a reference to the device.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetDevice(_ element: IOHIDElement) -> IOHIDDevice

/**
    @function   IOHIDElementGetParent
    @abstract   Returns the parent for the element.
    @discussion The parent element can be an element of type kIOHIDElementTypeCollection.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns an IOHIDElementRef referencing the parent element.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetParent(_ element: IOHIDElement) -> IOHIDElement?

/**
    @function   IOHIDElementGetChildren
    @abstract   Returns the children for the element.
    @discussion An element of type kIOHIDElementTypeCollection usually contains children.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns an CFArrayRef containing element objects of type IOHIDElementRef.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetChildren(_ element: IOHIDElement) -> CFArray?

/**
    @function   IOHIDElementAttach
    @abstract   Establish a relationship between one or more elements.
    @discussion This is useful for grouping HID elements with related functionality.
    @param      element The element to be modified. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @param      toAttach The element to be attached. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
*/
@available(macOS 10.5, *)
public func IOHIDElementAttach(_ element: IOHIDElement, _ toAttach: IOHIDElement)

/**
    @function   IOHIDElementDetach
    @abstract   Remove a relationship between one or more elements.
    @discussion This is useful for grouping HID elements with related functionality.
    @param      element The element to be modified. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @param      toDetach The element to be detached. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
*/
@available(macOS 10.5, *)
public func IOHIDElementDetach(_ element: IOHIDElement, _ toDetach: IOHIDElement)

/**
    @function   IOHIDElementCopyAttached
    @abstract   Obtain attached elements.
    @discussion Attached elements are those that have been grouped via IOHIDElementAttach.
    @param      element The element to be modified. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns a copy of the current attached elements.
*/
@available(macOS 10.5, *)
public func IOHIDElementCopyAttached(_ element: IOHIDElement) -> CFArray?

/**
    @function   IOHIDElementGetCookie
    @abstract   Retrieves the cookie for the element.
    @discussion The IOHIDElementCookie represent a unique identifier for an element within a device.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the IOHIDElementCookie for the element.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetCookie(_ element: IOHIDElement) -> IOHIDElementCookie

/**
    @function   IOHIDElementGetType
    @abstract   Retrieves the type for the element.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the IOHIDElementType for the element.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetType(_ element: IOHIDElement) -> IOHIDElementType

/**
    @function   IOHIDElementGetCollectionType
    @abstract   Retrieves the collection type for the element.
    @discussion The value returned by this method only makes sense if the element type is kIOHIDElementTypeCollection.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the IOHIDElementCollectionType for the element.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetCollectionType(_ element: IOHIDElement) -> IOHIDElementCollectionType

/**
    @function   IOHIDElementGetUsagePage
    @abstract   Retrieves the usage page for an element.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the usage page for the element.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetUsagePage(_ element: IOHIDElement) -> UInt32

/**
    @function   IOHIDElementGetUsage
    @abstract   Retrieves the usage for an element.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the usage for the element.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetUsage(_ element: IOHIDElement) -> UInt32

/**
    @function   IOHIDElementIsVirtual
    @abstract   Returns the virtual property for the element.
    @discussion Indicates whether the element is a virtual element.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the TRUE if virtual or FALSE if not.
*/
@available(macOS 10.5, *)
public func IOHIDElementIsVirtual(_ element: IOHIDElement) -> Bool

/**
    @function   IOHIDElementIsRelative
    @abstract   Returns the relative property for the element.
    @discussion Indicates whether the data is relative (indicating the change in value from the last report) or absolute 
                (based on a fixed origin).
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns TRUE if relative or FALSE if absolute.
*/
@available(macOS 10.5, *)
public func IOHIDElementIsRelative(_ element: IOHIDElement) -> Bool

/**
    @function   IOHIDElementIsWrapping
    @abstract   Returns the wrap property for the element.
    @discussion Wrap indicates whether the data "rolls over" when reaching either the extreme high or low value.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns TRUE if wrapping or FALSE if non-wrapping.
*/
@available(macOS 10.5, *)
public func IOHIDElementIsWrapping(_ element: IOHIDElement) -> Bool

/**
    @function   IOHIDElementIsArray
    @abstract   Returns the array property for the element.
    @discussion Indicates whether the element represents variable or array data values. Variable values represent data from a 
                physical control.  An array returns an index in each field that corresponds to the pressed button 
                (like keyboard scan codes).
                <br>
                <b>Note:</b> The HID Manager will represent most elements as "variable" including the possible usages of an array.  
                Array indices will remain as "array" elements with a usage of 0xffffffff.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns TRUE if array or FALSE if variable.
*/
@available(macOS 10.5, *)
public func IOHIDElementIsArray(_ element: IOHIDElement) -> Bool

/**
    @function   IOHIDElementIsNonLinear
    @abstract   Returns the linear property for the element.
    @discussion Indicates whether the value for the element has been processed in some way, and no longer represents a linear 
                relationship between what is measured and the value that is reported.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns TRUE if non linear or FALSE if linear.
*/
@available(macOS 10.5, *)
public func IOHIDElementIsNonLinear(_ element: IOHIDElement) -> Bool

/**
    @function   IOHIDElementHasPreferredState
    @abstract   Returns the preferred state property for the element.
    @discussion Indicates whether the element has a preferred state to which it will return when the user is not physically 
                interacting with the control.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns TRUE if preferred state or FALSE if no preferred state.
*/
@available(macOS 10.5, *)
public func IOHIDElementHasPreferredState(_ element: IOHIDElement) -> Bool

/**
    @function   IOHIDElementHasNullState
    @abstract   Returns the null state property for the element.
    @discussion Indicates whether the element has a state in which it is not sending meaningful data. 
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns TRUE if null state or FALSE if no null state.
*/
@available(macOS 10.5, *)
public func IOHIDElementHasNullState(_ element: IOHIDElement) -> Bool

/**
    @function   IOHIDElementGetName
    @abstract   Returns the name for the element.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns CFStringRef containing the element name.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetName(_ element: IOHIDElement) -> CFString

/**
    @function   IOHIDElementGetReportID
    @abstract   Returns the report ID for the element.
    @discussion The report ID represents what report this particular element belongs to.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the report ID.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetReportID(_ element: IOHIDElement) -> UInt32

/**
    @function   IOHIDElementGetReportSize
    @abstract   Returns the report size in bits for the element.
    @discussion If the element is an array type the total number of bit in the element is equal to
                IOHIDElementGetReportSize(element) * IOHIDElementGetReportCount(element). Otherwise this size is the
                total number of bits in the element.

    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the report size.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetReportSize(_ element: IOHIDElement) -> UInt32

/**
    @function   IOHIDElementGetReportCount
    @abstract   Returns the report count for the element.
    @discussion If the IOHIDElementGetReportCount(element) is greater than one and the element does not represent an
                array then the element represents a repeated set of usages, the size of each usage in the element is
                IOHIDElementGetReportSize(element) / IOHIDElementGetReportCount(element).

    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the report count.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetReportCount(_ element: IOHIDElement) -> UInt32

/**
    @function   IOHIDElementGetUnit
    @abstract   Returns the unit property for the element.
    @discussion The unit property is described in more detail in Section 6.2.2.7 of the 
                "Device Class Definition for Human Interface Devices(HID)" Specification, Version 1.11.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the unit.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetUnit(_ element: IOHIDElement) -> UInt32

/**
    @function   IOHIDElementGetUnitExponent
    @abstract   Returns the code associated with the unit exponent as outlined in the HID spec
    @discussion The unit exponent property is described in more detail in Section 6.2.2.7 of the 
                "Device Class Definition for Human Interface Devices(HID)" Specification, Version 1.11.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the unit exponent.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetUnitExponent(_ element: IOHIDElement) -> UInt32

/**
    @function   IOHIDElementGetLogicalMin
    @abstract   Returns the minimum value possible for the element.
    @discussion This corresponds to the logical minimun, which indicates the lower bounds of a variable element.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the logical minimum.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetLogicalMin(_ element: IOHIDElement) -> CFIndex

/**
    @function   IOHIDElementGetLogicalMax
    @abstract   Returns the maximum value possible for the element.
    @discussion This corresponds to the logical maximum, which indicates the upper bounds of a variable element.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the logical maximum.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetLogicalMax(_ element: IOHIDElement) -> CFIndex

/**
    @function   IOHIDElementGetPhysicalMin
    @abstract   Returns the scaled minimum value possible for the element.
    @discussion Minimum value for the physical extent of a variable element. This represents the value for the logical minimum with units applied to it.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the physical minimum.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetPhysicalMin(_ element: IOHIDElement) -> CFIndex

/**
    @function   IOHIDElementGetPhysicalMax
    @abstract   Returns the scaled maximum value possible for the element.
    @discussion Maximum value for the physical extent of a variable element.  This represents the value for the logical maximum with units applied to it.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @result     Returns the physical maximum.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetPhysicalMax(_ element: IOHIDElement) -> CFIndex

/**
    @function   IOHIDElementGetProperty
    @abstract   Returns the an element property.
    @discussion Property keys are prefixed by kIOHIDElement and declared in IOHIDKeys.h.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @param      key The key to be used when querying the element.
    @result     Returns the property.
*/
@available(macOS 10.5, *)
public func IOHIDElementGetProperty(_ element: IOHIDElement, _ key: CFString) -> CFTypeRef?

/**
    @function   IOHIDElementSetProperty
    @abstract   Sets an element property.
    @discussion This method can be used to set arbitrary element properties, such as application specific references.
    @param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
    @param      key The key to be used when querying the element.
    @result     Returns TRUE if successful.
*/
@available(macOS 10.5, *)
public func IOHIDElementSetProperty(_ element: IOHIDElement, _ key: CFString, _ property: CFTypeRef) -> Bool

public struct IOHIDEventStruct {

    public init()

    public init(type: IOHIDElementType, elementCookie: IOHIDElementCookie, value: Int32, timestamp: AbsoluteTime, longValueSize: UInt32, longValue: UnsafeMutableRawPointer!)

    public var type: IOHIDElementType

    public var elementCookie: IOHIDElementCookie

    public var value: Int32

    public var timestamp: AbsoluteTime

    public var longValueSize: UInt32

    public var longValue: UnsafeMutableRawPointer!
}

/** @typedef IOHIDCallbackFunction
    @discussion Type and arguments of callout C function that is used when a
                completion routine is called, see
                IOHIDLib.h:setRemovalCallback().
    @param target void * pointer to your data, often a pointer to an object.
    @param result Completion result of desired operation.
    @param refcon void * pointer to more data.
    @param sender Interface instance sending the completion routine.
*/
public typealias IOHIDCallbackFunction = @convention(c) (UnsafeMutableRawPointer?, IOReturn, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> Void

/** @typedef IOHIDElementCallbackFunction
    @discussion Type and arguments of callout C function that is used when a
                completion routine is called, see IOHIDLib.h:setElementValue().
    @param target void * pointer to your data, often a pointer to an object.
    @param result Completion result of desired operation.
    @param refcon void * pointer to more data.
    @param sender Interface instance sending the completion routine.
    @param elementCookie Element within interface instance sending completion.
*/
public typealias IOHIDElementCallbackFunction = @convention(c) (UnsafeMutableRawPointer?, IOReturn, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?, IOHIDElementCookie) -> Void

/** @typedef IOHIDReportCallbackFunction
    @discussion Type and arguments of callout C function that is used when a
                completion routine is called, see IOHIDLib.h:setReport().
    @param target void * pointer to your data, often a pointer to an object.
    @param result Completion result of desired operation.
    @param refcon void * pointer to more data.
    @param sender Interface instance sending the completion routine.
    @param bufferSize Size of the buffer received upon completion.
*/
public typealias IOHIDReportCallbackFunction = @convention(c) (UnsafeMutableRawPointer?, IOReturn, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?, UInt32) -> Void

public struct IOHIDDeviceInterface {

    public init()

    public init(_reserved: UnsafeMutableRawPointer!, QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!, AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, createAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFRunLoopSource>?>?) -> IOReturn)!, getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?) -> Unmanaged<CFRunLoopSource>?)!, createAsyncPort: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<mach_port_t>?) -> IOReturn)!, getAsyncPort: (@convention(c) (UnsafeMutableRawPointer?) -> mach_port_t)!, open: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, close: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, setRemovalCallback: (@convention(c) (UnsafeMutableRawPointer?, IOHIDCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, getElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!, setElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?, UInt32, IOHIDElementCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, queryElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?, UInt32, IOHIDElementCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, startAllQueues: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, stopAllQueues: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, allocQueue: (@convention(c) (UnsafeMutableRawPointer?) -> UnsafeMutablePointer<UnsafeMutablePointer<IOHIDQueueInterface>?>?)!, allocOutputTransaction: (@convention(c) (UnsafeMutableRawPointer?) -> UnsafeMutablePointer<UnsafeMutablePointer<IOHIDOutputTransactionInterface>?>?)!, setReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutableRawPointer?, UInt32, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, getReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt32>?, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!)

    public var _reserved: UnsafeMutableRawPointer!

    public var QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!

    public var AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var createAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFRunLoopSource>?>?) -> IOReturn)!

    public var getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?) -> Unmanaged<CFRunLoopSource>?)!

    public var createAsyncPort: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<mach_port_t>?) -> IOReturn)!

    public var getAsyncPort: (@convention(c) (UnsafeMutableRawPointer?) -> mach_port_t)!

    public var open: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var close: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var setRemovalCallback: (@convention(c) (UnsafeMutableRawPointer?, IOHIDCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var getElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!

    public var setElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?, UInt32, IOHIDElementCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var queryElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?, UInt32, IOHIDElementCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var startAllQueues: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var stopAllQueues: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var allocQueue: (@convention(c) (UnsafeMutableRawPointer?) -> UnsafeMutablePointer<UnsafeMutablePointer<IOHIDQueueInterface>?>?)!

    public var allocOutputTransaction: (@convention(c) (UnsafeMutableRawPointer?) -> UnsafeMutablePointer<UnsafeMutablePointer<IOHIDOutputTransactionInterface>?>?)!

    public var setReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutableRawPointer?, UInt32, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var getReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt32>?, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!
}

public struct IOHIDDeviceInterface121 {

    public init()

    public init(_reserved: UnsafeMutableRawPointer!, QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!, AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, createAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFRunLoopSource>?>?) -> IOReturn)!, getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?) -> Unmanaged<CFRunLoopSource>?)!, createAsyncPort: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<mach_port_t>?) -> IOReturn)!, getAsyncPort: (@convention(c) (UnsafeMutableRawPointer?) -> mach_port_t)!, open: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, close: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, setRemovalCallback: (@convention(c) (UnsafeMutableRawPointer?, IOHIDCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, getElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!, setElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?, UInt32, IOHIDElementCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, queryElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?, UInt32, IOHIDElementCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, startAllQueues: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, stopAllQueues: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, allocQueue: (@convention(c) (UnsafeMutableRawPointer?) -> UnsafeMutablePointer<UnsafeMutablePointer<IOHIDQueueInterface>?>?)!, allocOutputTransaction: (@convention(c) (UnsafeMutableRawPointer?) -> UnsafeMutablePointer<UnsafeMutablePointer<IOHIDOutputTransactionInterface>?>?)!, setReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutableRawPointer?, UInt32, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, getReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt32>?, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!)

    public var _reserved: UnsafeMutableRawPointer!

    public var QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!

    public var AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var createAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFRunLoopSource>?>?) -> IOReturn)!

    public var getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?) -> Unmanaged<CFRunLoopSource>?)!

    public var createAsyncPort: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<mach_port_t>?) -> IOReturn)!

    public var getAsyncPort: (@convention(c) (UnsafeMutableRawPointer?) -> mach_port_t)!

    public var open: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var close: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var setRemovalCallback: (@convention(c) (UnsafeMutableRawPointer?, IOHIDCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var getElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!

    public var setElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?, UInt32, IOHIDElementCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var queryElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?, UInt32, IOHIDElementCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var startAllQueues: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var stopAllQueues: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var allocQueue: (@convention(c) (UnsafeMutableRawPointer?) -> UnsafeMutablePointer<UnsafeMutablePointer<IOHIDQueueInterface>?>?)!

    public var allocOutputTransaction: (@convention(c) (UnsafeMutableRawPointer?) -> UnsafeMutablePointer<UnsafeMutablePointer<IOHIDOutputTransactionInterface>?>?)!

    public var setReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutableRawPointer?, UInt32, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var getReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt32>?, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!
}

public struct IOHIDDeviceInterface122 {

    public init()

    public init(_reserved: UnsafeMutableRawPointer!, QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!, AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, createAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFRunLoopSource>?>?) -> IOReturn)!, getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?) -> Unmanaged<CFRunLoopSource>?)!, createAsyncPort: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<mach_port_t>?) -> IOReturn)!, getAsyncPort: (@convention(c) (UnsafeMutableRawPointer?) -> mach_port_t)!, open: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, close: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, setRemovalCallback: (@convention(c) (UnsafeMutableRawPointer?, IOHIDCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, getElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!, setElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?, UInt32, IOHIDElementCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, queryElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?, UInt32, IOHIDElementCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, startAllQueues: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, stopAllQueues: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, allocQueue: (@convention(c) (UnsafeMutableRawPointer?) -> UnsafeMutablePointer<UnsafeMutablePointer<IOHIDQueueInterface>?>?)!, allocOutputTransaction: (@convention(c) (UnsafeMutableRawPointer?) -> UnsafeMutablePointer<UnsafeMutablePointer<IOHIDOutputTransactionInterface>?>?)!, setReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutableRawPointer?, UInt32, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, getReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt32>?, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, copyMatchingElements: (@convention(c) (UnsafeMutableRawPointer?, CFDictionary?, UnsafeMutablePointer<Unmanaged<CFArray>?>?) -> IOReturn)!, setInterruptReportHandlerCallback: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutableRawPointer?, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!)

    public var _reserved: UnsafeMutableRawPointer!

    public var QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!

    public var AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var createAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFRunLoopSource>?>?) -> IOReturn)!

    public var getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?) -> Unmanaged<CFRunLoopSource>?)!

    public var createAsyncPort: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<mach_port_t>?) -> IOReturn)!

    public var getAsyncPort: (@convention(c) (UnsafeMutableRawPointer?) -> mach_port_t)!

    public var open: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var close: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var setRemovalCallback: (@convention(c) (UnsafeMutableRawPointer?, IOHIDCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var getElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!

    public var setElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?, UInt32, IOHIDElementCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var queryElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?, UInt32, IOHIDElementCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var startAllQueues: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var stopAllQueues: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var allocQueue: (@convention(c) (UnsafeMutableRawPointer?) -> UnsafeMutablePointer<UnsafeMutablePointer<IOHIDQueueInterface>?>?)!

    public var allocOutputTransaction: (@convention(c) (UnsafeMutableRawPointer?) -> UnsafeMutablePointer<UnsafeMutablePointer<IOHIDOutputTransactionInterface>?>?)!

    public var setReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutableRawPointer?, UInt32, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var getReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt32>?, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var copyMatchingElements: (@convention(c) (UnsafeMutableRawPointer?, CFDictionary?, UnsafeMutablePointer<Unmanaged<CFArray>?>?) -> IOReturn)!

    public var setInterruptReportHandlerCallback: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutableRawPointer?, UInt32, IOHIDReportCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!
}

public struct IOHIDQueueInterface {

    public init()

    public init(_reserved: UnsafeMutableRawPointer!, QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!, AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, createAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFRunLoopSource>?>?) -> IOReturn)!, getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?) -> Unmanaged<CFRunLoopSource>?)!, createAsyncPort: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<mach_port_t>?) -> IOReturn)!, getAsyncPort: (@convention(c) (UnsafeMutableRawPointer?) -> mach_port_t)!, create: (@convention(c) (UnsafeMutableRawPointer?, UInt32, UInt32) -> IOReturn)!, dispose: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, addElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UInt32) -> IOReturn)!, removeElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie) -> IOReturn)!, hasElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie) -> DarwinBoolean)!, start: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, stop: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, getNextEvent: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<IOHIDEventStruct>?, AbsoluteTime, UInt32) -> IOReturn)!, setEventCallout: (@convention(c) (UnsafeMutableRawPointer?, IOHIDCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, getEventCallout: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<IOHIDCallbackFunction?>?, UnsafeMutablePointer<UnsafeMutableRawPointer?>?, UnsafeMutablePointer<UnsafeMutableRawPointer?>?) -> IOReturn)!)

    public var _reserved: UnsafeMutableRawPointer!

    public var QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!

    public var AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var createAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFRunLoopSource>?>?) -> IOReturn)!

    public var getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?) -> Unmanaged<CFRunLoopSource>?)!

    public var createAsyncPort: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<mach_port_t>?) -> IOReturn)!

    public var getAsyncPort: (@convention(c) (UnsafeMutableRawPointer?) -> mach_port_t)!

    public var create: (@convention(c) (UnsafeMutableRawPointer?, UInt32, UInt32) -> IOReturn)!

    public var dispose: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var addElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UInt32) -> IOReturn)!

    public var removeElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie) -> IOReturn)!

    public var hasElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie) -> DarwinBoolean)!

    public var start: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var stop: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var getNextEvent: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<IOHIDEventStruct>?, AbsoluteTime, UInt32) -> IOReturn)!

    public var setEventCallout: (@convention(c) (UnsafeMutableRawPointer?, IOHIDCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var getEventCallout: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<IOHIDCallbackFunction?>?, UnsafeMutablePointer<UnsafeMutableRawPointer?>?, UnsafeMutablePointer<UnsafeMutableRawPointer?>?) -> IOReturn)!
}

public struct IOHIDOutputTransactionInterface {

    public init()

    public init(_reserved: UnsafeMutableRawPointer!, QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!, AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, createAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFRunLoopSource>?>?) -> IOReturn)!, getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?) -> Unmanaged<CFRunLoopSource>?)!, createAsyncPort: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<mach_port_t>?) -> IOReturn)!, getAsyncPort: (@convention(c) (UnsafeMutableRawPointer?) -> mach_port_t)!, create: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, dispose: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!, addElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie) -> IOReturn)!, removeElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie) -> IOReturn)!, hasElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie) -> DarwinBoolean)!, setElementDefault: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!, getElementDefault: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!, setElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!, getElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!, commit: (@convention(c) (UnsafeMutableRawPointer?, UInt32, IOHIDCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!, clear: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!)

    public var _reserved: UnsafeMutableRawPointer!

    public var QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!

    public var AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var createAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFRunLoopSource>?>?) -> IOReturn)!

    public var getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?) -> Unmanaged<CFRunLoopSource>?)!

    public var createAsyncPort: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<mach_port_t>?) -> IOReturn)!

    public var getAsyncPort: (@convention(c) (UnsafeMutableRawPointer?) -> mach_port_t)!

    public var create: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var dispose: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!

    public var addElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie) -> IOReturn)!

    public var removeElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie) -> IOReturn)!

    public var hasElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie) -> DarwinBoolean)!

    public var setElementDefault: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!

    public var getElementDefault: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!

    public var setElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!

    public var getElementValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElementCookie, UnsafeMutablePointer<IOHIDEventStruct>?) -> IOReturn)!

    public var commit: (@convention(c) (UnsafeMutableRawPointer?, UInt32, IOHIDCallbackFunction?, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> IOReturn)!

    public var clear: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!
}

/**
 @enum      IOHIDManagerOptions
 @abstract  Various options that can be supplied to IOHIDManager functions.
 @const     kIOHIDManagerOptionNone For those times when supplying 0 just isn't
            explicit enough.
 @const     kIOHIDManagerOptionUsePersistentProperties This constant can be
            supplied to @link IOHIDManagerCreate @/link to create and/or use a
            persistent properties store.
 @const     kIOHIDManagerOptionDoNotLoadProperties This constant can be supplied
            to @link IOHIDManagerCreate when you wish to overwrite the
            persistent properties store without loading it first.
 @const     kIOHIDManagerOptionDoNotSaveProperties This constant can be supplied
            to @link IOHIDManagerCreate @/link when you want to use the
            persistent property store but do not want to add to it.
 @const     kIOHIDManagerOptionIndependentDevices Devices maintained by the
            manager will act independently from calls to the manager.
            This allows for devices to be scheduled on separate queues, and
            their lifetime can persist after the manager is gone.
 
            The following calls will not be propagated to the devices:
            IOHIDManagerOpen, IOHIDManagerClose, IOHIDManagerScheduleWithRunLoop,
            IOHIDManagerUnscheduleFromRunLoop, IOHIDManagerSetDispatchQueue,
            IOHIDManagerSetCancelHandler, IOHIDManagerActivate, IOHIDManagerCancel,
            IOHIDManagerRegisterInputReportCallback,
            IOHIDManagerRegisterInputReportWithTimeStampCallback,
            IOHIDManagerRegisterInputValueCallback, IOHIDManagerSetInputValueMatching,
            IOHIDManagerSetInputValueMatchingMultiple,
 
            This also means that the manager will not be able to receive input
            reports or input values, since the devices may or may not be scheduled.
 */
public struct IOHIDManagerOptions : OptionSet, @unchecked Sendable {

    public init(rawValue: UInt32)

    public static var usePersistentProperties: IOHIDManagerOptions { get }

    public static var doNotLoadProperties: IOHIDManagerOptions { get }

    public static var doNotSaveProperties: IOHIDManagerOptions { get }

    public static var independentDevices: IOHIDManagerOptions { get }
}

/** @typedef IOHIDManagerRef
    @abstract This is the type of a reference to the IOHIDManager.
*/
public class IOHIDManager : Hashable {
}

/**
    @function   IOHIDManagerGetTypeID
    @abstract   Returns the type identifier of all IOHIDManager instances.
*/
@available(macOS 10.5, *)
public func IOHIDManagerGetTypeID() -> CFTypeID

/**
    @function   IOHIDManagerCreate
    @abstract   Creates an IOHIDManager object.
    @discussion The IOHIDManager object is meant as a global management system
                for communicating with HID devices.
    @param      allocator Allocator to be used during creation.
    @param      options Supply @link kIOHIDManagerOptionUsePersistentProperties @/link to load
                properties from the default persistent property store. Otherwise supply
                @link kIOHIDManagerOptionNone @/link (or 0).                
    @result     Returns a new IOHIDManagerRef.
*/
@available(macOS 10.5, *)
public func IOHIDManagerCreate(_ allocator: CFAllocator?, _ options: IOOptionBits) -> IOHIDManager

/**
    @function   IOHIDManagerOpen
    @abstract   Opens the IOHIDManager.
    @discussion This will open both current and future devices that are 
                enumerated. To establish an exclusive link use the 
                kIOHIDOptionsTypeSeizeDevice option. 
    @param      manager Reference to an IOHIDManager.
    @param      options Option bits to be sent down to the manager and device.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDManagerOpen(_ manager: IOHIDManager, _ options: IOOptionBits) -> IOReturn

/**
    @function   IOHIDManagerClose
    @abstract   Closes the IOHIDManager.
    @discussion This will also close all devices that are currently enumerated.
    @param      manager Reference to an IOHIDManager.
    @param      options Option bits to be sent down to the manager and device.
    @result     Returns kIOReturnSuccess if successful.
*/
@available(macOS 10.5, *)
public func IOHIDManagerClose(_ manager: IOHIDManager, _ options: IOOptionBits) -> IOReturn

/**
    @function   IOHIDManagerGetProperty
    @abstract   Obtains a property of an IOHIDManager.
    @discussion Property keys are prefixed by kIOHIDDevice and declared in 
                <IOKit/hid/IOHIDKeys.h>.
    @param      manager Reference to an IOHIDManager.
    @param      key CFStringRef containing key to be used when querying the 
                manager.
    @result     Returns CFTypeRef containing the property.
*/
@available(macOS 10.5, *)
public func IOHIDManagerGetProperty(_ manager: IOHIDManager, _ key: CFString) -> CFTypeRef?

/**
    @function   IOHIDManagerSetProperty
    @abstract   Sets a property for an IOHIDManager.
    @discussion Property keys are prefixed by kIOHIDDevice and kIOHIDManager and
                declared in <IOKit/hid/IOHIDKeys.h>. This method will propagate 
                any relevent properties to current and future devices that are 
                enumerated.
    @param      manager Reference to an IOHIDManager.
    @param      key CFStringRef containing key to be used when modifiying the 
                device property.
    @param      value CFTypeRef containing the property value to be set.
    @result     Returns TRUE if successful.
*/
@available(macOS 10.5, *)
public func IOHIDManagerSetProperty(_ manager: IOHIDManager, _ key: CFString, _ value: CFTypeRef) -> Bool

/** @function   IOHIDManagerScheduleWithRunLoop
    @abstract   Schedules HID manager with run loop.
    @discussion Formally associates manager with client's run loop. Scheduling
                this device with the run loop is necessary before making use of
                any asynchronous APIs.  This will propagate to current and 
                future devices that are enumerated.
    @param      manager Reference to an IOHIDManager.
    @param      runLoop RunLoop to be used when scheduling any asynchronous 
                activity.
    @param      runLoopMode Run loop mode to be used when scheduling any 
                asynchronous activity.
*/
@available(macOS 10.5, *)
public func IOHIDManagerScheduleWithRunLoop(_ manager: IOHIDManager, _ runLoop: CFRunLoop, _ runLoopMode: CFString)

/** @function   IOHIDManagerUnscheduleFromRunLoop
    @abstract   Unschedules HID manager with run loop.
    @discussion Formally disassociates device with client's run loop. This will 
                propagate to current devices that are enumerated.
    @param      manager Reference to an IOHIDManager.
    @param      runLoop RunLoop to be used when unscheduling any asynchronous 
                activity.
    @param      runLoopMode Run loop mode to be used when unscheduling any 
                asynchronous activity.
*/
@available(macOS 10.5, *)
public func IOHIDManagerUnscheduleFromRunLoop(_ manager: IOHIDManager, _ runLoop: CFRunLoop, _ runLoopMode: CFString)

/**
 * @function IOHIDManagerSetDispatchQueue
 *
 * @abstract
 * Sets the dispatch queue to be associated with the IOHIDManager.
 * This is necessary in order to receive asynchronous events from the kernel.
 *
 * @discussion
 * An IOHIDManager should not be associated with both a runloop and
 * dispatch queue. A call to IOHIDManagerSetDispatchQueue should only be made once.
 *
 * After a dispatch queue is set, the IOHIDManager must make a call to activate
 * via IOHIDManagerActivate and cancel via IOHIDManagerCancel. All calls to "Register"
 * functions should be done before activation and not after cancellation.
 *
 * @param manager
 * Reference to an IOHIDManager
 *
 * @param queue
 * The dispatch queue to which the event handler block will be submitted.
 */
@available(macOS 10.15, *)
public func IOHIDManagerSetDispatchQueue(_ manager: IOHIDManager, _ queue: dispatch_queue_t)

/**
 * @function IOHIDManagerSetCancelHandler
 *
 * @abstract
 * Sets a cancellation handler for the dispatch queue associated with
 * IOHIDManagerSetDispatchQueue.
 *
 * @discussion
 * The cancellation handler (if specified) will be will be submitted to the
 * manager's dispatch queue in response to a call to IOHIDManagerCancel after
 * all the events have been handled.
 *
 * IOHIDManagerSetCancelHandler should not be used when scheduling with
 * a run loop.
 *
 * The IOHIDManagerRef should only be released after the manager has been
 * cancelled, and the cancel handler has been called. This is to ensure all
 * asynchronous objects are released. For example:
 *
 *     dispatch_block_t cancelHandler = dispatch_block_create(0, ^{
 *         CFRelease(manager);
 *     });
 *     IOHIDManagerSetCancelHandler(manager, cancelHandler);
 *     IOHIDManagerActivate(manager);
 *     IOHIDManageCancel(manager);
 *
 * @param manager
 * Reference to an IOHIDManager.
 *
 * @param handler
 * The cancellation handler block to be associated with the dispatch queue.
 */
@available(macOS 10.15, *)
public func IOHIDManagerSetCancelHandler(_ manager: IOHIDManager, _ handler: @escaping () -> Void)

/**
 * @function IOHIDManagerActivate
 *
 * @abstract
 * Activates the IOHIDManager object.
 *
 * @discussion
 * An IOHIDManager object associated with a dispatch queue is created
 * in an inactive state. The object must be activated in order to
 * receive asynchronous events from the kernel.
 *
 * A dispatch queue must be set via IOHIDManagerSetDispatchQueue before
 * activation.
 *
 * An activated manager must be cancelled via IOHIDManagerCancel. All calls
 * to "Register" functions should be done before activation
 * and not after cancellation.
 *
 * Calling IOHIDManagerActivate on an active IOHIDManager has no effect.
 *
 * @param manager
 * Reference to an IOHIDManager
 */
@available(macOS 10.15, *)
public func IOHIDManagerActivate(_ manager: IOHIDManager)

/**
 * @function IOHIDManagerCancel
 *
 * @abstract
 * Cancels the IOHIDManager preventing any further invocation
 * of its event handler block.
 *
 * @discussion
 * Cancelling prevents any further invocation of the event handler block for
 * the specified dispatch queue, but does not interrupt an event handler
 * block that is already in progress.
 *
 * Explicit cancellation of the IOHIDManager is required, no implicit
 * cancellation takes place.
 *
 * Calling IOHIDManagerCancel on an already cancelled queue has no effect.
 *
 * The IOHIDManagerRef should only be released after the manager has been
 * cancelled, and the cancel handler has been called. This is to ensure all
 * asynchronous objects are released. For example:
 *
 *     dispatch_block_t cancelHandler = dispatch_block_create(0, ^{
 *         CFRelease(manager);
 *     });
 *     IOHIDManagerSetCancelHandler(manager, cancelHandler);
 *     IOHIDManagerActivate(manager);
 *     IOHIDManageCancel(manager);
 *
 * @param manager
 * Reference to an IOHIDManager
 */
@available(macOS 10.15, *)
public func IOHIDManagerCancel(_ manager: IOHIDManager)

/** @function   IOHIDManagerSetDeviceMatching
    @abstract   Sets matching criteria for device enumeration.
    @discussion Matching keys are prefixed by kIOHIDDevice and declared in 
                <IOKit/hid/IOHIDKeys.h>.  Passing a NULL dictionary will result
                in all devices being enumerated. Any subsequent calls will cause
                the hid manager to release previously enumerated devices and 
                restart the enuerate process using the revised criteria.  If 
                interested in multiple, specific device classes, please defer to
                using IOHIDManagerSetDeviceMatchingMultiple.
                If a dispatch queue is set, this call must occur before activation.
    @param      manager Reference to an IOHIDManager.
    @param      matching CFDictionaryRef containg device matching criteria.
*/
@available(macOS 10.5, *)
public func IOHIDManagerSetDeviceMatching(_ manager: IOHIDManager, _ matching: CFDictionary?)

/** @function   IOHIDManagerSetDeviceMatchingMultiple
    @abstract   Sets multiple matching criteria for device enumeration.
    @discussion Matching keys are prefixed by kIOHIDDevice and declared in 
                <IOKit/hid/IOHIDKeys.h>.  This method is useful if interested 
                in multiple, specific device classes.
                If a dispatch queue is set, this call must occur before activation.
    @param      manager Reference to an IOHIDManager.
    @param      multiple CFArrayRef containing multiple CFDictionaryRef objects
                containg device matching criteria.
*/
@available(macOS 10.5, *)
public func IOHIDManagerSetDeviceMatchingMultiple(_ manager: IOHIDManager, _ multiple: CFArray?)

/** @function   IOHIDManagerCopyDevices
    @abstract   Obtains currently enumerated devices.
    @param      manager Reference to an IOHIDManager.
    @result     CFSetRef containing IOHIDDeviceRefs.
*/
@available(macOS 10.5, *)
public func IOHIDManagerCopyDevices(_ manager: IOHIDManager) -> CFSet?

/** @function   IOHIDManagerRegisterDeviceMatchingCallback
    @abstract   Registers a callback to be used a device is enumerated.
    @discussion Only device matching the set criteria will be enumerated.
                If a dispatch queue is set, this call must occur before activation.
                Devices provided in the callback will be scheduled with the same
                runloop/dispatch queue as the IOHIDManagerRef, and should not be
                rescheduled.
    @param      manager Reference to an IOHIDManagerRef.
    @param      callback Pointer to a callback method of type 
                IOHIDDeviceCallback.
    @param      context Pointer to data to be passed to the callback.
*/
@available(macOS 10.5, *)
public func IOHIDManagerRegisterDeviceMatchingCallback(_ manager: IOHIDManager, _ callback: IOHIDDeviceCallback?, _ context: UnsafeMutableRawPointer?)

/** @function   IOHIDManagerRegisterDeviceRemovalCallback
    @abstract   Registers a callback to be used when any enumerated device is 
                removed.
    @discussion In most cases this occurs when a device is unplugged.
                If a dispatch queue is set, this call must occur before activation.
    @param      manager Reference to an IOHIDManagerRef.
    @param      callback Pointer to a callback method of type 
                IOHIDDeviceCallback.
    @param      context Pointer to data to be passed to the callback.
*/
@available(macOS 10.5, *)
public func IOHIDManagerRegisterDeviceRemovalCallback(_ manager: IOHIDManager, _ callback: IOHIDDeviceCallback?, _ context: UnsafeMutableRawPointer?)

/** @function   IOHIDManagerRegisterInputReportCallback
    @abstract   Registers a callback to be used when an input report is issued by 
                any enumerated device.
    @discussion An input report is an interrupt driver report issued by a device.
                If a dispatch queue is set, this call must occur before activation.
    @param      manager Reference to an IOHIDManagerRef.
    @param      callback Pointer to a callback method of type IOHIDReportCallback.
    @param      context Pointer to data to be passed to the callback.
*/
@available(macOS 10.5, *)
public func IOHIDManagerRegisterInputReportCallback(_ manager: IOHIDManager, _ callback: IOHIDReportCallback?, _ context: UnsafeMutableRawPointer?)

/** @function   IOHIDManagerRegisterInputReportWithTimeStampCallback
    @abstract   Registers a callback to be used when an input report is issued by
                any enumerated device.
    @discussion An input report is an interrupt driver report issued by a device.
                If a dispatch queue is set, this call must occur before activation.
    @param      manager Reference to an IOHIDManagerRef.
    @param      callback Pointer to a callback method of type
                IOHIDReportWithTimeStampCallback.
    @param      context Pointer to data to be passed to the callback.
 */
@available(macOS 10.15, *)
public func IOHIDManagerRegisterInputReportWithTimeStampCallback(_ manager: IOHIDManager, _ callback: IOHIDReportWithTimeStampCallback, _ context: UnsafeMutableRawPointer?)

/** @function   IOHIDManagerRegisterInputValueCallback
    @abstract   Registers a callback to be used when an input value is issued by 
                any enumerated device.
    @discussion An input element refers to any element of type 
                kIOHIDElementTypeInput and is usually issued by interrupt driven
                reports.
                If a dispatch queue is set, this call must occur before activation.
    @param      manager Reference to an IOHIDManagerRef.
    @param      callback Pointer to a callback method of type IOHIDValueCallback.
    @param      context Pointer to data to be passed to the callback.
*/
@available(macOS 10.5, *)
public func IOHIDManagerRegisterInputValueCallback(_ manager: IOHIDManager, _ callback: IOHIDValueCallback?, _ context: UnsafeMutableRawPointer?)

/** @function   IOHIDManagerSetInputValueMatching
    @abstract   Sets matching criteria for input values received via 
                IOHIDManagerRegisterInputValueCallback.
    @discussion Matching keys are prefixed by kIOHIDElement and declared in 
                <IOKit/hid/IOHIDKeys.h>.  Passing a NULL dictionary will result
                in all devices being enumerated. Any subsequent calls will cause
                the hid manager to release previously matched input elements and 
                restart the matching process using the revised criteria.  If 
                interested in multiple, specific device elements, please defer to
                using IOHIDManagerSetInputValueMatchingMultiple.
                If a dispatch queue is set, this call must occur before activation.
    @param      manager Reference to an IOHIDManager.
    @param      matching CFDictionaryRef containg device matching criteria.
*/
@available(macOS 10.5, *)
public func IOHIDManagerSetInputValueMatching(_ manager: IOHIDManager, _ matching: CFDictionary?)

/** @function   IOHIDManagerSetInputValueMatchingMultiple
    @abstract   Sets multiple matching criteria for input values received via 
                IOHIDManagerRegisterInputValueCallback.
    @discussion Matching keys are prefixed by kIOHIDElement and declared in 
                <IOKit/hid/IOHIDKeys.h>.  This method is useful if interested 
                in multiple, specific elements.
                If a dispatch queue is set, this call must occur before activation.
    @param      manager Reference to an IOHIDManager.
    @param      multiple CFArrayRef containing multiple CFDictionaryRef objects
                containing input element matching criteria.
*/
@available(macOS 10.5, *)
public func IOHIDManagerSetInputValueMatchingMultiple(_ manager: IOHIDManager, _ multiple: CFArray?)

/**
 @abstract   Used to write out the current properties to a specific domain.
 @discussion Using this function will cause the persistent properties to be saved out
 replacing any properties that already existed in the specified domain. All arguments 
 must be non-NULL except options.
 @param     manager Reference to an IOHIDManager.
 @param     applicationID Reference to a CFPreferences applicationID.
 @param     userName Reference to a CFPreferences userName.
 @param     hostName Reference to a CFPreferences hostName.
 @param     options Reserved for future use.
 */
@available(macOS 10.6, *)
public func IOHIDManagerSaveToPropertyDomain(_ manager: IOHIDManager, _ applicationID: CFString, _ userName: CFString, _ hostName: CFString, _ options: IOOptionBits)

public var kHIDPage_Undefined: Int { get }

public var kHIDPage_GenericDesktop: Int { get }

public var kHIDPage_Simulation: Int { get }

public var kHIDPage_VR: Int { get }

public var kHIDPage_Sport: Int { get }

public var kHIDPage_Game: Int { get }

public var kHIDPage_GenericDeviceControls: Int { get }

public var kHIDPage_KeyboardOrKeypad: Int { get }

public var kHIDPage_LEDs: Int { get }

public var kHIDPage_Button: Int { get }

public var kHIDPage_Ordinal: Int { get }

public var kHIDPage_Telephony: Int { get }

public var kHIDPage_Consumer: Int { get }

public var kHIDPage_Digitizer: Int { get }

public var kHIDPage_Haptics: Int { get }

public var kHIDPage_PID: Int { get }

public var kHIDPage_Unicode: Int { get }

public var kHIDPage_AlphanumericDisplay: Int { get }

public var kHIDPage_Sensor: Int { get }

public var kHIDPage_BrailleDisplay: Int { get }

public var kHIDPage_Monitor: Int { get }

public var kHIDPage_MonitorEnumerated: Int { get }

public var kHIDPage_MonitorVirtual: Int { get }

public var kHIDPage_MonitorReserved: Int { get }

public var kHIDPage_PowerDevice: Int { get }

public var kHIDPage_BatterySystem: Int { get }

public var kHIDPage_PowerReserved: Int { get }

public var kHIDPage_PowerReserved2: Int { get }

public var kHIDPage_BarCodeScanner: Int { get }

public var kHIDPage_WeighingDevice: Int { get }

public var kHIDPage_Scale: Int { get }

public var kHIDPage_MagneticStripeReader: Int { get }

public var kHIDPage_CameraControl: Int { get }

public var kHIDPage_Arcade: Int { get }

public var kHIDPage_FIDO: Int { get }

public var kHIDPage_VendorDefinedStart: Int { get }

public var kHIDUsage_Undefined: Int { get }

public var kHIDUsage_GD_Pointer: Int { get }

public var kHIDUsage_GD_Mouse: Int { get }

public var kHIDUsage_GD_Joystick: Int { get }

public var kHIDUsage_GD_GamePad: Int { get }

public var kHIDUsage_GD_Keyboard: Int { get }

public var kHIDUsage_GD_Keypad: Int { get }

public var kHIDUsage_GD_MultiAxisController: Int { get }

public var kHIDUsage_GD_TabletPCSystemControls: Int { get }

public var kHIDUsage_GD_AssistiveControl: Int { get }

public var kHIDUsage_GD_SystemMultiAxisController: Int { get }

public var kHIDUsage_GD_SpatialController: Int { get }

public var kHIDUsage_GD_AssistiveControlCompatible: Int { get }

public var kHIDUsage_GD_X: Int { get }

public var kHIDUsage_GD_Y: Int { get }

public var kHIDUsage_GD_Z: Int { get }

public var kHIDUsage_GD_Rx: Int { get }

public var kHIDUsage_GD_Ry: Int { get }

public var kHIDUsage_GD_Rz: Int { get }

public var kHIDUsage_GD_Slider: Int { get }

public var kHIDUsage_GD_Dial: Int { get }

public var kHIDUsage_GD_Wheel: Int { get }

public var kHIDUsage_GD_Hatswitch: Int { get }

public var kHIDUsage_GD_CountedBuffer: Int { get }

public var kHIDUsage_GD_ByteCount: Int { get }

public var kHIDUsage_GD_MotionWakeup: Int { get }

public var kHIDUsage_GD_Start: Int { get }

public var kHIDUsage_GD_Select: Int { get }

public var kHIDUsage_GD_Vx: Int { get }

public var kHIDUsage_GD_Vy: Int { get }

public var kHIDUsage_GD_Vz: Int { get }

public var kHIDUsage_GD_Vbrx: Int { get }

public var kHIDUsage_GD_Vbry: Int { get }

public var kHIDUsage_GD_Vbrz: Int { get }

public var kHIDUsage_GD_Vno: Int { get }

public var kHIDUsage_GD_FeatureNotification: Int { get }

public var kHIDUsage_GD_ResolutionMultiplier: Int { get }

public var kHIDUsage_GD_Qx: Int { get }

public var kHIDUsage_GD_Qy: Int { get }

public var kHIDUsage_GD_Qz: Int { get }

public var kHIDUsage_GD_Qw: Int { get }

public var kHIDUsage_GD_SystemControl: Int { get }

public var kHIDUsage_GD_SystemPowerDown: Int { get }

public var kHIDUsage_GD_SystemSleep: Int { get }

public var kHIDUsage_GD_SystemWakeUp: Int { get }

public var kHIDUsage_GD_SystemContextMenu: Int { get }

public var kHIDUsage_GD_SystemMainMenu: Int { get }

public var kHIDUsage_GD_SystemAppMenu: Int { get }

public var kHIDUsage_GD_SystemMenuHelp: Int { get }

public var kHIDUsage_GD_SystemMenuExit: Int { get }

public var kHIDUsage_GD_SystemMenuSelect: Int { get }

public var kHIDUsage_GD_SystemMenu: Int { get }

public var kHIDUsage_GD_SystemMenuRight: Int { get }

public var kHIDUsage_GD_SystemMenuLeft: Int { get }

public var kHIDUsage_GD_SystemMenuUp: Int { get }

public var kHIDUsage_GD_SystemMenuDown: Int { get }

public var kHIDUsage_GD_SystemColdRestart: Int { get }

public var kHIDUsage_GD_SystemWarmRestart: Int { get }

public var kHIDUsage_GD_DPadUp: Int { get }

public var kHIDUsage_GD_DPadDown: Int { get }

public var kHIDUsage_GD_DPadRight: Int { get }

public var kHIDUsage_GD_DPadLeft: Int { get }

public var kHIDUsage_GD_IndexTrigger: Int { get }

public var kHIDUsage_GD_PalmTrigger: Int { get }

public var kHIDUsage_GD_Thumbstick: Int { get }

public var kHIDUsage_GD_SFShift: Int { get }

public var kHIDUsage_GD_SFShiftLock: Int { get }

public var kHIDUsage_GD_SFShiftLockIndicator: Int { get }

public var kHIDUsage_GD_SystemDismissNotification: Int { get }

public var kHIDUsage_GD_DoNotDisturb: Int { get }

public var kHIDUsage_GD_SystemDock: Int { get }

public var kHIDUsage_GD_SystemUndock: Int { get }

public var kHIDUsage_GD_SystemSetup: Int { get }

public var kHIDUsage_GD_SystemBreak: Int { get }

public var kHIDUsage_GD_SystemDebuggerBreak: Int { get }

public var kHIDUsage_GD_ApplicationBreak: Int { get }

public var kHIDUsage_GD_ApplicationDebuggerBreak: Int { get }

public var kHIDUsage_GD_SystemSpeakerMute: Int { get }

public var kHIDUsage_GD_SystemHibernate: Int { get }

public var kHIDUsage_GD_SystemMicrophoneMute: Int { get }

public var kHIDUsage_GD_SystemDisplayInvert: Int { get }

public var kHIDUsage_GD_SystemDisplayInternal: Int { get }

public var kHIDUsage_GD_SystemDisplayExternal: Int { get }

public var kHIDUsage_GD_SystemDisplayBoth: Int { get }

public var kHIDUsage_GD_SystemDisplayDual: Int { get }

public var kHIDUsage_GD_SystemDisplayToggleMode: Int { get }

public var kHIDUsage_GD_SystemDisplaySwap: Int { get }

public var kHIDUsage_GD_SystemDisplayToggleLCDAutoscale: Int { get }

public var kHIDUsage_GD_SensorZone: Int { get }

public var kHIDUsage_GD_RPM: Int { get }

public var kHIDUsage_GD_CoolantLevel: Int { get }

public var kHIDUsage_GD_CoolantCriticalLevel: Int { get }

public var kHIDUsage_GD_CoolantPump: Int { get }

public var kHIDUsage_GD_ChassisEnclosure: Int { get }

public var kHIDUsage_GD_WirelessRadioButton: Int { get }

public var kHIDUsage_GD_WirelessRadioLED: Int { get }

public var kHIDUsage_GD_WirelessRadioSliderSwitch: Int { get }

public var kHIDUsage_GD_SystemDisplayRotationLockButton: Int { get }

public var kHIDUsage_GD_SystemDisplayRotationLockSliderSwitch: Int { get }

public var kHIDUsage_GD_ControlEnable: Int { get }

public var kHIDUsage_GD_DockableDeviceUniqueID: Int { get }

public var kHIDUsage_GD_DockableDeviceVendorID: Int { get }

public var kHIDUsage_GD_DockableDevicePrimaryUsagePage: Int { get }

public var kHIDUsage_GD_DockableDevicePrimaryUsageID: Int { get }

public var kHIDUsage_GD_DockableDeviceDockingState: Int { get }

public var kHIDUsage_GD_DockableDeviceDisplayOcclusion: Int { get }

public var kHIDUsage_GD_DockableDeviceObjectType: Int { get }

public var kHIDUsage_GD_CallActiveLED: Int { get }

public var kHIDUsage_GD_CallMuteToggle: Int { get }

public var kHIDUsage_GD_CallMuteLED: Int { get }

public var kHIDUsage_GD_Reserved: Int { get }

public var kHIDUsage_Sim_FlightSimulationDevice: Int { get }

public var kHIDUsage_Sim_AutomobileSimulationDevice: Int { get }

public var kHIDUsage_Sim_TankSimulationDevice: Int { get }

public var kHIDUsage_Sim_SpaceshipSimulationDevice: Int { get }

public var kHIDUsage_Sim_SubmarineSimulationDevice: Int { get }

public var kHIDUsage_Sim_SailingSimulationDevice: Int { get }

public var kHIDUsage_Sim_MotorcycleSimulationDevice: Int { get }

public var kHIDUsage_Sim_SportsSimulationDevice: Int { get }

public var kHIDUsage_Sim_AirplaneSimulationDevice: Int { get }

public var kHIDUsage_Sim_HelicopterSimulationDevice: Int { get }

public var kHIDUsage_Sim_MagicCarpetSimulationDevice: Int { get }

public var kHIDUsage_Sim_BicycleSimulationDevice: Int { get }

public var kHIDUsage_Sim_FlightControlStick: Int { get }

public var kHIDUsage_Sim_FlightStick: Int { get }

public var kHIDUsage_Sim_CyclicControl: Int { get }

public var kHIDUsage_Sim_CyclicTrim: Int { get }

public var kHIDUsage_Sim_FlightYoke: Int { get }

public var kHIDUsage_Sim_TrackControl: Int { get }

public var kHIDUsage_Sim_Aileron: Int { get }

public var kHIDUsage_Sim_AileronTrim: Int { get }

public var kHIDUsage_Sim_AntiTorqueControl: Int { get }

public var kHIDUsage_Sim_AutopilotEnable: Int { get }

public var kHIDUsage_Sim_ChaffRelease: Int { get }

public var kHIDUsage_Sim_CollectiveControl: Int { get }

public var kHIDUsage_Sim_DiveBrake: Int { get }

public var kHIDUsage_Sim_ElectronicCountermeasures: Int { get }

public var kHIDUsage_Sim_Elevator: Int { get }

public var kHIDUsage_Sim_ElevatorTrim: Int { get }

public var kHIDUsage_Sim_Rudder: Int { get }

public var kHIDUsage_Sim_Throttle: Int { get }

public var kHIDUsage_Sim_FlightCommunications: Int { get }

public var kHIDUsage_Sim_FlareRelease: Int { get }

public var kHIDUsage_Sim_LandingGear: Int { get }

public var kHIDUsage_Sim_ToeBrake: Int { get }

public var kHIDUsage_Sim_Trigger: Int { get }

public var kHIDUsage_Sim_WeaponsArm: Int { get }

public var kHIDUsage_Sim_Weapons: Int { get }

public var kHIDUsage_Sim_WingFlaps: Int { get }

public var kHIDUsage_Sim_Accelerator: Int { get }

public var kHIDUsage_Sim_Brake: Int { get }

public var kHIDUsage_Sim_Clutch: Int { get }

public var kHIDUsage_Sim_Shifter: Int { get }

public var kHIDUsage_Sim_Steering: Int { get }

public var kHIDUsage_Sim_TurretDirection: Int { get }

public var kHIDUsage_Sim_BarrelElevation: Int { get }

public var kHIDUsage_Sim_DivePlane: Int { get }

public var kHIDUsage_Sim_Ballast: Int { get }

public var kHIDUsage_Sim_BicycleCrank: Int { get }

public var kHIDUsage_Sim_HandleBars: Int { get }

public var kHIDUsage_Sim_FrontBrake: Int { get }

public var kHIDUsage_Sim_RearBrake: Int { get }

public var kHIDUsage_Sim_Reserved: Int { get }

public var kHIDUsage_VR_Belt: Int { get }

public var kHIDUsage_VR_BodySuit: Int { get }

public var kHIDUsage_VR_Flexor: Int { get }

public var kHIDUsage_VR_Glove: Int { get }

public var kHIDUsage_VR_HeadTracker: Int { get }

public var kHIDUsage_VR_HeadMountedDisplay: Int { get }

public var kHIDUsage_VR_HandTracker: Int { get }

public var kHIDUsage_VR_Oculometer: Int { get }

public var kHIDUsage_VR_Vest: Int { get }

public var kHIDUsage_VR_AnimatronicDevice: Int { get }

public var kHIDUsage_VR_StereoEnable: Int { get }

public var kHIDUsage_VR_DisplayEnable: Int { get }

public var kHIDUsage_VR_Reserved: Int { get }

public var kHIDUsage_Sprt_BaseballBat: Int { get }

public var kHIDUsage_Sprt_GolfClub: Int { get }

public var kHIDUsage_Sprt_RowingMachine: Int { get }

public var kHIDUsage_Sprt_Treadmill: Int { get }

public var kHIDUsage_Sprt_Oar: Int { get }

public var kHIDUsage_Sprt_Slope: Int { get }

public var kHIDUsage_Sprt_Rate: Int { get }

public var kHIDUsage_Sprt_StickSpeed: Int { get }

public var kHIDUsage_Sprt_StickFaceAngle: Int { get }

public var kHIDUsage_Sprt_StickHeelOrToe: Int { get }

public var kHIDUsage_Sprt_StickFollowThrough: Int { get }

public var kHIDUsage_Sprt_StickTempo: Int { get }

public var kHIDUsage_Sprt_StickType: Int { get }

public var kHIDUsage_Sprt_StickHeight: Int { get }

public var kHIDUsage_Sprt_Putter: Int { get }

public var kHIDUsage_Sprt_1Iron: Int { get }

public var kHIDUsage_Sprt_2Iron: Int { get }

public var kHIDUsage_Sprt_3Iron: Int { get }

public var kHIDUsage_Sprt_4Iron: Int { get }

public var kHIDUsage_Sprt_5Iron: Int { get }

public var kHIDUsage_Sprt_6Iron: Int { get }

public var kHIDUsage_Sprt_7Iron: Int { get }

public var kHIDUsage_Sprt_8Iron: Int { get }

public var kHIDUsage_Sprt_9Iron: Int { get }

public var kHIDUsage_Sprt_10Iron: Int { get }

public var kHIDUsage_Sprt_11Iron: Int { get }

public var kHIDUsage_Sprt_SandWedge: Int { get }

public var kHIDUsage_Sprt_LoftWedge: Int { get }

public var kHIDUsage_Sprt_PowerWedge: Int { get }

public var kHIDUsage_Sprt_1Wood: Int { get }

public var kHIDUsage_Sprt_3Wood: Int { get }

public var kHIDUsage_Sprt_5Wood: Int { get }

public var kHIDUsage_Sprt_7Wood: Int { get }

public var kHIDUsage_Sprt_9Wood: Int { get }

public var kHIDUsage_Sprt_Reserved: Int { get }

public var kHIDUsage_Game_3DGameController: Int { get }

public var kHIDUsage_Game_PinballDevice: Int { get }

public var kHIDUsage_Game_GunDevice: Int { get }

public var kHIDUsage_Game_PointofView: Int { get }

public var kHIDUsage_Game_TurnRightOrLeft: Int { get }

public var kHIDUsage_Game_PitchUpOrDown: Int { get }

public var kHIDUsage_Game_RollRightOrLeft: Int { get }

public var kHIDUsage_Game_MoveRightOrLeft: Int { get }

public var kHIDUsage_Game_MoveForwardOrBackward: Int { get }

public var kHIDUsage_Game_MoveUpOrDown: Int { get }

public var kHIDUsage_Game_LeanRightOrLeft: Int { get }

public var kHIDUsage_Game_LeanForwardOrBackward: Int { get }

public var kHIDUsage_Game_HeightOfPOV: Int { get }

public var kHIDUsage_Game_Flipper: Int { get }

public var kHIDUsage_Game_SecondaryFlipper: Int { get }

public var kHIDUsage_Game_Bump: Int { get }

public var kHIDUsage_Game_NewGame: Int { get }

public var kHIDUsage_Game_ShootBall: Int { get }

public var kHIDUsage_Game_Player: Int { get }

public var kHIDUsage_Game_GunBolt: Int { get }

public var kHIDUsage_Game_GunClip: Int { get }

public var kHIDUsage_Game_Gun: Int { get }

public var kHIDUsage_Game_GunSingleShot: Int { get }

public var kHIDUsage_Game_GunBurst: Int { get }

public var kHIDUsage_Game_GunAutomatic: Int { get }

public var kHIDUsage_Game_GunSafety: Int { get }

public var kHIDUsage_Game_GamepadFireOrJump: Int { get }

public var kHIDUsage_Game_GamepadTrigger: Int { get }

public var kHIDUsage_Game_GamepadFormFitting_Compatibility: Int { get }

public var kHIDUsage_Game_GamepadFormFitting: Int { get }

public var kHIDUsage_Game_Reserved: Int { get }

public var kHIDUsage_GenDevControls_BackgroundControls: Int { get }

public var kHIDUsage_GenDevControls_BatteryStrength: Int { get }

public var kHIDUsage_KeyboardErrorRollOver: Int { get }

public var kHIDUsage_KeyboardPOSTFail: Int { get }

public var kHIDUsage_KeyboardErrorUndefined: Int { get }

public var kHIDUsage_KeyboardA: Int { get }

public var kHIDUsage_KeyboardB: Int { get }

public var kHIDUsage_KeyboardC: Int { get }

public var kHIDUsage_KeyboardD: Int { get }

public var kHIDUsage_KeyboardE: Int { get }

public var kHIDUsage_KeyboardF: Int { get }

public var kHIDUsage_KeyboardG: Int { get }

public var kHIDUsage_KeyboardH: Int { get }

public var kHIDUsage_KeyboardI: Int { get }

public var kHIDUsage_KeyboardJ: Int { get }

public var kHIDUsage_KeyboardK: Int { get }

public var kHIDUsage_KeyboardL: Int { get }

public var kHIDUsage_KeyboardM: Int { get }

public var kHIDUsage_KeyboardN: Int { get }

public var kHIDUsage_KeyboardO: Int { get }

public var kHIDUsage_KeyboardP: Int { get }

public var kHIDUsage_KeyboardQ: Int { get }

public var kHIDUsage_KeyboardR: Int { get }

public var kHIDUsage_KeyboardS: Int { get }

public var kHIDUsage_KeyboardT: Int { get }

public var kHIDUsage_KeyboardU: Int { get }

public var kHIDUsage_KeyboardV: Int { get }

public var kHIDUsage_KeyboardW: Int { get }

public var kHIDUsage_KeyboardX: Int { get }

public var kHIDUsage_KeyboardY: Int { get }

public var kHIDUsage_KeyboardZ: Int { get }

public var kHIDUsage_Keyboard1: Int { get }

public var kHIDUsage_Keyboard2: Int { get }

public var kHIDUsage_Keyboard3: Int { get }

public var kHIDUsage_Keyboard4: Int { get }

public var kHIDUsage_Keyboard5: Int { get }

public var kHIDUsage_Keyboard6: Int { get }

public var kHIDUsage_Keyboard7: Int { get }

public var kHIDUsage_Keyboard8: Int { get }

public var kHIDUsage_Keyboard9: Int { get }

public var kHIDUsage_Keyboard0: Int { get }

public var kHIDUsage_KeyboardReturnOrEnter: Int { get }

public var kHIDUsage_KeyboardEscape: Int { get }

public var kHIDUsage_KeyboardDeleteOrBackspace: Int { get }

public var kHIDUsage_KeyboardTab: Int { get }

public var kHIDUsage_KeyboardSpacebar: Int { get }

public var kHIDUsage_KeyboardHyphen: Int { get }

public var kHIDUsage_KeyboardEqualSign: Int { get }

public var kHIDUsage_KeyboardOpenBracket: Int { get }

public var kHIDUsage_KeyboardCloseBracket: Int { get }

public var kHIDUsage_KeyboardBackslash: Int { get }

public var kHIDUsage_KeyboardNonUSPound: Int { get }

public var kHIDUsage_KeyboardSemicolon: Int { get }

public var kHIDUsage_KeyboardQuote: Int { get }

public var kHIDUsage_KeyboardGraveAccentAndTilde: Int { get }

public var kHIDUsage_KeyboardComma: Int { get }

public var kHIDUsage_KeyboardPeriod: Int { get }

public var kHIDUsage_KeyboardSlash: Int { get }

public var kHIDUsage_KeyboardCapsLock: Int { get }

public var kHIDUsage_KeyboardF1: Int { get }

public var kHIDUsage_KeyboardF2: Int { get }

public var kHIDUsage_KeyboardF3: Int { get }

public var kHIDUsage_KeyboardF4: Int { get }

public var kHIDUsage_KeyboardF5: Int { get }

public var kHIDUsage_KeyboardF6: Int { get }

public var kHIDUsage_KeyboardF7: Int { get }

public var kHIDUsage_KeyboardF8: Int { get }

public var kHIDUsage_KeyboardF9: Int { get }

public var kHIDUsage_KeyboardF10: Int { get }

public var kHIDUsage_KeyboardF11: Int { get }

public var kHIDUsage_KeyboardF12: Int { get }

public var kHIDUsage_KeyboardPrintScreen: Int { get }

public var kHIDUsage_KeyboardScrollLock: Int { get }

public var kHIDUsage_KeyboardPause: Int { get }

public var kHIDUsage_KeyboardInsert: Int { get }

public var kHIDUsage_KeyboardHome: Int { get }

public var kHIDUsage_KeyboardPageUp: Int { get }

public var kHIDUsage_KeyboardDeleteForward: Int { get }

public var kHIDUsage_KeyboardEnd: Int { get }

public var kHIDUsage_KeyboardPageDown: Int { get }

public var kHIDUsage_KeyboardRightArrow: Int { get }

public var kHIDUsage_KeyboardLeftArrow: Int { get }

public var kHIDUsage_KeyboardDownArrow: Int { get }

public var kHIDUsage_KeyboardUpArrow: Int { get }

public var kHIDUsage_KeypadNumLock: Int { get }

public var kHIDUsage_KeypadSlash: Int { get }

public var kHIDUsage_KeypadAsterisk: Int { get }

public var kHIDUsage_KeypadHyphen: Int { get }

public var kHIDUsage_KeypadPlus: Int { get }

public var kHIDUsage_KeypadEnter: Int { get }

public var kHIDUsage_Keypad1: Int { get }

public var kHIDUsage_Keypad2: Int { get }

public var kHIDUsage_Keypad3: Int { get }

public var kHIDUsage_Keypad4: Int { get }

public var kHIDUsage_Keypad5: Int { get }

public var kHIDUsage_Keypad6: Int { get }

public var kHIDUsage_Keypad7: Int { get }

public var kHIDUsage_Keypad8: Int { get }

public var kHIDUsage_Keypad9: Int { get }

public var kHIDUsage_Keypad0: Int { get }

public var kHIDUsage_KeypadPeriod: Int { get }

public var kHIDUsage_KeyboardNonUSBackslash: Int { get }

public var kHIDUsage_KeyboardApplication: Int { get }

public var kHIDUsage_KeyboardPower: Int { get }

public var kHIDUsage_KeypadEqualSign: Int { get }

public var kHIDUsage_KeyboardF13: Int { get }

public var kHIDUsage_KeyboardF14: Int { get }

public var kHIDUsage_KeyboardF15: Int { get }

public var kHIDUsage_KeyboardF16: Int { get }

public var kHIDUsage_KeyboardF17: Int { get }

public var kHIDUsage_KeyboardF18: Int { get }

public var kHIDUsage_KeyboardF19: Int { get }

public var kHIDUsage_KeyboardF20: Int { get }

public var kHIDUsage_KeyboardF21: Int { get }

public var kHIDUsage_KeyboardF22: Int { get }

public var kHIDUsage_KeyboardF23: Int { get }

public var kHIDUsage_KeyboardF24: Int { get }

public var kHIDUsage_KeyboardExecute: Int { get }

public var kHIDUsage_KeyboardHelp: Int { get }

public var kHIDUsage_KeyboardMenu: Int { get }

public var kHIDUsage_KeyboardSelect: Int { get }

public var kHIDUsage_KeyboardStop: Int { get }

public var kHIDUsage_KeyboardAgain: Int { get }

public var kHIDUsage_KeyboardUndo: Int { get }

public var kHIDUsage_KeyboardCut: Int { get }

public var kHIDUsage_KeyboardCopy: Int { get }

public var kHIDUsage_KeyboardPaste: Int { get }

public var kHIDUsage_KeyboardFind: Int { get }

public var kHIDUsage_KeyboardMute: Int { get }

public var kHIDUsage_KeyboardVolumeUp: Int { get }

public var kHIDUsage_KeyboardVolumeDown: Int { get }

public var kHIDUsage_KeyboardLockingCapsLock: Int { get }

public var kHIDUsage_KeyboardLockingNumLock: Int { get }

public var kHIDUsage_KeyboardLockingScrollLock: Int { get }

public var kHIDUsage_KeypadComma: Int { get }

public var kHIDUsage_KeypadEqualSignAS400: Int { get }

public var kHIDUsage_KeyboardInternational1: Int { get }

public var kHIDUsage_KeyboardInternational2: Int { get }

public var kHIDUsage_KeyboardInternational3: Int { get }

public var kHIDUsage_KeyboardInternational4: Int { get }

public var kHIDUsage_KeyboardInternational5: Int { get }

public var kHIDUsage_KeyboardInternational6: Int { get }

public var kHIDUsage_KeyboardInternational7: Int { get }

public var kHIDUsage_KeyboardInternational8: Int { get }

public var kHIDUsage_KeyboardInternational9: Int { get }

public var kHIDUsage_KeyboardLANG1: Int { get }

public var kHIDUsage_KeyboardLANG2: Int { get }

public var kHIDUsage_KeyboardLANG3: Int { get }

public var kHIDUsage_KeyboardLANG4: Int { get }

public var kHIDUsage_KeyboardLANG5: Int { get }

public var kHIDUsage_KeyboardLANG6: Int { get }

public var kHIDUsage_KeyboardLANG7: Int { get }

public var kHIDUsage_KeyboardLANG8: Int { get }

public var kHIDUsage_KeyboardLANG9: Int { get }

public var kHIDUsage_KeyboardAlternateErase: Int { get }

public var kHIDUsage_KeyboardSysReqOrAttention: Int { get }

public var kHIDUsage_KeyboardCancel: Int { get }

public var kHIDUsage_KeyboardClear: Int { get }

public var kHIDUsage_KeyboardPrior: Int { get }

public var kHIDUsage_KeyboardReturn: Int { get }

public var kHIDUsage_KeyboardSeparator: Int { get }

public var kHIDUsage_KeyboardOut: Int { get }

public var kHIDUsage_KeyboardOper: Int { get }

public var kHIDUsage_KeyboardClearOrAgain: Int { get }

public var kHIDUsage_KeyboardCrSelOrProps: Int { get }

public var kHIDUsage_KeyboardExSel: Int { get }

public var kHIDUsage_KeyboardLeftControl: Int { get }

public var kHIDUsage_KeyboardLeftShift: Int { get }

public var kHIDUsage_KeyboardLeftAlt: Int { get }

public var kHIDUsage_KeyboardLeftGUI: Int { get }

public var kHIDUsage_KeyboardRightControl: Int { get }

public var kHIDUsage_KeyboardRightShift: Int { get }

public var kHIDUsage_KeyboardRightAlt: Int { get }

public var kHIDUsage_KeyboardRightGUI: Int { get }

public var kHIDUsage_Keyboard_Reserved: Int { get }

public var kHIDUsage_LED_NumLock: Int { get }

public var kHIDUsage_LED_CapsLock: Int { get }

public var kHIDUsage_LED_ScrollLock: Int { get }

public var kHIDUsage_LED_Compose: Int { get }

public var kHIDUsage_LED_Kana: Int { get }

public var kHIDUsage_LED_Power: Int { get }

public var kHIDUsage_LED_Shift: Int { get }

public var kHIDUsage_LED_DoNotDisturb: Int { get }

public var kHIDUsage_LED_Mute: Int { get }

public var kHIDUsage_LED_ToneEnable: Int { get }

public var kHIDUsage_LED_HighCutFilter: Int { get }

public var kHIDUsage_LED_LowCutFilter: Int { get }

public var kHIDUsage_LED_EqualizerEnable: Int { get }

public var kHIDUsage_LED_SoundFieldOn: Int { get }

public var kHIDUsage_LED_SurroundOn: Int { get }

public var kHIDUsage_LED_Repeat: Int { get }

public var kHIDUsage_LED_Stereo: Int { get }

public var kHIDUsage_LED_SamplingRateDetect: Int { get }

public var kHIDUsage_LED_Spinning: Int { get }

public var kHIDUsage_LED_CAV: Int { get }

public var kHIDUsage_LED_CLV: Int { get }

public var kHIDUsage_LED_RecordingFormatDetect: Int { get }

public var kHIDUsage_LED_OffHook: Int { get }

public var kHIDUsage_LED_Ring: Int { get }

public var kHIDUsage_LED_MessageWaiting: Int { get }

public var kHIDUsage_LED_DataMode: Int { get }

public var kHIDUsage_LED_BatteryOperation: Int { get }

public var kHIDUsage_LED_BatteryOK: Int { get }

public var kHIDUsage_LED_BatteryLow: Int { get }

public var kHIDUsage_LED_Speaker: Int { get }

public var kHIDUsage_LED_HeadSet: Int { get }

public var kHIDUsage_LED_Hold: Int { get }

public var kHIDUsage_LED_Microphone: Int { get }

public var kHIDUsage_LED_Coverage: Int { get }

public var kHIDUsage_LED_NightMode: Int { get }

public var kHIDUsage_LED_SendCalls: Int { get }

public var kHIDUsage_LED_CallPickup: Int { get }

public var kHIDUsage_LED_Conference: Int { get }

public var kHIDUsage_LED_StandBy: Int { get }

public var kHIDUsage_LED_CameraOn: Int { get }

public var kHIDUsage_LED_CameraOff: Int { get }

public var kHIDUsage_LED_OnLine: Int { get }

public var kHIDUsage_LED_OffLine: Int { get }

public var kHIDUsage_LED_Busy: Int { get }

public var kHIDUsage_LED_Ready: Int { get }

public var kHIDUsage_LED_PaperOut: Int { get }

public var kHIDUsage_LED_PaperJam: Int { get }

public var kHIDUsage_LED_Remote: Int { get }

public var kHIDUsage_LED_Forward: Int { get }

public var kHIDUsage_LED_Reverse: Int { get }

public var kHIDUsage_LED_Stop: Int { get }

public var kHIDUsage_LED_Rewind: Int { get }

public var kHIDUsage_LED_FastForward: Int { get }

public var kHIDUsage_LED_Play: Int { get }

public var kHIDUsage_LED_Pause: Int { get }

public var kHIDUsage_LED_Record: Int { get }

public var kHIDUsage_LED_Error: Int { get }

public var kHIDUsage_LED_Usage: Int { get }

public var kHIDUsage_LED_UsageInUseIndicator: Int { get }

public var kHIDUsage_LED_UsageMultiModeIndicator: Int { get }

public var kHIDUsage_LED_IndicatorOn: Int { get }

public var kHIDUsage_LED_IndicatorFlash: Int { get }

public var kHIDUsage_LED_IndicatorSlowBlink: Int { get }

public var kHIDUsage_LED_IndicatorFastBlink: Int { get }

public var kHIDUsage_LED_IndicatorOff: Int { get }

public var kHIDUsage_LED_FlashOnTime: Int { get }

public var kHIDUsage_LED_SlowBlinkOnTime: Int { get }

public var kHIDUsage_LED_SlowBlinkOffTime: Int { get }

public var kHIDUsage_LED_FastBlinkOnTime: Int { get }

public var kHIDUsage_LED_FastBlinkOffTime: Int { get }

public var kHIDUsage_LED_UsageIndicatorColor: Int { get }

public var kHIDUsage_LED_IndicatorRed: Int { get }

public var kHIDUsage_LED_IndicatorGreen: Int { get }

public var kHIDUsage_LED_IndicatorAmber: Int { get }

public var kHIDUsage_LED_GenericIndicator: Int { get }

public var kHIDUsage_LED_SystemSuspend: Int { get }

public var kHIDUsage_LED_ExternalPowerConnected: Int { get }

public var kHIDUsage_LED_IndicatorBlue: Int { get }

public var kHIDUsage_LED_IndicatorOrange: Int { get }

public var kHIDUsage_LED_GoodStatus: Int { get }

public var kHIDUsage_LED_WarningStatus: Int { get }

public var kHIDUsage_LED_RGB_LED: Int { get }

public var kHIDUsage_LED_RedLEDChannel: Int { get }

public var kHIDUsage_LED_BlueLEDChannel: Int { get }

public var kHIDUsage_LED_GreenLEDChannel: Int { get }

public var kHIDUsage_LED_LEDIntensity: Int { get }

public var kHIDUsage_LED_SystemMicrophoneMute: Int { get }

public var kHIDUsage_LED_PlayerIndicator: Int { get }

public var kHIDUsage_LED_Player1: Int { get }

public var kHIDUsage_LED_Player2: Int { get }

public var kHIDUsage_LED_Player3: Int { get }

public var kHIDUsage_LED_Player4: Int { get }

public var kHIDUsage_LED_Player5: Int { get }

public var kHIDUsage_LED_Player6: Int { get }

public var kHIDUsage_LED_Player7: Int { get }

public var kHIDUsage_LED_Player8: Int { get }

public var kHIDUsage_LED_Reserved: Int { get }

public var kHIDUsage_Button_1: Int { get }

public var kHIDUsage_Button_2: Int { get }

public var kHIDUsage_Button_3: Int { get }

public var kHIDUsage_Button_4: Int { get }

public var kHIDUsage_Button_5: Int { get }

public var kHIDUsage_Button_6: Int { get }

public var kHIDUsage_Button_7: Int { get }

public var kHIDUsage_Button_8: Int { get }

public var kHIDUsage_Button_9: Int { get }

public var kHIDUsage_Button_10: Int { get }

public var kHIDUsage_Button_11: Int { get }

public var kHIDUsage_Button_12: Int { get }

public var kHIDUsage_Button_13: Int { get }

public var kHIDUsage_Button_14: Int { get }

public var kHIDUsage_Button_15: Int { get }

public var kHIDUsage_Button_16: Int { get }

public var kHIDUsage_Button_17: Int { get }

public var kHIDUsage_Button_18: Int { get }

public var kHIDUsage_Button_19: Int { get }

public var kHIDUsage_Button_20: Int { get }

public var kHIDUsage_Button_21: Int { get }

public var kHIDUsage_Button_22: Int { get }

public var kHIDUsage_Button_23: Int { get }

public var kHIDUsage_Button_24: Int { get }

public var kHIDUsage_Button_25: Int { get }

public var kHIDUsage_Button_26: Int { get }

public var kHIDUsage_Button_27: Int { get }

public var kHIDUsage_Button_28: Int { get }

public var kHIDUsage_Button_29: Int { get }

public var kHIDUsage_Button_30: Int { get }

public var kHIDUsage_Button_31: Int { get }

public var kHIDUsage_Button_32: Int { get }

public var kHIDUsage_Button_33: Int { get }

public var kHIDUsage_Button_34: Int { get }

public var kHIDUsage_Button_35: Int { get }

public var kHIDUsage_Button_36: Int { get }

public var kHIDUsage_Button_37: Int { get }

public var kHIDUsage_Button_38: Int { get }

public var kHIDUsage_Button_39: Int { get }

public var kHIDUsage_Button_40: Int { get }

public var kHIDUsage_Button_41: Int { get }

public var kHIDUsage_Button_42: Int { get }

public var kHIDUsage_Button_43: Int { get }

public var kHIDUsage_Button_44: Int { get }

public var kHIDUsage_Button_45: Int { get }

public var kHIDUsage_Button_46: Int { get }

public var kHIDUsage_Button_47: Int { get }

public var kHIDUsage_Button_48: Int { get }

public var kHIDUsage_Button_49: Int { get }

public var kHIDUsage_Button_50: Int { get }

public var kHIDUsage_Button_51: Int { get }

public var kHIDUsage_Button_52: Int { get }

public var kHIDUsage_Button_53: Int { get }

public var kHIDUsage_Button_54: Int { get }

public var kHIDUsage_Button_55: Int { get }

public var kHIDUsage_Button_56: Int { get }

public var kHIDUsage_Button_57: Int { get }

public var kHIDUsage_Button_58: Int { get }

public var kHIDUsage_Button_59: Int { get }

public var kHIDUsage_Button_60: Int { get }

public var kHIDUsage_Button_61: Int { get }

public var kHIDUsage_Button_62: Int { get }

public var kHIDUsage_Button_63: Int { get }

public var kHIDUsage_Button_64: Int { get }

public var kHIDUsage_Button_65: Int { get }

public var kHIDUsage_Button_66: Int { get }

public var kHIDUsage_Button_67: Int { get }

public var kHIDUsage_Button_68: Int { get }

public var kHIDUsage_Button_69: Int { get }

public var kHIDUsage_Button_70: Int { get }

public var kHIDUsage_Button_71: Int { get }

public var kHIDUsage_Button_72: Int { get }

public var kHIDUsage_Button_73: Int { get }

public var kHIDUsage_Button_74: Int { get }

public var kHIDUsage_Button_75: Int { get }

public var kHIDUsage_Button_76: Int { get }

public var kHIDUsage_Button_77: Int { get }

public var kHIDUsage_Button_78: Int { get }

public var kHIDUsage_Button_79: Int { get }

public var kHIDUsage_Button_80: Int { get }

public var kHIDUsage_Button_81: Int { get }

public var kHIDUsage_Button_82: Int { get }

public var kHIDUsage_Button_83: Int { get }

public var kHIDUsage_Button_84: Int { get }

public var kHIDUsage_Button_85: Int { get }

public var kHIDUsage_Button_86: Int { get }

public var kHIDUsage_Button_87: Int { get }

public var kHIDUsage_Button_88: Int { get }

public var kHIDUsage_Button_89: Int { get }

public var kHIDUsage_Button_90: Int { get }

public var kHIDUsage_Button_91: Int { get }

public var kHIDUsage_Button_92: Int { get }

public var kHIDUsage_Button_93: Int { get }

public var kHIDUsage_Button_94: Int { get }

public var kHIDUsage_Button_95: Int { get }

public var kHIDUsage_Button_96: Int { get }

public var kHIDUsage_Button_97: Int { get }

public var kHIDUsage_Button_98: Int { get }

public var kHIDUsage_Button_99: Int { get }

public var kHIDUsage_Button_100: Int { get }

public var kHIDUsage_Button_101: Int { get }

public var kHIDUsage_Button_102: Int { get }

public var kHIDUsage_Button_103: Int { get }

public var kHIDUsage_Button_104: Int { get }

public var kHIDUsage_Button_105: Int { get }

public var kHIDUsage_Button_106: Int { get }

public var kHIDUsage_Button_107: Int { get }

public var kHIDUsage_Button_108: Int { get }

public var kHIDUsage_Button_109: Int { get }

public var kHIDUsage_Button_110: Int { get }

public var kHIDUsage_Button_111: Int { get }

public var kHIDUsage_Button_112: Int { get }

public var kHIDUsage_Button_113: Int { get }

public var kHIDUsage_Button_114: Int { get }

public var kHIDUsage_Button_115: Int { get }

public var kHIDUsage_Button_116: Int { get }

public var kHIDUsage_Button_117: Int { get }

public var kHIDUsage_Button_118: Int { get }

public var kHIDUsage_Button_119: Int { get }

public var kHIDUsage_Button_120: Int { get }

public var kHIDUsage_Button_121: Int { get }

public var kHIDUsage_Button_122: Int { get }

public var kHIDUsage_Button_123: Int { get }

public var kHIDUsage_Button_124: Int { get }

public var kHIDUsage_Button_125: Int { get }

public var kHIDUsage_Button_126: Int { get }

public var kHIDUsage_Button_127: Int { get }

public var kHIDUsage_Button_128: Int { get }

public var kHIDUsage_Button_129: Int { get }

public var kHIDUsage_Button_130: Int { get }

public var kHIDUsage_Button_131: Int { get }

public var kHIDUsage_Button_132: Int { get }

public var kHIDUsage_Button_133: Int { get }

public var kHIDUsage_Button_134: Int { get }

public var kHIDUsage_Button_135: Int { get }

public var kHIDUsage_Button_136: Int { get }

public var kHIDUsage_Button_137: Int { get }

public var kHIDUsage_Button_138: Int { get }

public var kHIDUsage_Button_139: Int { get }

public var kHIDUsage_Button_140: Int { get }

public var kHIDUsage_Button_141: Int { get }

public var kHIDUsage_Button_142: Int { get }

public var kHIDUsage_Button_143: Int { get }

public var kHIDUsage_Button_144: Int { get }

public var kHIDUsage_Button_145: Int { get }

public var kHIDUsage_Button_146: Int { get }

public var kHIDUsage_Button_147: Int { get }

public var kHIDUsage_Button_148: Int { get }

public var kHIDUsage_Button_149: Int { get }

public var kHIDUsage_Button_150: Int { get }

public var kHIDUsage_Button_151: Int { get }

public var kHIDUsage_Button_152: Int { get }

public var kHIDUsage_Button_153: Int { get }

public var kHIDUsage_Button_154: Int { get }

public var kHIDUsage_Button_155: Int { get }

public var kHIDUsage_Button_156: Int { get }

public var kHIDUsage_Button_157: Int { get }

public var kHIDUsage_Button_158: Int { get }

public var kHIDUsage_Button_159: Int { get }

public var kHIDUsage_Button_160: Int { get }

public var kHIDUsage_Button_161: Int { get }

public var kHIDUsage_Button_162: Int { get }

public var kHIDUsage_Button_163: Int { get }

public var kHIDUsage_Button_164: Int { get }

public var kHIDUsage_Button_165: Int { get }

public var kHIDUsage_Button_166: Int { get }

public var kHIDUsage_Button_167: Int { get }

public var kHIDUsage_Button_168: Int { get }

public var kHIDUsage_Button_169: Int { get }

public var kHIDUsage_Button_170: Int { get }

public var kHIDUsage_Button_171: Int { get }

public var kHIDUsage_Button_172: Int { get }

public var kHIDUsage_Button_173: Int { get }

public var kHIDUsage_Button_174: Int { get }

public var kHIDUsage_Button_175: Int { get }

public var kHIDUsage_Button_176: Int { get }

public var kHIDUsage_Button_177: Int { get }

public var kHIDUsage_Button_178: Int { get }

public var kHIDUsage_Button_179: Int { get }

public var kHIDUsage_Button_180: Int { get }

public var kHIDUsage_Button_181: Int { get }

public var kHIDUsage_Button_182: Int { get }

public var kHIDUsage_Button_183: Int { get }

public var kHIDUsage_Button_184: Int { get }

public var kHIDUsage_Button_185: Int { get }

public var kHIDUsage_Button_186: Int { get }

public var kHIDUsage_Button_187: Int { get }

public var kHIDUsage_Button_188: Int { get }

public var kHIDUsage_Button_189: Int { get }

public var kHIDUsage_Button_190: Int { get }

public var kHIDUsage_Button_191: Int { get }

public var kHIDUsage_Button_192: Int { get }

public var kHIDUsage_Button_193: Int { get }

public var kHIDUsage_Button_194: Int { get }

public var kHIDUsage_Button_195: Int { get }

public var kHIDUsage_Button_196: Int { get }

public var kHIDUsage_Button_197: Int { get }

public var kHIDUsage_Button_198: Int { get }

public var kHIDUsage_Button_199: Int { get }

public var kHIDUsage_Button_200: Int { get }

public var kHIDUsage_Button_201: Int { get }

public var kHIDUsage_Button_202: Int { get }

public var kHIDUsage_Button_203: Int { get }

public var kHIDUsage_Button_204: Int { get }

public var kHIDUsage_Button_205: Int { get }

public var kHIDUsage_Button_206: Int { get }

public var kHIDUsage_Button_207: Int { get }

public var kHIDUsage_Button_208: Int { get }

public var kHIDUsage_Button_209: Int { get }

public var kHIDUsage_Button_210: Int { get }

public var kHIDUsage_Button_211: Int { get }

public var kHIDUsage_Button_212: Int { get }

public var kHIDUsage_Button_213: Int { get }

public var kHIDUsage_Button_214: Int { get }

public var kHIDUsage_Button_215: Int { get }

public var kHIDUsage_Button_216: Int { get }

public var kHIDUsage_Button_217: Int { get }

public var kHIDUsage_Button_218: Int { get }

public var kHIDUsage_Button_219: Int { get }

public var kHIDUsage_Button_220: Int { get }

public var kHIDUsage_Button_221: Int { get }

public var kHIDUsage_Button_222: Int { get }

public var kHIDUsage_Button_223: Int { get }

public var kHIDUsage_Button_224: Int { get }

public var kHIDUsage_Button_225: Int { get }

public var kHIDUsage_Button_226: Int { get }

public var kHIDUsage_Button_227: Int { get }

public var kHIDUsage_Button_228: Int { get }

public var kHIDUsage_Button_229: Int { get }

public var kHIDUsage_Button_230: Int { get }

public var kHIDUsage_Button_231: Int { get }

public var kHIDUsage_Button_232: Int { get }

public var kHIDUsage_Button_233: Int { get }

public var kHIDUsage_Button_234: Int { get }

public var kHIDUsage_Button_235: Int { get }

public var kHIDUsage_Button_236: Int { get }

public var kHIDUsage_Button_237: Int { get }

public var kHIDUsage_Button_238: Int { get }

public var kHIDUsage_Button_239: Int { get }

public var kHIDUsage_Button_240: Int { get }

public var kHIDUsage_Button_241: Int { get }

public var kHIDUsage_Button_242: Int { get }

public var kHIDUsage_Button_243: Int { get }

public var kHIDUsage_Button_244: Int { get }

public var kHIDUsage_Button_245: Int { get }

public var kHIDUsage_Button_246: Int { get }

public var kHIDUsage_Button_247: Int { get }

public var kHIDUsage_Button_248: Int { get }

public var kHIDUsage_Button_249: Int { get }

public var kHIDUsage_Button_250: Int { get }

public var kHIDUsage_Button_251: Int { get }

public var kHIDUsage_Button_252: Int { get }

public var kHIDUsage_Button_253: Int { get }

public var kHIDUsage_Button_254: Int { get }

public var kHIDUsage_Button_255: Int { get }

public var kHIDUsage_Button_65535: Int { get }

public var kHIDUsage_Ord_Instance1: Int { get }

public var kHIDUsage_Ord_Instance2: Int { get }

public var kHIDUsage_Ord_Instance3: Int { get }

public var kHIDUsage_Ord_Instance4: Int { get }

public var kHIDUsage_Ord_Instance65535: Int { get }

public var kHIDUsage_Tfon_Phone: Int { get }

public var kHIDUsage_Tfon_AnsweringMachine: Int { get }

public var kHIDUsage_Tfon_MessageControls: Int { get }

public var kHIDUsage_Tfon_Handset: Int { get }

public var kHIDUsage_Tfon_Headset: Int { get }

public var kHIDUsage_Tfon_TelephonyKeyPad: Int { get }

public var kHIDUsage_Tfon_ProgrammableButton: Int { get }

public var kHIDUsage_Tfon_HookSwitch: Int { get }

public var kHIDUsage_Tfon_Flash: Int { get }

public var kHIDUsage_Tfon_Feature: Int { get }

public var kHIDUsage_Tfon_Hold: Int { get }

public var kHIDUsage_Tfon_Redial: Int { get }

public var kHIDUsage_Tfon_Transfer: Int { get }

public var kHIDUsage_Tfon_Drop: Int { get }

public var kHIDUsage_Tfon_Park: Int { get }

public var kHIDUsage_Tfon_ForwardCalls: Int { get }

public var kHIDUsage_Tfon_AlternateFunction: Int { get }

public var kHIDUsage_Tfon_Line: Int { get }

public var kHIDUsage_Tfon_SpeakerPhone: Int { get }

public var kHIDUsage_Tfon_Conference: Int { get }

public var kHIDUsage_Tfon_RingEnable: Int { get }

public var kHIDUsage_Tfon_Ring: Int { get }

public var kHIDUsage_Tfon_PhoneMute: Int { get }

public var kHIDUsage_Tfon_CallerID: Int { get }

public var kHIDUsage_Tfon_SpeedDial: Int { get }

public var kHIDUsage_Tfon_StoreNumber: Int { get }

public var kHIDUsage_Tfon_RecallNumber: Int { get }

public var kHIDUsage_Tfon_PhoneDirectory: Int { get }

public var kHIDUsage_Tfon_VoiceMail: Int { get }

public var kHIDUsage_Tfon_ScreenCalls: Int { get }

public var kHIDUsage_Tfon_DoNotDisturb: Int { get }

public var kHIDUsage_Tfon_Message: Int { get }

public var kHIDUsage_Tfon_AnswerOnOrOff: Int { get }

public var kHIDUsage_Tfon_InsideDialTone: Int { get }

public var kHIDUsage_Tfon_OutsideDialTone: Int { get }

public var kHIDUsage_Tfon_InsideRingTone: Int { get }

public var kHIDUsage_Tfon_OutsideRingTone: Int { get }

public var kHIDUsage_Tfon_PriorityRingTone: Int { get }

public var kHIDUsage_Tfon_InsideRingback: Int { get }

public var kHIDUsage_Tfon_PriorityRingback: Int { get }

public var kHIDUsage_Tfon_LineBusyTone: Int { get }

public var kHIDUsage_Tfon_ReorderTone: Int { get }

public var kHIDUsage_Tfon_CallWaitingTone: Int { get }

public var kHIDUsage_Tfon_ConfirmationTone1: Int { get }

public var kHIDUsage_Tfon_ConfirmationTone2: Int { get }

public var kHIDUsage_Tfon_TonesOff: Int { get }

public var kHIDUsage_Tfon_OutsideRingback: Int { get }

public var kHIDUsage_Tfon_PhoneKey0: Int { get }

public var kHIDUsage_Tfon_PhoneKey1: Int { get }

public var kHIDUsage_Tfon_PhoneKey2: Int { get }

public var kHIDUsage_Tfon_PhoneKey3: Int { get }

public var kHIDUsage_Tfon_PhoneKey4: Int { get }

public var kHIDUsage_Tfon_PhoneKey5: Int { get }

public var kHIDUsage_Tfon_PhoneKey6: Int { get }

public var kHIDUsage_Tfon_PhoneKey7: Int { get }

public var kHIDUsage_Tfon_PhoneKey8: Int { get }

public var kHIDUsage_Tfon_PhoneKey9: Int { get }

public var kHIDUsage_Tfon_PhoneKeyStar: Int { get }

public var kHIDUsage_Tfon_PhoneKeyPound: Int { get }

public var kHIDUsage_Tfon_PhoneKeyA: Int { get }

public var kHIDUsage_Tfon_PhoneKeyB: Int { get }

public var kHIDUsage_Tfon_PhoneKeyC: Int { get }

public var kHIDUsage_Tfon_PhoneKeyD: Int { get }

public var kHIDUsage_TFon_Reserved: Int { get }

public var kHIDUsage_Csmr_ConsumerControl: Int { get }

public var kHIDUsage_Csmr_NumericKeyPad: Int { get }

public var kHIDUsage_Csmr_ProgrammableButtons: Int { get }

public var kHIDUsage_Csmr_Microphone: Int { get }

public var kHIDUsage_Csmr_Headphone: Int { get }

public var kHIDUsage_Csmr_GraphicEqualizer: Int { get }

public var kHIDUsage_Csmr_Plus10: Int { get }

public var kHIDUsage_Csmr_Plus100: Int { get }

public var kHIDUsage_Csmr_AMOrPM: Int { get }

public var kHIDUsage_Csmr_Power: Int { get }

public var kHIDUsage_Csmr_Reset: Int { get }

public var kHIDUsage_Csmr_Sleep: Int { get }

public var kHIDUsage_Csmr_SleepAfter: Int { get }

public var kHIDUsage_Csmr_SleepMode: Int { get }

public var kHIDUsage_Csmr_Illumination: Int { get }

public var kHIDUsage_Csmr_FunctionButtons: Int { get }

public var kHIDUsage_Csmr_Menu: Int { get }

public var kHIDUsage_Csmr_MenuPick: Int { get }

public var kHIDUsage_Csmr_MenuUp: Int { get }

public var kHIDUsage_Csmr_MenuDown: Int { get }

public var kHIDUsage_Csmr_MenuLeft: Int { get }

public var kHIDUsage_Csmr_MenuRight: Int { get }

public var kHIDUsage_Csmr_MenuEscape: Int { get }

public var kHIDUsage_Csmr_MenuValueIncrease: Int { get }

public var kHIDUsage_Csmr_MenuValueDecrease: Int { get }

public var kHIDUsage_Csmr_DataOnScreen: Int { get }

public var kHIDUsage_Csmr_ClosedCaption: Int { get }

public var kHIDUsage_Csmr_ClosedCaptionSelect: Int { get }

public var kHIDUsage_Csmr_VCROrTV: Int { get }

public var kHIDUsage_Csmr_BroadcastMode: Int { get }

public var kHIDUsage_Csmr_Snapshot: Int { get }

public var kHIDUsage_Csmr_Still: Int { get }

public var kHIDUsage_Csmr_PictureInPictureToggle: Int { get }

public var kHIDUsage_Csmr_PictureInPictureSwap: Int { get }

public var kHIDUsage_Csmr_RedMenuButton: Int { get }

public var kHIDUsage_Csmr_GreenMenuButton: Int { get }

public var kHIDUsage_Csmr_BlueMenuButton: Int { get }

public var kHIDUsage_Csmr_YellowMenuButton: Int { get }

public var kHIDUsage_Csmr_Aspect: Int { get }

public var kHIDUsage_Csmr_3DModeSelect: Int { get }

public var kHIDUsage_Csmr_DisplayBrightnessIncrement: Int { get }

public var kHIDUsage_Csmr_DisplayBrightnessDecrement: Int { get }

public var kHIDUsage_Csmr_DisplayBrightness: Int { get }

public var kHIDUsage_Csmr_DisplayBacklightToggle: Int { get }

public var kHIDUsage_Csmr_DisplayBrightnessMinimum: Int { get }

public var kHIDUsage_Csmr_DisplayBrightnessMaximum: Int { get }

public var kHIDUsage_Csmr_DisplayBrightnessSetAutoBrightness: Int { get }

public var kHIDUsage_Csmr_KeyboardBrightnessIncrement: Int { get }

public var kHIDUsage_Csmr_KeyboardBrightnessDecrement: Int { get }

public var kHIDUsage_Csmr_Selection: Int { get }

public var kHIDUsage_Csmr_Assign: Int { get }

public var kHIDUsage_Csmr_ModeStep: Int { get }

public var kHIDUsage_Csmr_RecallLast: Int { get }

public var kHIDUsage_Csmr_EnterChannel: Int { get }

public var kHIDUsage_Csmr_OrderMovie: Int { get }

public var kHIDUsage_Csmr_Channel: Int { get }

public var kHIDUsage_Csmr_MediaSelection: Int { get }

public var kHIDUsage_Csmr_MediaSelectComputer: Int { get }

public var kHIDUsage_Csmr_MediaSelectTV: Int { get }

public var kHIDUsage_Csmr_MediaSelectWWW: Int { get }

public var kHIDUsage_Csmr_MediaSelectDVD: Int { get }

public var kHIDUsage_Csmr_MediaSelectTelephone: Int { get }

public var kHIDUsage_Csmr_MediaSelectProgramGuide: Int { get }

public var kHIDUsage_Csmr_MediaSelectVideoPhone: Int { get }

public var kHIDUsage_Csmr_MediaSelectGames: Int { get }

public var kHIDUsage_Csmr_MediaSelectMessages: Int { get }

public var kHIDUsage_Csmr_MediaSelectCD: Int { get }

public var kHIDUsage_Csmr_MediaSelectVCR: Int { get }

public var kHIDUsage_Csmr_MediaSelectTuner: Int { get }

public var kHIDUsage_Csmr_Quit: Int { get }

public var kHIDUsage_Csmr_Help: Int { get }

public var kHIDUsage_Csmr_MediaSelectTape: Int { get }

public var kHIDUsage_Csmr_MediaSelectCable: Int { get }

public var kHIDUsage_Csmr_MediaSelectSatellite: Int { get }

public var kHIDUsage_Csmr_MediaSelectSecurity: Int { get }

public var kHIDUsage_Csmr_MediaSelectHome: Int { get }

public var kHIDUsage_Csmr_MediaSelectCall: Int { get }

public var kHIDUsage_Csmr_ChannelIncrement: Int { get }

public var kHIDUsage_Csmr_ChannelDecrement: Int { get }

public var kHIDUsage_Csmr_Media: Int { get }

public var kHIDUsage_Csmr_VCRPlus: Int { get }

public var kHIDUsage_Csmr_Once: Int { get }

public var kHIDUsage_Csmr_Daily: Int { get }

public var kHIDUsage_Csmr_Weekly: Int { get }

public var kHIDUsage_Csmr_Monthly: Int { get }

public var kHIDUsage_Csmr_Play: Int { get }

public var kHIDUsage_Csmr_Pause: Int { get }

public var kHIDUsage_Csmr_Record: Int { get }

public var kHIDUsage_Csmr_FastForward: Int { get }

public var kHIDUsage_Csmr_Rewind: Int { get }

public var kHIDUsage_Csmr_ScanNextTrack: Int { get }

public var kHIDUsage_Csmr_ScanPreviousTrack: Int { get }

public var kHIDUsage_Csmr_Stop: Int { get }

public var kHIDUsage_Csmr_Eject: Int { get }

public var kHIDUsage_Csmr_RandomPlay: Int { get }

public var kHIDUsage_Csmr_SelectDisc: Int { get }

public var kHIDUsage_Csmr_EnterDisc: Int { get }

public var kHIDUsage_Csmr_Repeat: Int { get }

public var kHIDUsage_Csmr_Tracking: Int { get }

public var kHIDUsage_Csmr_TrackNormal: Int { get }

public var kHIDUsage_Csmr_SlowTracking: Int { get }

public var kHIDUsage_Csmr_FrameForward: Int { get }

public var kHIDUsage_Csmr_FrameBack: Int { get }

public var kHIDUsage_Csmr_Mark: Int { get }

public var kHIDUsage_Csmr_ClearMark: Int { get }

public var kHIDUsage_Csmr_RepeatFromMark: Int { get }

public var kHIDUsage_Csmr_ReturnToMark: Int { get }

public var kHIDUsage_Csmr_SearchMarkForward: Int { get }

public var kHIDUsage_Csmr_SearchMarkBackwards: Int { get }

public var kHIDUsage_Csmr_CounterReset: Int { get }

public var kHIDUsage_Csmr_ShowCounter: Int { get }

public var kHIDUsage_Csmr_TrackingIncrement: Int { get }

public var kHIDUsage_Csmr_TrackingDecrement: Int { get }

public var kHIDUsage_Csmr_StopOrEject: Int { get }

public var kHIDUsage_Csmr_PlayOrPause: Int { get }

public var kHIDUsage_Csmr_PlayOrSkip: Int { get }

public var kHIDUsage_Csmr_VoiceCommand: Int { get }

public var kHIDUsage_Csmr_Volume: Int { get }

public var kHIDUsage_Csmr_Balance: Int { get }

public var kHIDUsage_Csmr_Mute: Int { get }

public var kHIDUsage_Csmr_Bass: Int { get }

public var kHIDUsage_Csmr_Treble: Int { get }

public var kHIDUsage_Csmr_BassBoost: Int { get }

public var kHIDUsage_Csmr_SurroundMode: Int { get }

public var kHIDUsage_Csmr_Loudness: Int { get }

public var kHIDUsage_Csmr_MPX: Int { get }

public var kHIDUsage_Csmr_VolumeIncrement: Int { get }

public var kHIDUsage_Csmr_VolumeDecrement: Int { get }

public var kHIDUsage_Csmr_Speed: Int { get }

public var kHIDUsage_Csmr_PlaybackSpeed: Int { get }

public var kHIDUsage_Csmr_StandardPlay: Int { get }

public var kHIDUsage_Csmr_LongPlay: Int { get }

public var kHIDUsage_Csmr_ExtendedPlay: Int { get }

public var kHIDUsage_Csmr_Slow: Int { get }

public var kHIDUsage_Csmr_FanEnable: Int { get }

public var kHIDUsage_Csmr_FanSpeed: Int { get }

public var kHIDUsage_Csmr_LightEnable: Int { get }

public var kHIDUsage_Csmr_LightIlluminationLevel: Int { get }

public var kHIDUsage_Csmr_ClimateControlEnable: Int { get }

public var kHIDUsage_Csmr_RoomTemperature: Int { get }

public var kHIDUsage_Csmr_SecurityEnable: Int { get }

public var kHIDUsage_Csmr_FireAlarm: Int { get }

public var kHIDUsage_Csmr_PoliceAlarm: Int { get }

public var kHIDUsage_Csmr_Proximity: Int { get }

public var kHIDUsage_Csmr_Motion: Int { get }

public var kHIDUsage_Csmr_DuressAlarm: Int { get }

public var kHIDUsage_Csmr_HoldupAlarm: Int { get }

public var kHIDUsage_Csmr_MedicalAlarm: Int { get }

public var kHIDUsage_Csmr_BalanceRight: Int { get }

public var kHIDUsage_Csmr_BalanceLeft: Int { get }

public var kHIDUsage_Csmr_BassIncrement: Int { get }

public var kHIDUsage_Csmr_BassDecrement: Int { get }

public var kHIDUsage_Csmr_TrebleIncrement: Int { get }

public var kHIDUsage_Csmr_TrebleDecrement: Int { get }

public var kHIDUsage_Csmr_SpeakerSystem: Int { get }

public var kHIDUsage_Csmr_ChannelLeft: Int { get }

public var kHIDUsage_Csmr_ChannelRight: Int { get }

public var kHIDUsage_Csmr_ChannelCenter: Int { get }

public var kHIDUsage_Csmr_ChannelFront: Int { get }

public var kHIDUsage_Csmr_ChannelCenterFront: Int { get }

public var kHIDUsage_Csmr_ChannelSide: Int { get }

public var kHIDUsage_Csmr_ChannelSurround: Int { get }

public var kHIDUsage_Csmr_ChannelLowFrequencyEnhancement: Int { get }

public var kHIDUsage_Csmr_ChannelTop: Int { get }

public var kHIDUsage_Csmr_ChannelUnknown: Int { get }

public var kHIDUsage_Csmr_SubChannel: Int { get }

public var kHIDUsage_Csmr_SubChannelIncrement: Int { get }

public var kHIDUsage_Csmr_SubChannelDecrement: Int { get }

public var kHIDUsage_Csmr_AlternateAudioIncrement: Int { get }

public var kHIDUsage_Csmr_AlternateAudioDecrement: Int { get }

public var kHIDUsage_Csmr_ApplicationLaunchButtons: Int { get }

public var kHIDUsage_Csmr_ALLaunchButtonConfigurationTool: Int { get }

public var kHIDUsage_Csmr_ALProgrammableButtonConfiguration: Int { get }

public var kHIDUsage_Csmr_ALConsumerControlConfiguration: Int { get }

public var kHIDUsage_Csmr_ALWordProcessor: Int { get }

public var kHIDUsage_Csmr_ALTextEditor: Int { get }

public var kHIDUsage_Csmr_ALSpreadsheet: Int { get }

public var kHIDUsage_Csmr_ALGraphicsEditor: Int { get }

public var kHIDUsage_Csmr_ALPresentationApp: Int { get }

public var kHIDUsage_Csmr_ALDatabaseApp: Int { get }

public var kHIDUsage_Csmr_ALEmailReader: Int { get }

public var kHIDUsage_Csmr_ALNewsreader: Int { get }

public var kHIDUsage_Csmr_ALVoicemail: Int { get }

public var kHIDUsage_Csmr_ALContactsOrAddressBook: Int { get }

public var kHIDUsage_Csmr_ALCalendarOrSchedule: Int { get }

public var kHIDUsage_Csmr_ALTaskOrProjectManager: Int { get }

public var kHIDUsage_Csmr_ALLogOrJournalOrTimecard: Int { get }

public var kHIDUsage_Csmr_ALCheckbookOrFinance: Int { get }

public var kHIDUsage_Csmr_ALCalculator: Int { get }

public var kHIDUsage_Csmr_ALAOrVCaptureOrPlayback: Int { get }

public var kHIDUsage_Csmr_ALLocalMachineBrowser: Int { get }

public var kHIDUsage_Csmr_ALLANOrWANBrowser: Int { get }

public var kHIDUsage_Csmr_ALInternetBrowser: Int { get }

public var kHIDUsage_Csmr_ALRemoteNetworkingOrISPConnect: Int { get }

public var kHIDUsage_Csmr_ALNetworkConference: Int { get }

public var kHIDUsage_Csmr_ALNetworkChat: Int { get }

public var kHIDUsage_Csmr_ALTelephonyOrDialer: Int { get }

public var kHIDUsage_Csmr_ALLogon: Int { get }

public var kHIDUsage_Csmr_ALLogoff: Int { get }

public var kHIDUsage_Csmr_ALLogonOrLogoff: Int { get }

public var kHIDUsage_Csmr_ALTerminalLockOrScreensaver: Int { get }

public var kHIDUsage_Csmr_ALControlPanel: Int { get }

public var kHIDUsage_Csmr_ALCommandLineProcessorOrRun: Int { get }

public var kHIDUsage_Csmr_ALProcessOrTaskManager: Int { get }

public var kHIDUsage_Csmr_AL: Int { get }

public var kHIDUsage_Csmr_ALNextTaskOrApplication: Int { get }

public var kHIDUsage_Csmr_ALPreviousTaskOrApplication: Int { get }

public var kHIDUsage_Csmr_ALPreemptiveHaltTaskOrApplication: Int { get }

public var kHIDUsage_Csmr_ALIntegratedHelpCenter: Int { get }

public var kHIDUsage_Csmr_ALDocuments: Int { get }

public var kHIDUsage_Csmr_ALThesaurus: Int { get }

public var kHIDUsage_Csmr_ALDictionary: Int { get }

public var kHIDUsage_Csmr_ALDesktop: Int { get }

public var kHIDUsage_Csmr_ALSpellCheck: Int { get }

public var kHIDUsage_Csmr_ALGrammerCheck: Int { get }

public var kHIDUsage_Csmr_ALWirelessStatus: Int { get }

public var kHIDUsage_Csmr_ALKeyboardLayout: Int { get }

public var kHIDUsage_Csmr_ALVirusProtection: Int { get }

public var kHIDUsage_Csmr_ALEncryption: Int { get }

public var kHIDUsage_Csmr_ALScreenSaver: Int { get }

public var kHIDUsage_Csmr_ALAlarms: Int { get }

public var kHIDUsage_Csmr_ALClock: Int { get }

public var kHIDUsage_Csmr_ALFileBrowser: Int { get }

public var kHIDUsage_Csmr_ALPowerStatus: Int { get }

public var kHIDUsage_Csmr_ALImageBrowser: Int { get }

public var kHIDUsage_Csmr_ALAudioBrowser: Int { get }

public var kHIDUsage_Csmr_ALMovieBrowser: Int { get }

public var kHIDUsage_Csmr_ALDigitalRightsManager: Int { get }

public var kHIDUsage_Csmr_ALDigitalWallet: Int { get }

public var kHIDUsage_Csmr_ALInstantMessaging: Int { get }

public var kHIDUsage_Csmr_ALOEMFeatureBrowser: Int { get }

public var kHIDUsage_Csmr_ALOEMHelp: Int { get }

public var kHIDUsage_Csmr_ALOnlineCommunity: Int { get }

public var kHIDUsage_Csmr_ALEntertainmentContentBrowser: Int { get }

public var kHIDUsage_Csmr_ALOnlineShoppingBrowswer: Int { get }

public var kHIDUsage_Csmr_ALSmartCardInformationOrHelp: Int { get }

public var kHIDUsage_Csmr_ALMarketMonitorOrFinanceBrowser: Int { get }

public var kHIDUsage_Csmr_ALCustomizedCorporateNewsBrowser: Int { get }

public var kHIDUsage_Csmr_ALOnlineActivityBrowswer: Int { get }

public var kHIDUsage_Csmr_ALResearchOrSearchBrowswer: Int { get }

public var kHIDUsage_Csmr_ALAudioPlayer: Int { get }

public var kHIDUsage_Csmr_ALMessageStatus: Int { get }

public var kHIDUsage_Csmr_ALContactSync: Int { get }

public var kHIDUsage_Csmr_ALNavigation: Int { get }

public var kHIDUsage_Csmr_ALContextawareDesktopAssistant: Int { get }

public var kHIDUsage_Csmr_GenericGUIApplicationControls: Int { get }

public var kHIDUsage_Csmr_ACNew: Int { get }

public var kHIDUsage_Csmr_ACOpen: Int { get }

public var kHIDUsage_Csmr_ACClose: Int { get }

public var kHIDUsage_Csmr_ACExit: Int { get }

public var kHIDUsage_Csmr_ACMaximize: Int { get }

public var kHIDUsage_Csmr_ACMinimize: Int { get }

public var kHIDUsage_Csmr_ACSave: Int { get }

public var kHIDUsage_Csmr_ACPrint: Int { get }

public var kHIDUsage_Csmr_ACProperties: Int { get }

public var kHIDUsage_Csmr_ACUndo: Int { get }

public var kHIDUsage_Csmr_ACCopy: Int { get }

public var kHIDUsage_Csmr_ACCut: Int { get }

public var kHIDUsage_Csmr_ACPaste: Int { get }

public var kHIDUsage_Csmr_AC: Int { get }

public var kHIDUsage_Csmr_ACFind: Int { get }

public var kHIDUsage_Csmr_ACFindandReplace: Int { get }

public var kHIDUsage_Csmr_ACSearch: Int { get }

public var kHIDUsage_Csmr_ACGoTo: Int { get }

public var kHIDUsage_Csmr_ACHome: Int { get }

public var kHIDUsage_Csmr_ACBack: Int { get }

public var kHIDUsage_Csmr_ACForward: Int { get }

public var kHIDUsage_Csmr_ACStop: Int { get }

public var kHIDUsage_Csmr_ACRefresh: Int { get }

public var kHIDUsage_Csmr_ACPreviousLink: Int { get }

public var kHIDUsage_Csmr_ACNextLink: Int { get }

public var kHIDUsage_Csmr_ACBookmarks: Int { get }

public var kHIDUsage_Csmr_ACHistory: Int { get }

public var kHIDUsage_Csmr_ACSubscriptions: Int { get }

public var kHIDUsage_Csmr_ACZoomIn: Int { get }

public var kHIDUsage_Csmr_ACZoomOut: Int { get }

public var kHIDUsage_Csmr_ACZoom: Int { get }

public var kHIDUsage_Csmr_ACFullScreenView: Int { get }

public var kHIDUsage_Csmr_ACNormalView: Int { get }

public var kHIDUsage_Csmr_ACViewToggle: Int { get }

public var kHIDUsage_Csmr_ACScrollUp: Int { get }

public var kHIDUsage_Csmr_ACScrollDown: Int { get }

public var kHIDUsage_Csmr_ACScroll: Int { get }

public var kHIDUsage_Csmr_ACPanLeft: Int { get }

public var kHIDUsage_Csmr_ACPanRight: Int { get }

public var kHIDUsage_Csmr_ACPan: Int { get }

public var kHIDUsage_Csmr_ACNewWindow: Int { get }

public var kHIDUsage_Csmr_ACTileHorizontally: Int { get }

public var kHIDUsage_Csmr_ACTileVertically: Int { get }

public var kHIDUsage_Csmr_ACFormat: Int { get }

public var kHIDUsage_Csmr_ACEdit: Int { get }

public var kHIDUsage_Csmr_ACBold: Int { get }

public var kHIDUsage_Csmr_ACItalics: Int { get }

public var kHIDUsage_Csmr_ACUnderline: Int { get }

public var kHIDUsage_Csmr_ACStrikethrough: Int { get }

public var kHIDUsage_Csmr_ACSubscript: Int { get }

public var kHIDUsage_Csmr_ACSuperscript: Int { get }

public var kHIDUsage_Csmr_ACAllCaps: Int { get }

public var kHIDUsage_Csmr_ACRotate: Int { get }

public var kHIDUsage_Csmr_ACResize: Int { get }

public var kHIDUsage_Csmr_ACFlipHorizontal: Int { get }

public var kHIDUsage_Csmr_ACFlipVertical: Int { get }

public var kHIDUsage_Csmr_ACMirrorHorizontal: Int { get }

public var kHIDUsage_Csmr_ACMirrorVertical: Int { get }

public var kHIDUsage_Csmr_ACFontSelect: Int { get }

public var kHIDUsage_Csmr_ACFontColor: Int { get }

public var kHIDUsage_Csmr_ACFontSize: Int { get }

public var kHIDUsage_Csmr_ACJustifyLeft: Int { get }

public var kHIDUsage_Csmr_ACJustifyCenterH: Int { get }

public var kHIDUsage_Csmr_ACJustifyRight: Int { get }

public var kHIDUsage_Csmr_ACJustifyBlockH: Int { get }

public var kHIDUsage_Csmr_ACJustifyTop: Int { get }

public var kHIDUsage_Csmr_ACJustifyCenterV: Int { get }

public var kHIDUsage_Csmr_ACJustifyBottom: Int { get }

public var kHIDUsage_Csmr_ACJustifyBlockV: Int { get }

public var kHIDUsage_Csmr_ACIndentyDecrease: Int { get }

public var kHIDUsage_Csmr_ACIndentyIncrease: Int { get }

public var kHIDUsage_Csmr_ACNumberedList: Int { get }

public var kHIDUsage_Csmr_ACRestartNumbering: Int { get }

public var kHIDUsage_Csmr_ACBulletedList: Int { get }

public var kHIDUsage_Csmr_ACPromote: Int { get }

public var kHIDUsage_Csmr_ACDemote: Int { get }

public var kHIDUsage_Csmr_ACYes: Int { get }

public var kHIDUsage_Csmr_ACNo: Int { get }

public var kHIDUsage_Csmr_ACCancel: Int { get }

public var kHIDUsage_Csmr_ACCatalog: Int { get }

public var kHIDUsage_Csmr_ACBuyOrCheckout: Int { get }

public var kHIDUsage_Csmr_ACAddToCart: Int { get }

public var kHIDUsage_Csmr_ACExpand: Int { get }

public var kHIDUsage_Csmr_ACExpandAll: Int { get }

public var kHIDUsage_Csmr_ACCollapse: Int { get }

public var kHIDUsage_Csmr_ACCollapseAll: Int { get }

public var kHIDUsage_Csmr_ACPrintPreview: Int { get }

public var kHIDUsage_Csmr_ACPasteSpecial: Int { get }

public var kHIDUsage_Csmr_ACInsertMode: Int { get }

public var kHIDUsage_Csmr_ACDelete: Int { get }

public var kHIDUsage_Csmr_ACLock: Int { get }

public var kHIDUsage_Csmr_ACUnlock: Int { get }

public var kHIDUsage_Csmr_ACProtect: Int { get }

public var kHIDUsage_Csmr_ACUnprotect: Int { get }

public var kHIDUsage_Csmr_ACAttachComment: Int { get }

public var kHIDUsage_Csmr_ACDetachComment: Int { get }

public var kHIDUsage_Csmr_ACViewComment: Int { get }

public var kHIDUsage_Csmr_ACSelectWord: Int { get }

public var kHIDUsage_Csmr_ACSelectSentence: Int { get }

public var kHIDUsage_Csmr_ACSelectParagraph: Int { get }

public var kHIDUsage_Csmr_ACSelectColumn: Int { get }

public var kHIDUsage_Csmr_ACSelectRow: Int { get }

public var kHIDUsage_Csmr_ACSelectTable: Int { get }

public var kHIDUsage_Csmr_ACSelectObject: Int { get }

public var kHIDUsage_Csmr_ACRedoOrRepeat: Int { get }

public var kHIDUsage_Csmr_ACSort: Int { get }

public var kHIDUsage_Csmr_ACSortAscending: Int { get }

public var kHIDUsage_Csmr_ACSortDescending: Int { get }

public var kHIDUsage_Csmr_ACFilter: Int { get }

public var kHIDUsage_Csmr_ACSetClock: Int { get }

public var kHIDUsage_Csmr_ACViewClock: Int { get }

public var kHIDUsage_Csmr_ACSelectTimeZone: Int { get }

public var kHIDUsage_Csmr_ACEditTimeZones: Int { get }

public var kHIDUsage_Csmr_ACSetAlarm: Int { get }

public var kHIDUsage_Csmr_ACClearAlarm: Int { get }

public var kHIDUsage_Csmr_ACSnoozeAlarm: Int { get }

public var kHIDUsage_Csmr_ACResetAlarm: Int { get }

public var kHIDUsage_Csmr_ACSynchronize: Int { get }

public var kHIDUsage_Csmr_ACSendOrReceive: Int { get }

public var kHIDUsage_Csmr_ACSendTo: Int { get }

public var kHIDUsage_Csmr_ACReply: Int { get }

public var kHIDUsage_Csmr_ACReplyAll: Int { get }

public var kHIDUsage_Csmr_ACForwardMessage: Int { get }

public var kHIDUsage_Csmr_ACSend: Int { get }

public var kHIDUsage_Csmr_ACAttachFile: Int { get }

public var kHIDUsage_Csmr_ACUpload: Int { get }

public var kHIDUsage_Csmr_ACDownload: Int { get }

public var kHIDUsage_Csmr_ACSetBorders: Int { get }

public var kHIDUsage_Csmr_ACInsertRow: Int { get }

public var kHIDUsage_Csmr_ACInsertColumn: Int { get }

public var kHIDUsage_Csmr_ACInsertFile: Int { get }

public var kHIDUsage_Csmr_ACInsertPicture: Int { get }

public var kHIDUsage_Csmr_ACInsertObject: Int { get }

public var kHIDUsage_Csmr_ACInsertSymbol: Int { get }

public var kHIDUsage_Csmr_ACSaveAndClose: Int { get }

public var kHIDUsage_Csmr_ACRename: Int { get }

public var kHIDUsage_Csmr_ACMerge: Int { get }

public var kHIDUsage_Csmr_ACSplit: Int { get }

public var kHIDUsage_Csmr_ACDistributeH: Int { get }

public var kHIDUsage_Csmr_ACDistributeV: Int { get }

public var kHIDUsage_Csmr_ACKeyboardLayoutSelect: Int { get }

public var kHIDUsage_Csmr_ACNavigationGuidance: Int { get }

public var kHIDUsage_Csmr_ACDesktopShowAllWindows: Int { get }

public var kHIDUsage_Csmr_ACSoftKeyLeft: Int { get }

public var kHIDUsage_Csmr_ACSoftKeyRight: Int { get }

public var kHIDUsage_Csmr_ACDesktopShowAllApplications: Int { get }

public var kHIDUsage_Csmr_ACIdleKeepAlive: Int { get }

public var kHIDUsage_Csmr_ExtendedKeyboardAttributesCollection: Int { get }

public var kHIDUsage_Csmr_KeyboardFormFactor: Int { get }

public var kHIDUsage_Csmr_KeyboardKeyType: Int { get }

public var kHIDUsage_Csmr_KeyboardPhysicalLayout: Int { get }

public var kHIDUsage_Csmr_VendorSpecificKeyboardPhysicalLayout: Int { get }

public var kHIDUsage_Csmr_KeyboardIETFLanguageTagIndex: Int { get }

public var kHIDUsage_Csmr_ImplementedKeyboardInputAssistControls: Int { get }

public var kHIDUsage_Csmr_KeyboardInputAssistPrevious: Int { get }

public var kHIDUsage_Csmr_KeyboardInputAssistNext: Int { get }

public var kHIDUsage_Csmr_KeyboardInputAssistPreviousGroup: Int { get }

public var kHIDUsage_Csmr_KeyboardInputAssistNextGroup: Int { get }

public var kHIDUsage_Csmr_KeyboardInputAssistAccept: Int { get }

public var kHIDUsage_Csmr_KeyboardInputAssistCancel: Int { get }

public var kHIDUsage_Csmr_ContactEdited: Int { get }

public var kHIDUsage_Csmr_ContactAdded: Int { get }

public var kHIDUsage_Csmr_ContactRecordActive: Int { get }

public var kHIDUsage_Csmr_ContactIndex: Int { get }

public var kHIDUsage_Csmr_ContactNickname: Int { get }

public var kHIDUsage_Csmr_ContactFirstName: Int { get }

public var kHIDUsage_Csmr_ContactLastName: Int { get }

public var kHIDUsage_Csmr_ContactFullName: Int { get }

public var kHIDUsage_Csmr_ContactPhoneNumberPersonal: Int { get }

public var kHIDUsage_Csmr_ContactPhoneNumberBusiness: Int { get }

public var kHIDUsage_Csmr_ContactPhoneNumberMobile: Int { get }

public var kHIDUsage_Csmr_ContactPhoneNumberPager: Int { get }

public var kHIDUsage_Csmr_ContactPhoneNumberFax: Int { get }

public var kHIDUsage_Csmr_ContactPhoneNumberOther: Int { get }

public var kHIDUsage_Csmr_ContactEmailPersonal: Int { get }

public var kHIDUsage_Csmr_ContactEmailBusiness: Int { get }

public var kHIDUsage_Csmr_ContactEmailOther: Int { get }

public var kHIDUsage_Csmr_ContactEmailMain: Int { get }

public var kHIDUsage_Csmr_ContactSpeedDialNumber: Int { get }

public var kHIDUsage_Csmr_ContactStatusFlag: Int { get }

public var kHIDUsage_Csmr_ContactMisc: Int { get }

public var kHIDUsage_Csmr_Reserved: Int { get }

public var kHIDUsage_Dig_Digitizer: Int { get }

public var kHIDUsage_Dig_Pen: Int { get }

public var kHIDUsage_Dig_LightPen: Int { get }

public var kHIDUsage_Dig_TouchScreen: Int { get }

public var kHIDUsage_Dig_TouchPad: Int { get }

public var kHIDUsage_Dig_WhiteBoard: Int { get }

public var kHIDUsage_Dig_CoordinateMeasuringMachine: Int { get }

public var kHIDUsage_Dig_3DDigitizer: Int { get }

public var kHIDUsage_Dig_StereoPlotter: Int { get }

public var kHIDUsage_Dig_ArticulatedArm: Int { get }

public var kHIDUsage_Dig_Armature: Int { get }

public var kHIDUsage_Dig_MultiplePointDigitizer: Int { get }

public var kHIDUsage_Dig_FreeSpaceWand: Int { get }

public var kHIDUsage_Dig_DeviceConfiguration: Int { get }

public var kHIDUsage_Dig_CapacitiveHeatMapDigitizer: Int { get }

public var kHIDUsage_Dig_Stylus: Int { get }

public var kHIDUsage_Dig_Puck: Int { get }

public var kHIDUsage_Dig_Finger: Int { get }

public var kHIDUsage_Dig_DeviceSettings: Int { get }

public var kHIDUsage_Dig_GestureCharacter: Int { get }

public var kHIDUsage_Dig_TipPressure: Int { get }

public var kHIDUsage_Dig_BarrelPressure: Int { get }

public var kHIDUsage_Dig_InRange: Int { get }

public var kHIDUsage_Dig_Touch: Int { get }

public var kHIDUsage_Dig_Untouch: Int { get }

public var kHIDUsage_Dig_Tap: Int { get }

public var kHIDUsage_Dig_Quality: Int { get }

public var kHIDUsage_Dig_DataValid: Int { get }

public var kHIDUsage_Dig_TransducerIndex: Int { get }

public var kHIDUsage_Dig_TabletFunctionKeys: Int { get }

public var kHIDUsage_Dig_ProgramChangeKeys: Int { get }

public var kHIDUsage_Dig_BatteryStrength: Int { get }

public var kHIDUsage_Dig_Invert: Int { get }

public var kHIDUsage_Dig_XTilt: Int { get }

public var kHIDUsage_Dig_YTilt: Int { get }

public var kHIDUsage_Dig_Azimuth: Int { get }

public var kHIDUsage_Dig_Altitude: Int { get }

public var kHIDUsage_Dig_Twist: Int { get }

public var kHIDUsage_Dig_TipSwitch: Int { get }

public var kHIDUsage_Dig_SecondaryTipSwitch: Int { get }

public var kHIDUsage_Dig_BarrelSwitch: Int { get }

public var kHIDUsage_Dig_Eraser: Int { get }

public var kHIDUsage_Dig_TabletPick: Int { get }

public var kHIDUsage_Dig_TouchValid: Int { get }

public var kHIDUsage_Dig_Width: Int { get }

public var kHIDUsage_Dig_Height: Int { get }

public var kHIDUsage_Dig_ContactIdentifier: Int { get }

public var kHIDUsage_Dig_DeviceMode: Int { get }

public var kHIDUsage_Dig_DeviceIdentifier: Int { get }

public var kHIDUsage_Dig_ContactCount: Int { get }

public var kHIDUsage_Dig_ContactCountMaximum: Int { get }

public var kHIDUsage_Dig_RelativeScanTime: Int { get }

public var kHIDUsage_Dig_SurfaceSwitch: Int { get }

public var kHIDUsage_Dig_GestureCharacterEnable: Int { get }

public var kHIDUsage_Dig_GestureCharacterQuality: Int { get }

public var kHIDUsage_Dig_GestureCharacterDataLength: Int { get }

public var kHIDUsage_Dig_GestureCharacterData: Int { get }

public var kHIDUsage_Dig_GestureCharacterEncoding: Int { get }

public var kHIDUsage_Dig_GestureCharacterEncodingUTF8: Int { get }

public var kHIDUsage_Dig_GestureCharacterEncodingUTF16LE: Int { get }

public var kHIDUsage_Dig_GestureCharacterEncodingUTF16BE: Int { get }

public var kHIDUsage_Dig_GestureCharacterEncodingUTF32LE: Int { get }

public var kHIDUsage_Dig_GestureCharacterEncodingUTF32BE: Int { get }

public var kHIDUsage_Dig_CapacitiveHeatMapProtocolVendorID: Int { get }

public var kHIDUsage_Dig_CapacitiveHeatMapProtocolVersion: Int { get }

public var kHIDUsage_Dig_CapacitiveHeatMapFrameData: Int { get }

public var kHIDUsage_Dig_ReportRate: Int { get }

public var kHIDUsage_Dig_Reserved: Int { get }

public var kHIDUsage_Haptics_SimpleHapticController: Int { get }

public var kHIDUsage_Haptics_WaveformList: Int { get }

public var kHIDUsage_Haptics_DurationList: Int { get }

public var kHIDUsage_Haptics_AutoTrigger: Int { get }

public var kHIDUsage_Haptics_ManualTrigger: Int { get }

public var kHIDUsage_Haptics_AutoTriggerAssociatedControl: Int { get }

public var kHIDUsage_Haptics_Intensity: Int { get }

public var kHIDUsage_Haptics_RepeatCount: Int { get }

public var kHIDUsage_Haptics_RetriggerPeriod: Int { get }

public var kHIDUsage_Haptics_WaveformVendorPage: Int { get }

public var kHIDUsage_Haptics_WaveformVendorID: Int { get }

public var kHIDUsage_Haptics_WaveformCutoffTime: Int { get }

public var kHIDUsage_Haptics_WaveformNone: Int { get }

public var kHIDUsage_Haptics_WaveformStop: Int { get }

public var kHIDUsage_Haptics_WaveformClick: Int { get }

public var kHIDUsage_Haptics_WaveformBuzzContinuous: Int { get }

public var kHIDUsage_Haptics_WaveformRumbleContinuous: Int { get }

public var kHIDUsage_Haptics_WaveformPress: Int { get }

public var kHIDUsage_Haptics_WaveformRelease: Int { get }

public var kHIDUsage_Haptics_VendorWaveformFirst: Int { get }

public var kHIDUsage_Haptics_VendorWaveformLast: Int { get }

public var kHIDUsage_PID_PhysicalInterfaceDevice: Int { get }

public var kHIDUsage_PID_Normal: Int { get }

public var kHIDUsage_PID_SetEffectReport: Int { get }

public var kHIDUsage_PID_EffectBlockIndex: Int { get }

public var kHIDUsage_PID_ParamBlockOffset: Int { get }

public var kHIDUsage_PID_ROM_Flag: Int { get }

public var kHIDUsage_PID_EffectType: Int { get }

public var kHIDUsage_PID_ET_ConstantForce: Int { get }

public var kHIDUsage_PID_ET_Ramp: Int { get }

public var kHIDUsage_PID_ET_CustomForceData: Int { get }

public var kHIDUsage_PID_ET_Square: Int { get }

public var kHIDUsage_PID_ET_Sine: Int { get }

public var kHIDUsage_PID_ET_Triangle: Int { get }

public var kHIDUsage_PID_ET_SawtoothUp: Int { get }

public var kHIDUsage_PID_ET_SawtoothDown: Int { get }

public var kHIDUsage_PID_ET_Spring: Int { get }

public var kHIDUsage_PID_ET_Damper: Int { get }

public var kHIDUsage_PID_ET_Inertia: Int { get }

public var kHIDUsage_PID_ET_Friction: Int { get }

public var kHIDUsage_PID_Duration: Int { get }

public var kHIDUsage_PID_SamplePeriod: Int { get }

public var kHIDUsage_PID_Gain: Int { get }

public var kHIDUsage_PID_TriggerButton: Int { get }

public var kHIDUsage_PID_TriggerRepeatInterval: Int { get }

public var kHIDUsage_PID_AxesEnable: Int { get }

public var kHIDUsage_PID_DirectionEnable: Int { get }

public var kHIDUsage_PID_Direction: Int { get }

public var kHIDUsage_PID_TypeSpecificBlockOffset: Int { get }

public var kHIDUsage_PID_BlockType: Int { get }

public var kHIDUsage_PID_SetEnvelopeReport: Int { get }

public var kHIDUsage_PID_AttackLevel: Int { get }

public var kHIDUsage_PID_AttackTime: Int { get }

public var kHIDUsage_PID_FadeLevel: Int { get }

public var kHIDUsage_PID_FadeTime: Int { get }

public var kHIDUsage_PID_SetConditionReport: Int { get }

public var kHIDUsage_PID_CP_Offset: Int { get }

public var kHIDUsage_PID_PositiveCoefficient: Int { get }

public var kHIDUsage_PID_NegativeCoefficient: Int { get }

public var kHIDUsage_PID_PositiveSaturation: Int { get }

public var kHIDUsage_PID_NegativeSaturation: Int { get }

public var kHIDUsage_PID_DeadBand: Int { get }

public var kHIDUsage_PID_DownloadForceSample: Int { get }

public var kHIDUsage_PID_IsochCustomForceEnable: Int { get }

public var kHIDUsage_PID_CustomForceDataReport: Int { get }

public var kHIDUsage_PID_CustomForceData: Int { get }

public var kHIDUsage_PID_CustomForceVendorDefinedData: Int { get }

public var kHIDUsage_PID_SetCustomForceReport: Int { get }

public var kHIDUsage_PID_CustomForceDataOffset: Int { get }

public var kHIDUsage_PID_SampleCount: Int { get }

public var kHIDUsage_PID_SetPeriodicReport: Int { get }

public var kHIDUsage_PID_Offset: Int { get }

public var kHIDUsage_PID_Magnitude: Int { get }

public var kHIDUsage_PID_Phase: Int { get }

public var kHIDUsage_PID_Period: Int { get }

public var kHIDUsage_PID_SetConstantForceReport: Int { get }

public var kHIDUsage_PID_SetRampForceReport: Int { get }

public var kHIDUsage_PID_RampStart: Int { get }

public var kHIDUsage_PID_RampEnd: Int { get }

public var kHIDUsage_PID_EffectOperationReport: Int { get }

public var kHIDUsage_PID_EffectOperation: Int { get }

public var kHIDUsage_PID_OpEffectStart: Int { get }

public var kHIDUsage_PID_OpEffectStartSolo: Int { get }

public var kHIDUsage_PID_OpEffectStop: Int { get }

public var kHIDUsage_PID_LoopCount: Int { get }

public var kHIDUsage_PID_DeviceGainReport: Int { get }

public var kHIDUsage_PID_DeviceGain: Int { get }

public var kHIDUsage_PID_PoolReport: Int { get }

public var kHIDUsage_PID_RAM_PoolSize: Int { get }

public var kHIDUsage_PID_ROM_PoolSize: Int { get }

public var kHIDUsage_PID_ROM_EffectBlockCount: Int { get }

public var kHIDUsage_PID_SimultaneousEffectsMax: Int { get }

public var kHIDUsage_PID_PoolAlignment: Int { get }

public var kHIDUsage_PID_PoolMoveReport: Int { get }

public var kHIDUsage_PID_MoveSource: Int { get }

public var kHIDUsage_PID_MoveDestination: Int { get }

public var kHIDUsage_PID_MoveLength: Int { get }

public var kHIDUsage_PID_BlockLoadReport: Int { get }

public var kHIDUsage_PID_BlockLoadStatus: Int { get }

public var kHIDUsage_PID_BlockLoadSuccess: Int { get }

public var kHIDUsage_PID_BlockLoadFull: Int { get }

public var kHIDUsage_PID_BlockLoadError: Int { get }

public var kHIDUsage_PID_BlockHandle: Int { get }

public var kHIDUsage_PID_BlockFreeReport: Int { get }

public var kHIDUsage_PID_TypeSpecificBlockHandle: Int { get }

public var kHIDUsage_PID_StateReport: Int { get }

public var kHIDUsage_PID_EffectPlaying: Int { get }

public var kHIDUsage_PID_DeviceControlReport: Int { get }

public var kHIDUsage_PID_DeviceControl: Int { get }

public var kHIDUsage_PID_DC_EnableActuators: Int { get }

public var kHIDUsage_PID_DC_DisableActuators: Int { get }

public var kHIDUsage_PID_DC_StopAllEffects: Int { get }

public var kHIDUsage_PID_DC_DeviceReset: Int { get }

public var kHIDUsage_PID_DC_DevicePause: Int { get }

public var kHIDUsage_PID_DC_DeviceContinue: Int { get }

public var kHIDUsage_PID_DevicePaused: Int { get }

public var kHIDUsage_PID_ActuatorsEnabled: Int { get }

public var kHIDUsage_PID_SafetySwitch: Int { get }

public var kHIDUsage_PID_ActuatorOverrideSwitch: Int { get }

public var kHIDUsage_PID_ActuatorPower: Int { get }

public var kHIDUsage_PID_StartDelay: Int { get }

public var kHIDUsage_PID_ParameterBlockSize: Int { get }

public var kHIDUsage_PID_DeviceManagedPool: Int { get }

public var kHIDUsage_PID_SharedParameterBlocks: Int { get }

public var kHIDUsage_PID_CreateNewEffectReport: Int { get }

public var kHIDUsage_PID_RAM_PoolAvailable: Int { get }

public var kHIDUsage_PID_Reserved: Int { get }

public var kHIDUsage_AD_AlphanumericDisplay: Int { get }

public var kHIDUsage_AD_DisplayAttributesReport: Int { get }

public var kHIDUsage_AD_ASCIICharacterSet: Int { get }

public var kHIDUsage_AD_DataReadBack: Int { get }

public var kHIDUsage_AD_FontReadBack: Int { get }

public var kHIDUsage_AD_DisplayControlReport: Int { get }

public var kHIDUsage_AD_ClearDisplay: Int { get }

public var kHIDUsage_AD_DisplayEnable: Int { get }

public var kHIDUsage_AD_ScreenSaverDelay: Int { get }

public var kHIDUsage_AD_ScreenSaverEnable: Int { get }

public var kHIDUsage_AD_VerticalScroll: Int { get }

public var kHIDUsage_AD_HorizontalScroll: Int { get }

public var kHIDUsage_AD_CharacterReport: Int { get }

public var kHIDUsage_AD_DisplayData: Int { get }

public var kHIDUsage_AD_DisplayStatus: Int { get }

public var kHIDUsage_AD_StatNotReady: Int { get }

public var kHIDUsage_AD_StatReady: Int { get }

public var kHIDUsage_AD_ErrNotaloadablecharacter: Int { get }

public var kHIDUsage_AD_ErrFontdatacannotberead: Int { get }

public var kHIDUsage_AD_CursorPositionReport: Int { get }

public var kHIDUsage_AD_Row: Int { get }

public var kHIDUsage_AD_Column: Int { get }

public var kHIDUsage_AD_Rows: Int { get }

public var kHIDUsage_AD_Columns: Int { get }

public var kHIDUsage_AD_CursorPixelPositioning: Int { get }

public var kHIDUsage_AD_CursorMode: Int { get }

public var kHIDUsage_AD_CursorEnable: Int { get }

public var kHIDUsage_AD_CursorBlink: Int { get }

public var kHIDUsage_AD_FontReport: Int { get }

public var kHIDUsage_AD_FontData: Int { get }

public var kHIDUsage_AD_CharacterWidth: Int { get }

public var kHIDUsage_AD_CharacterHeight: Int { get }

public var kHIDUsage_AD_CharacterSpacingHorizontal: Int { get }

public var kHIDUsage_AD_CharacterSpacingVertical: Int { get }

public var kHIDUsage_AD_UnicodeCharacterSet: Int { get }

public var kHIDUsage_AD_Reserved: Int { get }

public var kHIDUsage_Snsr_Undefined: Int { get }

public var kHIDUsage_Snsr_Sensor: Int { get }

public var kHIDUsage_Snsr_Biometric: Int { get }

public var kHIDUsage_Snsr_Biometric_HumanPresence: Int { get }

public var kHIDUsage_Snsr_Biometric_HumanProximity: Int { get }

public var kHIDUsage_Snsr_Biometric_HumanTouch: Int { get }

public var kHIDUsage_Snsr_Biometric_HeartRate: Int { get }

public var kHIDUsage_Snsr_Electrical: Int { get }

public var kHIDUsage_Snsr_Electrical_Capacitance: Int { get }

public var kHIDUsage_Snsr_Electrical_Current: Int { get }

public var kHIDUsage_Snsr_Electrical_Power: Int { get }

public var kHIDUsage_Snsr_Electrical_Inductance: Int { get }

public var kHIDUsage_Snsr_Electrical_Resistance: Int { get }

public var kHIDUsage_Snsr_Electrical_Voltage: Int { get }

public var kHIDUsage_Snsr_Electrical_Potentiometer: Int { get }

public var kHIDUsage_Snsr_Electrical_Frequency: Int { get }

public var kHIDUsage_Snsr_Electrical_Period: Int { get }

public var kHIDUsage_Snsr_Environmental: Int { get }

public var kHIDUsage_Snsr_Environmental_AtmosphericPressure: Int { get }

public var kHIDUsage_Snsr_Environmental_Humidity: Int { get }

public var kHIDUsage_Snsr_Environmental_Temperature: Int { get }

public var kHIDUsage_Snsr_Environmental_WindDirection: Int { get }

public var kHIDUsage_Snsr_Environmental_WindSpeed: Int { get }

public var kHIDUsage_Snsr_Light: Int { get }

public var kHIDUsage_Snsr_Light_AmbientLight: Int { get }

public var kHIDUsage_Snsr_Light_ConsumerInfrared: Int { get }

public var kHIDUsage_Snsr_Location: Int { get }

public var kHIDUsage_Snsr_Location_Broadcast: Int { get }

public var kHIDUsage_Snsr_Location_DeadReckoning: Int { get }

public var kHIDUsage_Snsr_Location_GPS: Int { get }

public var kHIDUsage_Snsr_Location_Lookup: Int { get }

public var kHIDUsage_Snsr_Location_Other: Int { get }

public var kHIDUsage_Snsr_Location_Static: Int { get }

public var kHIDUsage_Snsr_Location_Triangulation: Int { get }

public var kHIDUsage_Snsr_Mechanical: Int { get }

public var kHIDUsage_Snsr_Mechanical_BooleanSwitch: Int { get }

public var kHIDUsage_Snsr_Mechanical_BooleanSwitchArray: Int { get }

public var kHIDUsage_Snsr_Mechanical_MultivalueSwitch: Int { get }

public var kHIDUsage_Snsr_Mechanical_Force: Int { get }

public var kHIDUsage_Snsr_Mechanical_Pressure: Int { get }

public var kHIDUsage_Snsr_Mechanical_Strain: Int { get }

public var kHIDUsage_Snsr_Mechanical_Weight: Int { get }

public var kHIDUsage_Snsr_Mechanical_HapticVibrator: Int { get }

public var kHIDUsage_Snsr_Mechanical_HallEffectSwitch: Int { get }

public var kHIDUsage_Snsr_Motion: Int { get }

public var kHIDUsage_Snsr_Motion_Accelerometer1D: Int { get }

public var kHIDUsage_Snsr_Motion_Accelerometer2D: Int { get }

public var kHIDUsage_Snsr_Motion_Accelerometer3D: Int { get }

public var kHIDUsage_Snsr_Motion_Gyrometer1D: Int { get }

public var kHIDUsage_Snsr_Motion_Gyrometer2D: Int { get }

public var kHIDUsage_Snsr_Motion_Gyrometer3D: Int { get }

public var kHIDUsage_Snsr_Motion_MotionDetector: Int { get }

public var kHIDUsage_Snsr_Motion_Speedometer: Int { get }

public var kHIDUsage_Snsr_Motion_Accelerometer: Int { get }

public var kHIDUsage_Snsr_Motion_Gyrometer: Int { get }

public var kHIDUsage_Snsr_Motion_GravityVector: Int { get }

public var kHIDUsage_Snsr_Motion_LinearAccelerometer: Int { get }

public var kHIDUsage_Snsr_Orientation: Int { get }

public var kHIDUsage_Snsr_Orientation_Compass1D: Int { get }

public var kHIDUsage_Snsr_Orientation_Compass2D: Int { get }

public var kHIDUsage_Snsr_Orientation_Compass3D: Int { get }

public var kHIDUsage_Snsr_Orientation_Inclinometer1D: Int { get }

public var kHIDUsage_Snsr_Orientation_Inclinometer2D: Int { get }

public var kHIDUsage_Snsr_Orientation_Inclinometer3D: Int { get }

public var kHIDUsage_Snsr_Orientation_Distance1D: Int { get }

public var kHIDUsage_Snsr_Orientation_Distance2D: Int { get }

public var kHIDUsage_Snsr_Orientation_Distance3D: Int { get }

public var kHIDUsage_Snsr_Orientation_DeviceOrientation: Int { get }

public var kHIDUsage_Snsr_Orientation_CompassD: Int { get }

public var kHIDUsage_Snsr_Orientation_InclinometerD: Int { get }

public var kHIDUsage_Snsr_Orientation_DistanceD: Int { get }

public var kHIDUsage_Snsr_Scanner: Int { get }

public var kHIDUsage_Snsr_Scanner_Barcode: Int { get }

public var kHIDUsage_Snsr_Scanner_RFID: Int { get }

public var kHIDUsage_Snsr_Scanner_NFC: Int { get }

public var kHIDUsage_Snsr_Time: Int { get }

public var kHIDUsage_Snsr_Time_AlarmTimer: Int { get }

public var kHIDUsage_Snsr_Time_RealTimeClock: Int { get }

public var kHIDUsage_Snsr_Other: Int { get }

public var kHIDUsage_Snsr_Other_Custom: Int { get }

public var kHIDUsage_Snsr_Other_Generic: Int { get }

public var kHIDUsage_Snsr_Other_GenericEnumerator: Int { get }

public var kHIDUsage_Snsr_Modifier_None: Int { get }

public var kHIDUsage_Snsr_Modifier_ChangeSensitivityAbsolute: Int { get }

public var kHIDUsage_Snsr_Modifier_Max: Int { get }

public var kHIDUsage_Snsr_Modifier_Min: Int { get }

public var kHIDUsage_Snsr_Modifier_Accuracy: Int { get }

public var kHIDUsage_Snsr_Modifier_Resolution: Int { get }

public var kHIDUsage_Snsr_Modifier_ThresholdHigh: Int { get }

public var kHIDUsage_Snsr_Modifier_ThresholdLow: Int { get }

public var kHIDUsage_Snsr_Modifier_CalibrationOffset: Int { get }

public var kHIDUsage_Snsr_Modifier_CalibrationMultiplier: Int { get }

public var kHIDUsage_Snsr_Modifier_ReportInterval: Int { get }

public var kHIDUsage_Snsr_Modifier_FrequencyMax: Int { get }

public var kHIDUsage_Snsr_Modifier_PeriodMax: Int { get }

public var kHIDUsage_Snsr_Modifier_ChangeSensitivityPercentRange: Int { get }

public var kHIDUsage_Snsr_Modifier_ChangeSensitivityPercentRelative: Int { get }

public var kHIDUsage_Snsr_Modifier_VendorDefined: Int { get }

public var kHIDUsage_Snsr_Event: Int { get }

public var kHIDUsage_Snsr_Event_SensorState: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent: Int { get }

public var kHIDUsage_Snsr_Event_SensorState_Undefined: Int { get }

public var kHIDUsage_Snsr_Event_SensorState_Ready: Int { get }

public var kHIDUsage_Snsr_Event_SensorState_NotAvailable: Int { get }

public var kHIDUsage_Snsr_Event_SensorState_NoData: Int { get }

public var kHIDUsage_Snsr_Event_SensorState_Initializing: Int { get }

public var kHIDUsage_Snsr_Event_SensorState_AccessDenied: Int { get }

public var kHIDUsage_Snsr_Event_SensorState_Error: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_Unknown: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_StateChanged: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_PropertyChanged: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_DataUpdated: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_PollResponse: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_ChangeSensitivity: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_RangeMaxReached: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_RangeMinReached: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_HighThresholdCrossUp: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_HighThresholdCrossDown: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_LowThresholdCrossUp: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_LowThresholdCrossDown: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_ZeroThresholdCrossUp: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_ZeroThresholdCrossDown: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_PeriodExceeded: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_FrequencyExceeded: Int { get }

public var kHIDUsage_Snsr_Event_SensorEvent_ComplexTrigger: Int { get }

public var kHIDUsage_Snsr_Property: Int { get }

public var kHIDUsage_Snsr_Property_FriendlyName: Int { get }

public var kHIDUsage_Snsr_Property_PersistentUniqueID: Int { get }

public var kHIDUsage_Snsr_Property_SensorStatus: Int { get }

public var kHIDUsage_Snsr_Property_MinimumReportInterval: Int { get }

public var kHIDUsage_Snsr_Property_Manufacturer: Int { get }

public var kHIDUsage_Snsr_Property_Model: Int { get }

public var kHIDUsage_Snsr_Property_SerialNumber: Int { get }

public var kHIDUsage_Snsr_Property_Description: Int { get }

public var kHIDUsage_Snsr_Property_ConnectionType: Int { get }

public var kHIDUsage_Snsr_Property_DevicePath: Int { get }

public var kHIDUsage_Snsr_Property_HardwareRevision: Int { get }

public var kHIDUsage_Snsr_Property_FirmwareVersion: Int { get }

public var kHIDUsage_Snsr_Property_ReleaseData: Int { get }

public var kHIDUsage_Snsr_Property_ReportInterval: Int { get }

public var kHIDUsage_Snsr_Property_ChangeSensitivityAbsolute: Int { get }

public var kHIDUsage_Snsr_Property_ChangeSensitivityPercentRange: Int { get }

public var kHIDUsage_Snsr_Property_ChangeSensitivityPercentRelative: Int { get }

public var kHIDUsage_Snsr_Property_Accuracy: Int { get }

public var kHIDUsage_Snsr_Property_Resolution: Int { get }

public var kHIDUsage_Snsr_Property_Maximum: Int { get }

public var kHIDUsage_Snsr_Property_Minimum: Int { get }

public var kHIDUsage_Snsr_Property_ReportingState: Int { get }

public var kHIDUsage_Snsr_Property_SamplingRate: Int { get }

public var kHIDUsage_Snsr_Property_ResponseCurve: Int { get }

public var kHIDUsage_Snsr_Property_PowerState: Int { get }

public var kHIDUsage_Snsr_Property_MaxFIFOEvents: Int { get }

public var kHIDUsage_Snsr_Property_ReportLatency: Int { get }

public var kHIDUsage_Snsr_Property_ConnectionType_Integrated: Int { get }

public var kHIDUsage_Snsr_Property_ConnectionType_Attached: Int { get }

public var kHIDUsage_Snsr_Property_ConnectionType_External: Int { get }

public var kHIDUsage_Snsr_Property_ReportingState_NoEvents: Int { get }

public var kHIDUsage_Snsr_Property_ReportingState_AllEvents: Int { get }

public var kHIDUsage_Snsr_Property_ReportingState_ThresholdEvents: Int { get }

public var kHIDUsage_Snsr_Property_ReportingState_WakeNoEvents: Int { get }

public var kHIDUsage_Snsr_Property_ReportingState_WakeAllEvents: Int { get }

public var kHIDUsage_Snsr_Property_ReportingState_WakeThresholdEvents: Int { get }

public var kHIDUsage_Snsr_Property_PowerState_Undefined: Int { get }

public var kHIDUsage_Snsr_Property_PowerState_D0_FullPower: Int { get }

public var kHIDUsage_Snsr_Property_PowerState_D1_LowPower: Int { get }

public var kHIDUsage_Snsr_Property_PowerState_D2_Standby: Int { get }

public var kHIDUsage_Snsr_Property_PowerState_D3_Sleep: Int { get }

public var kHIDUsage_Snsr_Property_PowerState_D4_PowerOff: Int { get }

public var kHIDUsage_Snsr_Light_Illuminance: Int { get }

public var kHIDUsage_Snsr_Data_Location: Int { get }

public var kHIDUsage_Snsr_Data_Location_Reserved: Int { get }

public var kHIDUsage_Snsr_Data_Location_AltitudeAntennaSeaLevel: Int { get }

public var kHIDUsage_Snsr_Data_Location_DifferentialReferenceStationID: Int { get }

public var kHIDUsage_Snsr_Data_Location_AltitudeEllipsoidError: Int { get }

public var kHIDUsage_Snsr_Data_Location_AltitudeEllipsoid: Int { get }

public var kHIDUsage_Snsr_Data_Location_AltitudeSeaLevelError: Int { get }

public var kHIDUsage_Snsr_Data_Location_AltitudeSeaLevel: Int { get }

public var kHIDUsage_Snsr_Data_Location_DifferentialGPSDataAge: Int { get }

public var kHIDUsage_Snsr_Data_Location_ErrorRadius: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixQuality: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixQualityNoFix: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixQualityGPS: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixQualityDGPS: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixType: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixTypeNoFix: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixTypeGPSSPSMode: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixTypeDGPSSPSMode: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixTypeGPSPPSMode: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixTypeRealTimeKinematic: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixTypeFloatRTK: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixTypeEstimated: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixTypeManualInputMode: Int { get }

public var kHIDUsage_Snsr_Data_Location_FixTypeSimulatorMode: Int { get }

public var kHIDUsage_Snsr_Data_Location_GeoidalSeparation: Int { get }

public var kHIDUsage_Snsr_Data_Location_GPSOperationMode: Int { get }

public var kHIDUsage_Snsr_Data_Location_GPSOperationModeManual: Int { get }

public var kHIDUsage_Snsr_Data_Location_GPSOperationModeAutomatic: Int { get }

public var kHIDUsage_Snsr_Data_Location_GPSSelectionMode: Int { get }

public var kHIDUsage_Snsr_Data_Location_GPSSelectionModeAutonomous: Int { get }

public var kHIDUsage_Snsr_Data_Location_GPSSelectionModeDGPS: Int { get }

public var kHIDUsage_Snsr_Data_Location_GPSSelectionModeEstimated: Int { get }

public var kHIDUsage_Snsr_Data_Location_GPSSelectionModeManualInput: Int { get }

public var kHIDUsage_Snsr_Data_Location_GPSSelectionModeSimulator: Int { get }

public var kHIDUsage_Snsr_Data_Location_GPSSelectionModeDataNotValid: Int { get }

public var kHIDUsage_Snsr_Data_Location_GPSStatus: Int { get }

public var kHIDUsage_Snsr_Data_Location_GPSStatusDataValid: Int { get }

public var kHIDUsage_Snsr_Data_Location_GPSStatusDataNotValid: Int { get }

public var kHIDUsage_Snsr_Data_Location_PositionDilutionOfPrecision: Int { get }

public var kHIDUsage_Snsr_Data_Location_HorizontalDilutionOfPrecision: Int { get }

public var kHIDUsage_Snsr_Data_Location_VerticalDilutionOfPrecision: Int { get }

public var kHIDUsage_Snsr_Data_Location_Latitude: Int { get }

public var kHIDUsage_Snsr_Data_Location_Longitude: Int { get }

public var kHIDUsage_Snsr_Data_Location_TrueHeading: Int { get }

public var kHIDUsage_Snsr_Data_Location_MagneticHeading: Int { get }

public var kHIDUsage_Snsr_Data_Location_MagneticVariation: Int { get }

public var kHIDUsage_Snsr_Data_Location_Speed: Int { get }

public var kHIDUsage_Snsr_Data_Location_SatellitesInView: Int { get }

public var kHIDUsage_Snsr_Data_Location_SatellitesInViewAzimuth: Int { get }

public var kHIDUsage_Snsr_Data_Location_SatellitesInViewElevation: Int { get }

public var kHIDUsage_Snsr_Data_Location_SatellitesInViewIDs: Int { get }

public var kHIDUsage_Snsr_Data_Location_SatellitesInViewPRNs: Int { get }

public var kHIDUsage_Snsr_Data_Location_SatellitesInViewSNRatios: Int { get }

public var kHIDUsage_Snsr_Data_Location_SatellitesUsedCount: Int { get }

public var kHIDUsage_Snsr_Data_Location_SatellitesUsedPRNs: Int { get }

public var kHIDUsage_Snsr_Data_Location_NMEASentence: Int { get }

public var kHIDUsage_Snsr_Data_Location_AddressLine1: Int { get }

public var kHIDUsage_Snsr_Data_Location_AddressLine2: Int { get }

public var kHIDUsage_Snsr_Data_Location_City: Int { get }

public var kHIDUsage_Snsr_Data_Location_StateOrProvince: Int { get }

public var kHIDUsage_Snsr_Data_Location_CountryOrRegion: Int { get }

public var kHIDUsage_Snsr_Data_Location_PostalCode: Int { get }

public var kHIDUsage_Snsr_Property_Location: Int { get }

public var kHIDUsage_Snsr_Property_Location_DesiredAccuracy: Int { get }

public var kHIDUsage_Snsr_Property_Location_AccuracyDefault: Int { get }

public var kHIDUsage_Snsr_Property_Location_AccuracyHigh: Int { get }

public var kHIDUsage_Snsr_Property_Location_AccuracyMedium: Int { get }

public var kHIDUsage_Snsr_Property_Location_AccuracyLow: Int { get }

public var kHIDUsage_Snsr_Data_Environmental: Int { get }

public var kHIDUsage_Snsr_Data_Environmental_AtmosphericPressure: Int { get }

public var kHIDUsage_Snsr_Data_Environmental_Reserved: Int { get }

public var kHIDUsage_Snsr_Data_Environmental_RelativeHumidity: Int { get }

public var kHIDUsage_Snsr_Data_Environmental_Temperature: Int { get }

public var kHIDUsage_Snsr_Data_Environmental_WindDirection: Int { get }

public var kHIDUsage_Snsr_Data_Environmental_WindSpeed: Int { get }

public var kHIDUsage_Snsr_Property_Environmental: Int { get }

public var kHIDUsage_Snsr_Property_Environmental_ReferencePressure: Int { get }

public var kHIDUsage_Snsr_Data_Motion: Int { get }

public var kHIDUsage_Snsr_Data_Motion_State: Int { get }

public var kHIDUsage_Snsr_Data_Motion_Acceleration: Int { get }

public var kHIDUsage_Snsr_Data_Motion_AccelerationAxisX: Int { get }

public var kHIDUsage_Snsr_Data_Motion_AccelerationAxisY: Int { get }

public var kHIDUsage_Snsr_Data_Motion_AccelerationAxisZ: Int { get }

public var kHIDUsage_Snsr_Data_Motion_AngularVelocity: Int { get }

public var kHIDUsage_Snsr_Data_Motion_AngularVelocityXAxis: Int { get }

public var kHIDUsage_Snsr_Data_Motion_AngularVelocityYAxis: Int { get }

public var kHIDUsage_Snsr_Data_Motion_AngularVelocityZAxis: Int { get }

public var kHIDUsage_Snsr_Data_Motion_AngularPosition: Int { get }

public var kHIDUsage_Snsr_Data_Motion_AngularPositionXAxis: Int { get }

public var kHIDUsage_Snsr_Data_Motion_AngularPositionYAxis: Int { get }

public var kHIDUsage_Snsr_Data_Motion_AngularPositionZAxis: Int { get }

public var kHIDUsage_Snsr_Data_Motion_Speed: Int { get }

public var kHIDUsage_Snsr_Data_Motion_Intensity: Int { get }

public var kHIDUsage_Snsr_Data_Orientation: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_Heading: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_HeadingXAxis: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_HeadingYAxis: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_HeadingZAxis: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_HeadingCompensatedMagneticNorth: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_HeadingCompensatedTrueNorth: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_HeadingMagneticNorth: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_HeadingTrueNorth: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_Distance: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_DistanceXAxis: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_DistanceYAxis: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_DistanceZAxis: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_DistanceOutOfRange: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_Tilt: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_TiltXAxis: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_TiltYAxis: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_TiltZAxis: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_RotationMatrix: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_Quaternion: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_MagneticFlux: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_MagneticFluxXAxis: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_MagneticFluxYAxis: Int { get }

public var kHIDUsage_Snsr_Data_Orientation_MagneticFluxZAxis: Int { get }

public var kHIDUsage_Snsr_Data_Mechanical: Int { get }

public var kHIDUsage_Snsr_Data_Mechanical_BooleanSwitchState: Int { get }

public var kHIDUsage_Snsr_Data_Mechanical_BooleanSwitchArrayStates: Int { get }

public var kHIDUsage_Snsr_Data_Mechanical_MultivalueSwitchValue: Int { get }

public var kHIDUsage_Snsr_Data_Mechanical_Force: Int { get }

public var kHIDUsage_Snsr_Data_Mechanical_AbsolutePressure: Int { get }

public var kHIDUsage_Snsr_Data_Mechanical_GaugePressure: Int { get }

public var kHIDUsage_Snsr_Data_Mechanical_Strain: Int { get }

public var kHIDUsage_Snsr_Data_Mechanical_Weight: Int { get }

public var kHIDUsage_Snsr_Property_Mechanical: Int { get }

public var kHIDUsage_Snsr_Property_Mechanical_VibrationState: Int { get }

public var kHIDUsage_Snsr_Property_Mechanical_ForwardVibrationSpeed: Int { get }

public var kHIDUsage_Snsr_Property_Mechanical_BackwardVibrationSpeed: Int { get }

public var kHIDUsage_Snsr_Data_Biometric: Int { get }

public var kHIDUsage_Snsr_Data_Biometric_HumanPresence: Int { get }

public var kHIDUsage_Snsr_Data_Biometric_HumanProximityRange: Int { get }

public var kHIDUsage_Snsr_Data_Biometric_HumanProximityOutOfRange: Int { get }

public var kHIDUsage_Snsr_Data_Biometric_HumanTouchState: Int { get }

public var kHIDUsage_Snsr_Data_Biometric_HeartRate: Int { get }

public var kHIDUsage_Snsr_Data_Light: Int { get }

public var kHIDUsage_Snsr_Data_Light_Illuminance: Int { get }

public var kHIDUsage_Snsr_Data_Light_ColorTemperature: Int { get }

public var kHIDUsage_Snsr_Data_Light_Chromaticity: Int { get }

public var kHIDUsage_Snsr_Data_Light_ChromaticityX: Int { get }

public var kHIDUsage_Snsr_Data_Light_ChromaticityY: Int { get }

public var kHIDUsage_Snsr_Data_Light_ConsumerIRSentenceReceive: Int { get }

public var kHIDUsage_Snsr_Property_Light: Int { get }

public var kHIDUsage_Snsr_Property_Light_ConsumerIRSentenceSend: Int { get }

public var kHIDUsage_Snsr_Data_Scanner: Int { get }

public var kHIDUsage_Snsr_Data_Scanner_RFIDTag40Bit: Int { get }

public var kHIDUsage_Snsr_Data_Scanner_NFCSentenceReceive: Int { get }

public var kHIDUsage_Snsr_Property_Scanner: Int { get }

public var kHIDUsage_Snsr_Property_Scanner_NFCSentenceSend: Int { get }

public var kHIDUsage_Snsr_Data_Electrical: Int { get }

public var kHIDUsage_Snsr_Data_Electrical_Capacitance: Int { get }

public var kHIDUsage_Snsr_Data_Electrical_Current: Int { get }

public var kHIDUsage_Snsr_Data_Electrical_ElectricalPower: Int { get }

public var kHIDUsage_Snsr_Data_Electrical_Inductance: Int { get }

public var kHIDUsage_Snsr_Data_Electrical_Resistance: Int { get }

public var kHIDUsage_Snsr_Data_Electrical_Voltage: Int { get }

public var kHIDUsage_Snsr_Data_Electrical_Frequency: Int { get }

public var kHIDUsage_Snsr_Data_Electrical_Period: Int { get }

public var kHIDUsage_Snsr_Data_Electrical_PercentOfRange: Int { get }

public var kHIDUsage_Snsr_Data_Time: Int { get }

public var kHIDUsage_Snsr_Data_Time_Year: Int { get }

public var kHIDUsage_Snsr_Data_Time_Month: Int { get }

public var kHIDUsage_Snsr_Data_Time_Day: Int { get }

public var kHIDUsage_Snsr_Data_Time_DayOfWeek: Int { get }

public var kHIDUsage_Snsr_Data_Time_DayOfWeekSunday: Int { get }

public var kHIDUsage_Snsr_Data_Time_DayOfWeekMonday: Int { get }

public var kHIDUsage_Snsr_Data_Time_DayOfWeekTuesday: Int { get }

public var kHIDUsage_Snsr_Data_Time_DayOfWeekWednesday: Int { get }

public var kHIDUsage_Snsr_Data_Time_DayOfWeekThursday: Int { get }

public var kHIDUsage_Snsr_Data_Time_DayOfWeekFriday: Int { get }

public var kHIDUsage_Snsr_Data_Time_DayOfWeekSaturday: Int { get }

public var kHIDUsage_Snsr_Data_Time_Hour: Int { get }

public var kHIDUsage_Snsr_Data_Time_Minute: Int { get }

public var kHIDUsage_Snsr_Data_Time_Second: Int { get }

public var kHIDUsage_Snsr_Data_Time_Millisecond: Int { get }

public var kHIDUsage_Snsr_Data_Time_Timestamp: Int { get }

public var kHIDUsage_Snsr_Data_Time_JulianDayOfYear: Int { get }

public var kHIDUsage_Snsr_Property_Time: Int { get }

public var kHIDUsage_Snsr_Property_Time_TimeZoneOffsetFromUTC: Int { get }

public var kHIDUsage_Snsr_Property_Time_TimeZoneName: Int { get }

public var kHIDUsage_Snsr_Property_Time_DaylightSavingsTimeObserved: Int { get }

public var kHIDUsage_Snsr_Property_Time_TimeTrimAdjustment: Int { get }

public var kHIDUsage_Snsr_Property_Time_ArmAlarm: Int { get }

public var kHIDUsage_Snsr_Data_Custom: Int { get }

public var kHIDUsage_Snsr_Data_Custom_Usage: Int { get }

public var kHIDUsage_Snsr_Data_Custom_BooleanArray: Int { get }

public var kHIDUsage_Snsr_Data_Custom_Value: Int { get }

public var kHIDUsage_Snsr_Data_Custom_Value1: Int { get }

public var kHIDUsage_Snsr_Data_Custom_Value2: Int { get }

public var kHIDUsage_Snsr_Data_Custom_Value3: Int { get }

public var kHIDUsage_Snsr_Data_Custom_Value4: Int { get }

public var kHIDUsage_Snsr_Data_Custom_Value5: Int { get }

public var kHIDUsage_Snsr_Data_Custom_Value6: Int { get }

public var kHIDUsage_BD_Undefined: Int { get }

public var kHIDUsage_BD_BrailleDisplay: Int { get }

public var kHIDUsage_BD_BrailleRow: Int { get }

public var kHIDUsage_BD_8DotBrailleCell: Int { get }

public var kHIDUsage_BD_6DotBrailleCell: Int { get }

public var kHIDUsage_BD_NumberOfBrailleCells: Int { get }

public var kHIDUsage_BD_ScreenReaderControl: Int { get }

public var kHIDUsage_BD_ScreenReaderIdentifier: Int { get }

public var kHIDUsage_BD_RouterSet1: Int { get }

public var kHIDUsage_BD_RouterSet2: Int { get }

public var kHIDUsage_BD_RouterSet3: Int { get }

public var kHIDUsage_BD_RouterKey: Int { get }

public var kHIDUsage_BD_RowRouterKey: Int { get }

public var kHIDUsage_BD_BrailleButtons: Int { get }

public var kHIDUsage_BD_BrailleKeyboardDot1: Int { get }

public var kHIDUsage_BD_BrailleKeyboardDot2: Int { get }

public var kHIDUsage_BD_BrailleKeyboardDot3: Int { get }

public var kHIDUsage_BD_BrailleKeyboardDot4: Int { get }

public var kHIDUsage_BD_BrailleKeyboardDot5: Int { get }

public var kHIDUsage_BD_BrailleKeyboardDot6: Int { get }

public var kHIDUsage_BD_BrailleKeyboardDot7: Int { get }

public var kHIDUsage_BD_BrailleKeyboardDot8: Int { get }

public var kHIDUsage_BD_BrailleKeyboardSpace: Int { get }

public var kHIDUsage_BD_BrailleKeyboardLeftSpace: Int { get }

public var kHIDUsage_BD_BrailleKeyboardRightSpace: Int { get }

public var kHIDUsage_BD_BrailleFaceControls: Int { get }

public var kHIDUsage_BD_BrailleLeftControls: Int { get }

public var kHIDUsage_BD_BrailleRightControls: Int { get }

public var kHIDUsage_BD_BrailleTopControls: Int { get }

public var kHIDUsage_BD_BrailleJoystickCenter: Int { get }

public var kHIDUsage_BD_BrailleJoystickUp: Int { get }

public var kHIDUsage_BD_BrailleJoystickDown: Int { get }

public var kHIDUsage_BD_BrailleJoystickLeft: Int { get }

public var kHIDUsage_BD_BrailleJoystickRight: Int { get }

public var kHIDUsage_BD_BrailleDPadCenter: Int { get }

public var kHIDUsage_BD_BrailleDPadUp: Int { get }

public var kHIDUsage_BD_BrailleDPadDown: Int { get }

public var kHIDUsage_BD_BrailleDPadLeft: Int { get }

public var kHIDUsage_BD_BrailleDPadRight: Int { get }

public var kHIDUsage_BD_BraillePanLeft: Int { get }

public var kHIDUsage_BD_BraillePanRight: Int { get }

public var kHIDUsage_BD_BrailleRockerUp: Int { get }

public var kHIDUsage_BD_BrailleRockerDown: Int { get }

public var kHIDUsage_BD_BrailleRockerPress: Int { get }

public var kHIDUsage_PD_Undefined: Int { get }

public var kHIDUsage_PD_iName: Int { get }

public var kHIDUsage_PD_PresentStatus: Int { get }

public var kHIDUsage_PD_ChangedStatus: Int { get }

public var kHIDUsage_PD_UPS: Int { get }

public var kHIDUsage_PD_PowerSupply: Int { get }

public var kHIDUsage_PD_PeripheralDevice: Int { get }

public var kHIDUsage_PD_BatterySystem: Int { get }

public var kHIDUsage_PD_BatterySystemID: Int { get }

public var kHIDUsage_PD_Battery: Int { get }

public var kHIDUsage_PD_BatteryID: Int { get }

public var kHIDUsage_PD_Charger: Int { get }

public var kHIDUsage_PD_ChargerID: Int { get }

public var kHIDUsage_PD_PowerConverter: Int { get }

public var kHIDUsage_PD_PowerConverterID: Int { get }

public var kHIDUsage_PD_OutletSystem: Int { get }

public var kHIDUsage_PD_OutletSystemID: Int { get }

public var kHIDUsage_PD_Input: Int { get }

public var kHIDUsage_PD_InputID: Int { get }

public var kHIDUsage_PD_Output: Int { get }

public var kHIDUsage_PD_OutputID: Int { get }

public var kHIDUsage_PD_Flow: Int { get }

public var kHIDUsage_PD_FlowID: Int { get }

public var kHIDUsage_PD_Outlet: Int { get }

public var kHIDUsage_PD_OutletID: Int { get }

public var kHIDUsage_PD_Gang: Int { get }

public var kHIDUsage_PD_GangID: Int { get }

public var kHIDUsage_PD_PowerSummary: Int { get }

public var kHIDUsage_PD_PowerSummaryID: Int { get }

public var kHIDUsage_PD_Voltage: Int { get }

public var kHIDUsage_PD_Current: Int { get }

public var kHIDUsage_PD_Frequency: Int { get }

public var kHIDUsage_PD_ApparentPower: Int { get }

public var kHIDUsage_PD_ActivePower: Int { get }

public var kHIDUsage_PD_PercentLoad: Int { get }

public var kHIDUsage_PD_Temperature: Int { get }

public var kHIDUsage_PD_Humidity: Int { get }

public var kHIDUsage_PD_BadCount: Int { get }

public var kHIDUsage_PD_ConfigVoltage: Int { get }

public var kHIDUsage_PD_ConfigCurrent: Int { get }

public var kHIDUsage_PD_ConfigFrequency: Int { get }

public var kHIDUsage_PD_ConfigApparentPower: Int { get }

public var kHIDUsage_PD_ConfigActivePower: Int { get }

public var kHIDUsage_PD_ConfigPercentLoad: Int { get }

public var kHIDUsage_PD_ConfigTemperature: Int { get }

public var kHIDUsage_PD_ConfigHumidity: Int { get }

public var kHIDUsage_PD_SwitchOnControl: Int { get }

public var kHIDUsage_PD_SwitchOffControl: Int { get }

public var kHIDUsage_PD_ToggleControl: Int { get }

public var kHIDUsage_PD_LowVoltageTransfer: Int { get }

public var kHIDUsage_PD_HighVoltageTransfer: Int { get }

public var kHIDUsage_PD_DelayBeforeReboot: Int { get }

public var kHIDUsage_PD_DelayBeforeStartup: Int { get }

public var kHIDUsage_PD_DelayBeforeShutdown: Int { get }

public var kHIDUsage_PD_Test: Int { get }

public var kHIDUsage_PD_ModuleReset: Int { get }

public var kHIDUsage_PD_AudibleAlarmControl: Int { get }

public var kHIDUsage_PD_Present: Int { get }

public var kHIDUsage_PD_Good: Int { get }

public var kHIDUsage_PD_InternalFailure: Int { get }

public var kHIDUsage_PD_VoltageOutOfRange: Int { get }

public var kHIDUsage_PD_FrequencyOutOfRange: Int { get }

public var kHIDUsage_PD_Overload: Int { get }

public var kHIDUsage_PD_OverCharged: Int { get }

public var kHIDUsage_PD_OverTemperature: Int { get }

public var kHIDUsage_PD_ShutdownRequested: Int { get }

public var kHIDUsage_PD_ShutdownImminent: Int { get }

public var kHIDUsage_PD_SwitchOnOff: Int { get }

public var kHIDUsage_PD_Switchable: Int { get }

public var kHIDUsage_PD_Used: Int { get }

public var kHIDUsage_PD_Boost: Int { get }

public var kHIDUsage_PD_Buck: Int { get }

public var kHIDUsage_PD_Initialized: Int { get }

public var kHIDUsage_PD_Tested: Int { get }

public var kHIDUsage_PD_AwaitingPower: Int { get }

public var kHIDUsage_PD_CommunicationLost: Int { get }

public var kHIDUsage_PD_iManufacturer: Int { get }

public var kHIDUsage_PD_iProduct: Int { get }

public var kHIDUsage_PD_iserialNumber: Int { get }

public var kHIDUsage_BS_Undefined: Int { get }

public var kHIDUsage_BS_SMBBatteryMode: Int { get }

public var kHIDUsage_BS_SMBBatteryStatus: Int { get }

public var kHIDUsage_BS_SMBAlarmWarning: Int { get }

public var kHIDUsage_BS_SMBChargerMode: Int { get }

public var kHIDUsage_BS_SMBChargerStatus: Int { get }

public var kHIDUsage_BS_SMBChargerSpecInfo: Int { get }

public var kHIDUsage_BS_SMBSelectorState: Int { get }

public var kHIDUsage_BS_SMBSelectorPresets: Int { get }

public var kHIDUsage_BS_SMBSelectorInfo: Int { get }

public var kHIDUsage_BS_OptionalMfgFunction1: Int { get }

public var kHIDUsage_BS_OptionalMfgFunction2: Int { get }

public var kHIDUsage_BS_OptionalMfgFunction3: Int { get }

public var kHIDUsage_BS_OptionalMfgFunction4: Int { get }

public var kHIDUsage_BS_OptionalMfgFunction5: Int { get }

public var kHIDUsage_BS_ConnectionToSMBus: Int { get }

public var kHIDUsage_BS_OutputConnection: Int { get }

public var kHIDUsage_BS_ChargerConnection: Int { get }

public var kHIDUsage_BS_BatteryInsertion: Int { get }

public var kHIDUsage_BS_Usenext: Int { get }

public var kHIDUsage_BS_OKToUse: Int { get }

public var kHIDUsage_BS_BatterySupported: Int { get }

public var kHIDUsage_BS_SelectorRevision: Int { get }

public var kHIDUsage_BS_ChargingIndicator: Int { get }

public var kHIDUsage_BS_ManufacturerAccess: Int { get }

public var kHIDUsage_BS_RemainingCapacityLimit: Int { get }

public var kHIDUsage_BS_RemainingTimeLimit: Int { get }

public var kHIDUsage_BS_AtRate: Int { get }

public var kHIDUsage_BS_CapacityMode: Int { get }

public var kHIDUsage_BS_BroadcastToCharger: Int { get }

public var kHIDUsage_BS_PrimaryBattery: Int { get }

public var kHIDUsage_BS_ChargeController: Int { get }

public var kHIDUsage_BS_TerminateCharge: Int { get }

public var kHIDUsage_BS_TerminateDischarge: Int { get }

public var kHIDUsage_BS_BelowRemainingCapacityLimit: Int { get }

public var kHIDUsage_BS_RemainingTimeLimitExpired: Int { get }

public var kHIDUsage_BS_Charging: Int { get }

public var kHIDUsage_BS_Discharging: Int { get }

public var kHIDUsage_BS_FullyCharged: Int { get }

public var kHIDUsage_BS_FullyDischarged: Int { get }

public var kHIDUsage_BS_ConditioningFlag: Int { get }

public var kHIDUsage_BS_AtRateOK: Int { get }

public var kHIDUsage_BS_SMBErrorCode: Int { get }

public var kHIDUsage_BS_NeedReplacement: Int { get }

public var kHIDUsage_BS_AtRateTimeToFull: Int { get }

public var kHIDUsage_BS_AtRateTimeToEmpty: Int { get }

public var kHIDUsage_BS_AverageCurrent: Int { get }

public var kHIDUsage_BS_Maxerror: Int { get }

public var kHIDUsage_BS_RelativeStateOfCharge: Int { get }

public var kHIDUsage_BS_AbsoluteStateOfCharge: Int { get }

public var kHIDUsage_BS_RemainingCapacity: Int { get }

public var kHIDUsage_BS_FullChargeCapacity: Int { get }

public var kHIDUsage_BS_RunTimeToEmpty: Int { get }

public var kHIDUsage_BS_AverageTimeToEmpty: Int { get }

public var kHIDUsage_BS_AverageTimeToFull: Int { get }

public var kHIDUsage_BS_CycleCount: Int { get }

public var kHIDUsage_BS_BattPackModelLevel: Int { get }

public var kHIDUsage_BS_InternalChargeController: Int { get }

public var kHIDUsage_BS_PrimaryBatterySupport: Int { get }

public var kHIDUsage_BS_DesignCapacity: Int { get }

public var kHIDUsage_BS_SpecificationInfo: Int { get }

public var kHIDUsage_BS_ManufacturerDate: Int { get }

public var kHIDUsage_BS_SerialNumber: Int { get }

public var kHIDUsage_BS_iManufacturerName: Int { get }

public var kHIDUsage_BS_iDevicename: Int { get }

public var kHIDUsage_BS_iDeviceChemistry: Int { get }

public var kHIDUsage_BS_ManufacturerData: Int { get }

public var kHIDUsage_BS_Rechargable: Int { get }

public var kHIDUsage_BS_WarningCapacityLimit: Int { get }

public var kHIDUsage_BS_CapacityGranularity1: Int { get }

public var kHIDUsage_BS_CapacityGranularity2: Int { get }

public var kHIDUsage_BS_iOEMInformation: Int { get }

public var kHIDUsage_BS_InhibitCharge: Int { get }

public var kHIDUsage_BS_EnablePolling: Int { get }

public var kHIDUsage_BS_ResetToZero: Int { get }

public var kHIDUsage_BS_ACPresent: Int { get }

public var kHIDUsage_BS_BatteryPresent: Int { get }

public var kHIDUsage_BS_PowerFail: Int { get }

public var kHIDUsage_BS_AlarmInhibited: Int { get }

public var kHIDUsage_BS_ThermistorUnderRange: Int { get }

public var kHIDUsage_BS_ThermistorHot: Int { get }

public var kHIDUsage_BS_ThermistorCold: Int { get }

public var kHIDUsage_BS_ThermistorOverRange: Int { get }

public var kHIDUsage_BS_VoltageOutOfRange: Int { get }

public var kHIDUsage_BS_CurrentOutOfRange: Int { get }

public var kHIDUsage_BS_CurrentNotRegulated: Int { get }

public var kHIDUsage_BS_VoltageNotRegulated: Int { get }

public var kHIDUsage_BS_MasterMode: Int { get }

public var kHIDUsage_BS_ChargerSelectorSupport: Int { get }

public var kHIDUsage_BS_ChargerSpec: Int { get }

public var kHIDUsage_BS_Level2: Int { get }

public var kHIDUsage_BS_Level3: Int { get }

public var kHIDUsage_BCS_Undefined: Int { get }

public var kHIDUsage_BCS_BadgeReader: Int { get }

public var kHIDUsage_BCS_BarCodeScanner: Int { get }

public var kHIDUsage_BCS_DumbBarCodeScanner: Int { get }

public var kHIDUsage_BCS_CordlessScannerBase: Int { get }

public var kHIDUsage_BCS_BarCodeScannerCradle: Int { get }

public var kHIDUsage_BCS_AttributeReport: Int { get }

public var kHIDUsage_BCS_SettingsReport: Int { get }

public var kHIDUsage_BCS_ScannedDataReport: Int { get }

public var kHIDUsage_BCS_RawScannedDataReport: Int { get }

public var kHIDUsage_BCS_TriggerReport: Int { get }

public var kHIDUsage_BCS_StatusReport: Int { get }

public var kHIDUsage_BCS_UPC_EANControlReport: Int { get }

public var kHIDUsage_BCS_EAN2_3LabelControlReport: Int { get }

public var kHIDUsage_BCS_Code39ControlReport: Int { get }

public var kHIDUsage_BCS_Interleaved2of5ControlReport: Int { get }

public var kHIDUsage_BCS_Standard2of5ControlReport: Int { get }

public var kHIDUsage_BCS_MSIPlesseyControlReport: Int { get }

public var kHIDUsage_BCS_CodabarControlReport: Int { get }

public var kHIDUsage_BCS_Code128ControlReport: Int { get }

public var kHIDUsage_BCS_Misc1DControlReport: Int { get }

public var kHIDUsage_BCS_2DControlReport: Int { get }

public var kHIDUsage_BCS_Aiming_PointerMide: Int { get }

public var kHIDUsage_BCS_BarCodePresentSensor: Int { get }

public var kHIDUsage_BCS_Class1ALaser: Int { get }

public var kHIDUsage_BCS_Class2Laser: Int { get }

public var kHIDUsage_BCS_HeaterPresent: Int { get }

public var kHIDUsage_BCS_ContactScanner: Int { get }

public var kHIDUsage_BCS_ElectronicArticleSurveillanceNotification: Int { get }

public var kHIDUsage_BCS_ConstantElectronicArticleSurveillance: Int { get }

public var kHIDUsage_BCS_ErrorIndication: Int { get }

public var kHIDUsage_BCS_FixedBeeper: Int { get }

public var kHIDUsage_BCS_GoodDecodeIndication: Int { get }

public var kHIDUsage_BCS_HandsFreeScanning: Int { get }

public var kHIDUsage_BCS_IntrinsicallySafe: Int { get }

public var kHIDUsage_BCS_KlasseEinsLaser: Int { get }

public var kHIDUsage_BCS_LongRangeScanner: Int { get }

public var kHIDUsage_BCS_MirrorSpeedControl: Int { get }

public var kHIDUsage_BCS_NotOnFileIndication: Int { get }

public var kHIDUsage_BCS_ProgrammableBeeper: Int { get }

public var kHIDUsage_BCS_Triggerless: Int { get }

public var kHIDUsage_BCS_Wand: Int { get }

public var kHIDUsage_BCS_WaterResistant: Int { get }

public var kHIDUsage_BCS_MultiRangeScanner: Int { get }

public var kHIDUsage_BCS_ProximitySensor: Int { get }

public var kHIDUsage_BCS_FragmentDecoding: Int { get }

public var kHIDUsage_BCS_ScannerReadConfidence: Int { get }

public var kHIDUsage_BCS_DataPrefix: Int { get }

public var kHIDUsage_BCS_PrefixAIMI: Int { get }

public var kHIDUsage_BCS_PrefixNone: Int { get }

public var kHIDUsage_BCS_PrefixProprietary: Int { get }

public var kHIDUsage_BCS_ActiveTime: Int { get }

public var kHIDUsage_BCS_AimingLaserPattern: Int { get }

public var kHIDUsage_BCS_BarCodePresent: Int { get }

public var kHIDUsage_BCS_BeeperState: Int { get }

public var kHIDUsage_BCS_LaserOnTime: Int { get }

public var kHIDUsage_BCS_LaserState: Int { get }

public var kHIDUsage_BCS_LockoutTime: Int { get }

public var kHIDUsage_BCS_MotorState: Int { get }

public var kHIDUsage_BCS_MotorTimeout: Int { get }

public var kHIDUsage_BCS_PowerOnResetScanner: Int { get }

public var kHIDUsage_BCS_PreventReadOfBarcodes: Int { get }

public var kHIDUsage_BCS_InitiateBarcodeRead: Int { get }

public var kHIDUsage_BCS_TriggerState: Int { get }

public var kHIDUsage_BCS_TriggerMode: Int { get }

public var kHIDUsage_BCS_TriggerModeBlinkingLaserOn: Int { get }

public var kHIDUsage_BCS_TriggerModeContinuousLaserOn: Int { get }

public var kHIDUsage_BCS_TriggerModeLaserOnWhilePulled: Int { get }

public var kHIDUsage_BCS_TriggerModeLaserStaysOnAfterTriggerRelease: Int { get }

public var kHIDUsage_BCS_CommitParametersToNVM: Int { get }

public var kHIDUsage_BCS_ParameterScanning: Int { get }

public var kHIDUsage_BCS_ParametersChanged: Int { get }

public var kHIDUsage_BCS_SetParameterDefaultValues: Int { get }

public var kHIDUsage_BCS_ScannerInCradle: Int { get }

public var kHIDUsage_BCS_ScannerInRange: Int { get }

public var kHIDUsage_BCS_AimDuration: Int { get }

public var kHIDUsage_BCS_GoodReadLampDuration: Int { get }

public var kHIDUsage_BCS_GoodReadLampIntensity: Int { get }

public var kHIDUsage_BCS_GoodReadLED: Int { get }

public var kHIDUsage_BCS_GoodReadToneFrequency: Int { get }

public var kHIDUsage_BCS_GoodReadToneLength: Int { get }

public var kHIDUsage_BCS_GoodReadToneVolume: Int { get }

public var kHIDUsage_BCS_NoReadMessage: Int { get }

public var kHIDUsage_BCS_NotOnFileVolume: Int { get }

public var kHIDUsage_BCS_PowerupBeep: Int { get }

public var kHIDUsage_BCS_SoundErrorBeep: Int { get }

public var kHIDUsage_BCS_SoundGoodReadBeep: Int { get }

public var kHIDUsage_BCS_SoundNotOnFileBeep: Int { get }

public var kHIDUsage_BCS_GoodReadWhenToWrite: Int { get }

public var kHIDUsage_BCS_GRWTIAfterDecode: Int { get }

public var kHIDUsage_BCS_GRWTIBeep_LampAfterTransmit: Int { get }

public var kHIDUsage_BCS_GRWTINoBeep_LampUseAtAll: Int { get }

public var kHIDUsage_BCS_BooklandEAN: Int { get }

public var kHIDUsage_BCS_ConvertEAN8To13Type: Int { get }

public var kHIDUsage_BCS_ConvertUPCAToEAN_13: Int { get }

public var kHIDUsage_BCS_ConvertUPC_EToA: Int { get }

public var kHIDUsage_BCS_EAN_13: Int { get }

public var kHIDUsage_BCS_EAN_8: Int { get }

public var kHIDUsage_BCS_EAN_99_128_Mandatory: Int { get }

public var kHIDUsage_BCS_EAN_99_P5_128_Optional: Int { get }

public var kHIDUsage_BCS_UPC_EAN: Int { get }

public var kHIDUsage_BCS_UPC_EANCouponCode: Int { get }

public var kHIDUsage_BCS_UPC_EANPeriodicals: Int { get }

public var kHIDUsage_BCS_UPC_A: Int { get }

public var kHIDUsage_BCS_UPC_AWith128Mandatory: Int { get }

public var kHIDUsage_BCS_UPC_AWith128Optical: Int { get }

public var kHIDUsage_BCS_UPC_AWithP5Optional: Int { get }

public var kHIDUsage_BCS_UPC_E: Int { get }

public var kHIDUsage_BCS_UPC_E1: Int { get }

public var kHIDUsage_BCS_Periodical: Int { get }

public var kHIDUsage_BCS_PeriodicalAutoDiscriminatePlus2: Int { get }

public var kHIDUsage_BCS_PeriodicalOnlyDecodeWithPlus2: Int { get }

public var kHIDUsage_BCS_PeriodicalIgnorePlus2: Int { get }

public var kHIDUsage_BCS_PeriodicalAutoDiscriminatePlus5: Int { get }

public var kHIDUsage_BCS_PeriodicalOnlyDecodeWithPlus5: Int { get }

public var kHIDUsage_BCS_PeriodicalIgnorePlus5: Int { get }

public var kHIDUsage_BCS_Check: Int { get }

public var kHIDUsage_BCS_CheckDisablePrice: Int { get }

public var kHIDUsage_BCS_CheckEnable4DigitPrice: Int { get }

public var kHIDUsage_BCS_CheckEnable5DigitPrice: Int { get }

public var kHIDUsage_BCS_CheckEnableEuropean4DigitPrice: Int { get }

public var kHIDUsage_BCS_CheckEnableEuropean5DigitPrice: Int { get }

public var kHIDUsage_BCS_EANTwoLabel: Int { get }

public var kHIDUsage_BCS_EANThreeLabel: Int { get }

public var kHIDUsage_BCS_EAN8FlagDigit1: Int { get }

public var kHIDUsage_BCS_EAN8FlagDigit2: Int { get }

public var kHIDUsage_BCS_EAN8FlagDigit3: Int { get }

public var kHIDUsage_BCS_EAN13FlagDigit1: Int { get }

public var kHIDUsage_BCS_EAN13FlagDigit2: Int { get }

public var kHIDUsage_BCS_EAN13FlagDigit3: Int { get }

public var kHIDUsage_BCS_AddEAN2_3LabelDefinition: Int { get }

public var kHIDUsage_BCS_ClearAllEAN2_3LabelDefinitions: Int { get }

public var kHIDUsage_BCS_Codabar: Int { get }

public var kHIDUsage_BCS_Code128: Int { get }

public var kHIDUsage_BCS_Code39: Int { get }

public var kHIDUsage_BCS_Code93: Int { get }

public var kHIDUsage_BCS_FullASCIIConversion: Int { get }

public var kHIDUsage_BCS_Interleaved2of5: Int { get }

public var kHIDUsage_BCS_ItalianPharmacyCode: Int { get }

public var kHIDUsage_BCS_MSI_Plessey: Int { get }

public var kHIDUsage_BCS_Standard2of5IATA: Int { get }

public var kHIDUsage_BCS_Standard2of5: Int { get }

public var kHIDUsage_BCS_TransmitStart_Stop: Int { get }

public var kHIDUsage_BCS_TriOptic: Int { get }

public var kHIDUsage_BCS_UCC_EAN_128: Int { get }

public var kHIDUsage_BCS_CheckDigit: Int { get }

public var kHIDUsage_BCS_CheckDigitDisable: Int { get }

public var kHIDUsage_BCS_CheckDigitEnableInterleaved2of5OPCC: Int { get }

public var kHIDUsage_BCS_CheckDigitEnableInterleaved2of5USS: Int { get }

public var kHIDUsage_BCS_CheckDigitEnableStandard2of5OPCC: Int { get }

public var kHIDUsage_BCS_CheckDigitEnableStandard2of5USS: Int { get }

public var kHIDUsage_BCS_CheckDigitEnableOneMSIPlessey: Int { get }

public var kHIDUsage_BCS_CheckDigitEnableTwoMSIPlessey: Int { get }

public var kHIDUsage_BCS_CheckDigitCodabarEnable: Int { get }

public var kHIDUsage_BCS_CheckDigitCode99Enable: Int { get }

public var kHIDUsage_BCS_TransmitCheckDigit: Int { get }

public var kHIDUsage_BCS_DisableCheckDigitTransmit: Int { get }

public var kHIDUsage_BCS_EnableCheckDigitTransmit: Int { get }

public var kHIDUsage_BCS_SymbologyIdentifier1: Int { get }

public var kHIDUsage_BCS_SymbologyIdentifier2: Int { get }

public var kHIDUsage_BCS_SymbologyIdentifier3: Int { get }

public var kHIDUsage_BCS_DecodedData: Int { get }

public var kHIDUsage_BCS_DecodeDataContinued: Int { get }

public var kHIDUsage_BCS_BarSpaceData: Int { get }

public var kHIDUsage_BCS_ScannerDataAccuracy: Int { get }

public var kHIDUsage_BCS_RawDataPolarity: Int { get }

public var kHIDUsage_BCS_PolarityInvertedBarCode: Int { get }

public var kHIDUsage_BCS_PolarityNormalBarCode: Int { get }

public var kHIDUsage_BCS_MinimumLengthToDecode: Int { get }

public var kHIDUsage_BCS_MaximumLengthToDecode: Int { get }

public var kHIDUsage_BCS_FirstDiscreteLengthToDecode: Int { get }

public var kHIDUsage_BCS_SecondDiscreteLengthToDecode: Int { get }

public var kHIDUsage_BCS_DataLengthMethod: Int { get }

public var kHIDUsage_BCS_DLMethodReadAny: Int { get }

public var kHIDUsage_BCS_DLMethodCheckInRange: Int { get }

public var kHIDUsage_BCS_DLMethodCheckForDiscrete: Int { get }

public var kHIDUsage_BCS_AztecCode: Int { get }

public var kHIDUsage_BCS_BC412: Int { get }

public var kHIDUsage_BCS_ChannelCode: Int { get }

public var kHIDUsage_BCS_Code16: Int { get }

public var kHIDUsage_BCS_Code32: Int { get }

public var kHIDUsage_BCS_Code49: Int { get }

public var kHIDUsage_BCS_CodeOne: Int { get }

public var kHIDUsage_BCS_Colorcode: Int { get }

public var kHIDUsage_BCS_DataMatrix: Int { get }

public var kHIDUsage_BCS_MaxiCode: Int { get }

public var kHIDUsage_BCS_MicroPDF: Int { get }

public var kHIDUsage_BCS_PDF_417: Int { get }

public var kHIDUsage_BCS_PosiCode: Int { get }

public var kHIDUsage_BCS_QRCode: Int { get }

public var kHIDUsage_BCS_SuperCode: Int { get }

public var kHIDUsage_BCS_UltraCode: Int { get }

public var kHIDUsage_BCS_USB_5_SlugCode: Int { get }

public var kHIDUsage_BCS_VeriCode: Int { get }

public var kHIDUsage_WD_Undefined: Int { get }

public var kHIDUsage_WD_WeighingDevice: Int { get }

public var kHIDUsage_WD_ScaleScaleDevice: Int { get }

public var kHIDUsage_WD_ScaleScaleClassIMetricCL: Int { get }

public var kHIDUsage_WD_ScaleScaleClassIMetric: Int { get }

public var kHIDUsage_WD_ScaleScaleClassIIMetric: Int { get }

public var kHIDUsage_WD_ScaleScaleClassIIIMetric: Int { get }

public var kHIDUsage_WD_ScaleScaleClassIIILMetric: Int { get }

public var kHIDUsage_WD_ScaleScaleClassIVMetric: Int { get }

public var kHIDUsage_WD_ScaleScaleClassIIIEnglish: Int { get }

public var kHIDUsage_WD_ScaleScaleClassIIILEnglish: Int { get }

public var kHIDUsage_WD_ScaleScaleClassIVEnglish: Int { get }

public var kHIDUsage_WD_ScaleScaleClassGeneric: Int { get }

public var kHIDUsage_WD_ScaleAtrributeReport: Int { get }

public var kHIDUsage_WD_ScaleControlReport: Int { get }

public var kHIDUsage_WD_ScaleDataReport: Int { get }

public var kHIDUsage_WD_ScaleStatusReport: Int { get }

public var kHIDUsage_WD_ScaleWeightLimitReport: Int { get }

public var kHIDUsage_WD_ScaleStatisticsReport: Int { get }

public var kHIDUsage_WD_DataWeight: Int { get }

public var kHIDUsage_WD_DataScaling: Int { get }

public var kHIDUsage_WD_WeightUnit: Int { get }

public var kHIDUsage_WD_WeightUnitMilligram: Int { get }

public var kHIDUsage_WD_WeightUnitGram: Int { get }

public var kHIDUsage_WD_WeightUnitKilogram: Int { get }

public var kHIDUsage_WD_WeightUnitCarats: Int { get }

public var kHIDUsage_WD_WeightUnitTaels: Int { get }

public var kHIDUsage_WD_WeightUnitGrains: Int { get }

public var kHIDUsage_WD_WeightUnitPennyweights: Int { get }

public var kHIDUsage_WD_WeightUnitMetricTon: Int { get }

public var kHIDUsage_WD_WeightUnitAvoirTon: Int { get }

public var kHIDUsage_WD_WeightUnitTroyOunce: Int { get }

public var kHIDUsage_WD_WeightUnitOunce: Int { get }

public var kHIDUsage_WD_WeightUnitPound: Int { get }

public var kHIDUsage_WD_CalibrationCount: Int { get }

public var kHIDUsage_WD_RezeroCount: Int { get }

public var kHIDUsage_WD_ScaleStatus: Int { get }

public var kHIDUsage_WD_ScaleStatusFault: Int { get }

public var kHIDUsage_WD_ScaleStatusStableAtZero: Int { get }

public var kHIDUsage_WD_ScaleStatusInMotion: Int { get }

public var kHIDUsage_WD_ScaleStatusWeightStable: Int { get }

public var kHIDUsage_WD_ScaleStatusUnderZero: Int { get }

public var kHIDUsage_WD_ScaleStatusOverWeightLimit: Int { get }

public var kHIDUsage_WD_ScaleStatusRequiresCalibration: Int { get }

public var kHIDUsage_WD_ScaleStatusRequiresRezeroing: Int { get }

public var kHIDUsage_WD_ZeroScale: Int { get }

public var kHIDUsage_WD_EnforcedZeroReturn: Int { get }

public var kHIDUsage_MSR_Undefined: Int { get }

public var kHIDUsage_MSR_DeviceReadOnly: Int { get }

public var kHIDUsage_MSR_Track1Length: Int { get }

public var kHIDUsage_MSR_Track2Length: Int { get }

public var kHIDUsage_MSR_Track3Length: Int { get }

public var kHIDUsage_MSR_TrackJISLength: Int { get }

public var kHIDUsage_MSR_TrackData: Int { get }

public var kHIDUsage_MSR_Track1Data: Int { get }

public var kHIDUsage_MSR_Track2Data: Int { get }

public var kHIDUsage_MSR_Track3Data: Int { get }

public var kHIDUsage_MSR_TrackJISData: Int { get }

public var kHIDUsage_CC_Undefined: Int { get }

public var kHIDUsage_CC_Autofocus: Int { get }

public var kHIDUsage_CC_Shutter: Int { get }

public var kHIDUsage_FIDO_Undefined: Int { get }

public var kHIDUsage_FIDO_U2FDevice: Int { get }

public var kHIDUsage_FIDO_InputData: Int { get }

public var kHIDUsage_FIDO_OutputData: Int { get }

/**
    @function   IOHIDValueGetTypeID
    @abstract   Returns the type identifier of all IOHIDValue instances.
*/
@available(macOS 10.5, *)
public func IOHIDValueGetTypeID() -> CFTypeID

/**
    @function   IOHIDValueCreateWithIntegerValue
    @abstract   Creates a new element value using an integer value.
    @discussion IOHIDValueGetTimeStamp should represent OS AbsoluteTime, not CFAbsoluteTime.
                To obtain the OS AbsoluteTime, please reference the APIs declared in <mach/mach_time.h>
    @param      allocator The CFAllocator which should be used to allocate memory for the value.  This 
                parameter may be NULL in which case the current default CFAllocator is used. If this 
                reference is not a valid CFAllocator, the behavior is undefined.
    @param      element IOHIDElementRef associated with this value.
    @param      timeStamp OS absolute time timestamp for this value.
    @param      value Integer value to be copied to this object.
    @result     Returns a reference to a new IOHIDValueRef.
*/
@available(macOS 10.5, *)
public func IOHIDValueCreateWithIntegerValue(_ allocator: CFAllocator?, _ element: IOHIDElement, _ timeStamp: UInt64, _ value: CFIndex) -> IOHIDValue

/**
    @function   IOHIDValueCreateWithBytes
    @abstract   Creates a new element value using byte data.
    @discussion IOHIDValueGetTimeStamp should represent OS AbsoluteTime, not CFAbsoluteTime.
                To obtain the OS AbsoluteTime, please reference the APIs declared in <mach/mach_time.h>
    @param      allocator The CFAllocator which should be used to allocate memory for the value.  This 
                parameter may be NULL in which case the current default CFAllocator is used. If this 
                reference is not a valid CFAllocator, the behavior is undefined.
    @param      element IOHIDElementRef associated with this value.
    @param      timeStamp OS absolute time timestamp for this value.
    @param      bytes Pointer to a buffer of uint8_t to be copied to this object.
    @param      length Number of bytes in the passed buffer.
    @result     Returns a reference to a new IOHIDValueRef.
*/
@available(macOS 10.5, *)
public func IOHIDValueCreateWithBytes(_ allocator: CFAllocator?, _ element: IOHIDElement, _ timeStamp: UInt64, _ bytes: UnsafePointer<UInt8>, _ length: CFIndex) -> IOHIDValue?

/**
    @function   IOHIDValueCreateWithBytesNoCopy
    @abstract   Creates a new element value using byte data without performing a copy.
    @discussion The timestamp value passed should represent OS AbsoluteTime, not CFAbsoluteTime.
                To obtain the OS AbsoluteTime, please reference the APIs declared in <mach/mach_time.h>
    @param      allocator The CFAllocator which should be used to allocate memory for the value.  This 
                parameter may be NULL in which case the current default CFAllocator is used. If this 
                reference is not a valid CFAllocator, the behavior is undefined.
    @param      element IOHIDElementRef associated with this value.
    @param      timeStamp OS absolute time timestamp for this value.
    @param      bytes Pointer to a buffer of uint8_t to be referenced by this object.
    @param      length Number of bytes in the passed buffer.
    @result     Returns a reference to a new IOHIDValueRef.
*/
@available(macOS 10.5, *)
public func IOHIDValueCreateWithBytesNoCopy(_ allocator: CFAllocator?, _ element: IOHIDElement, _ timeStamp: UInt64, _ bytes: UnsafePointer<UInt8>, _ length: CFIndex) -> IOHIDValue?

/**
    @function   IOHIDValueGetElement
    @abstract   Returns the element value associated with this IOHIDValueRef.
    @param      value The value to be queried. If this parameter is not a valid IOHIDValueRef, the behavior is undefined.
    @result     Returns a IOHIDElementRef referenced by this value.
*/
@available(macOS 10.5, *)
public func IOHIDValueGetElement(_ value: IOHIDValue) -> IOHIDElement

/**
    @function   IOHIDValueGetTimeStamp
    @abstract   Returns the timestamp value contained in this IOHIDValueRef.
    @discussion The timestamp value returned represents OS AbsoluteTime, not CFAbsoluteTime.
    @param      value The value to be queried. If this parameter is not a valid IOHIDValueRef, the behavior is undefined.
    @result     Returns a uint64_t representing the timestamp of this value.
*/
@available(macOS 10.5, *)
public func IOHIDValueGetTimeStamp(_ value: IOHIDValue) -> UInt64

/**
    @function   IOHIDValueGetLength
    @abstract   Returns the size, in bytes, of the value contained in this IOHIDValueRef.
    @param      value The value to be queried. If this parameter is not a valid IOHIDValueRef, the behavior is undefined.
    @result     Returns length of the value.
*/
@available(macOS 10.5, *)
public func IOHIDValueGetLength(_ value: IOHIDValue) -> CFIndex

/**
    @function   IOHIDValueGetBytePtr
    @abstract   Returns a byte pointer to the value contained in this IOHIDValueRef.
    @param      value The value to be queried. If this parameter is not a valid IOHIDValueRef, the behavior is undefined.
    @result     Returns a pointer to the value.
*/
@available(macOS 10.5, *)
public func IOHIDValueGetBytePtr(_ value: IOHIDValue) -> UnsafePointer<UInt8>

/**
    @function   IOHIDValueGetIntegerValue
    @abstract   Returns an integer representaion of the value contained in this IOHIDValueRef.
    @discussion The value is based on the logical element value contained in the report returned by the device.
    @param      value The value to be queried. If this parameter is not a valid IOHIDValueRef, the behavior is undefined.
    @result     Returns an integer representation of the value.
*/
@available(macOS 10.5, *)
public func IOHIDValueGetIntegerValue(_ value: IOHIDValue) -> CFIndex

/**
    @function   IOHIDValueGetScaledValue
    @abstract   Returns an scaled representaion of the value contained in this IOHIDValueRef based on the scale type.
    @discussion The scaled value is based on the range described by the scale type's min and max, such that:
        <br>
        scaledValue = ((value - min) * (scaledMax - scaledMin) / (max - min)) + scaledMin
        <br>
        <b>Note:</b>
        <br>
        There are currently two types of scaling that can be applied:  
        <ul>
        <li><b>kIOHIDValueScaleTypePhysical</b>: Scales element value using the physical bounds of the device such that <b>scaledMin = physicalMin</b> and <b>scaledMax = physicalMax</b>.
        <li><b>kIOHIDValueScaleTypeCalibrated</b>: Scales element value such that <b>scaledMin = -1</b> and <b>scaledMax = 1</b>.  This value will also take into account the calibration properties associated with this element.
        </ul>
    @param      value The value to be queried. If this parameter is not a valid IOHIDValueRef, the behavior is undefined.
    @param      type The type of scaling to be performed.
    @result     Returns an scaled floating point representation of the value.
*/
@available(macOS 10.5, *)
public func IOHIDValueGetScaledValue(_ value: IOHIDValue, _ type: IOHIDValueScaleType) -> double_t

/**
 @enum      IOHIDTransactionOptions
 @abstract  Various options that can be supplied to IOHIDTransaction functions.
 @const     kIOHIDTransactionOptionsNone For those times when supplying 0 just isn't
            explicit enough.
 @const     kIOHIDTransactionOptionsWeakDevice specifies the transaction to not retain the
            IOHIDDeviceRef being passed in. The expectation is that transaction will only exist during
            the lifetime of the IOHIDDeviceRef object.
 */
public struct IOHIDTransactionOptions : OptionSet, @unchecked Sendable {

    public init(rawValue: UInt32)

    public static var weakDevice: IOHIDTransactionOptions { get }
}

/** @typedef IOHIDTransactionRef
    This is the type of a reference to the IOHIDTransaction.
*/
public class IOHIDTransaction : Hashable {
}

/**
    @function   IOHIDTransactionGetTypeID
    @abstract   Returns the type identifier of all IOHIDTransaction instances.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionGetTypeID() -> CFTypeID

/**
    @function   IOHIDTransactionCreate
    @abstract   Creates an IOHIDTransaction object for the specified device.
    @discussion IOHIDTransaction objects can be used to either send or receive
                multiple element values.  As such the direction used should 
                represent they type of objects added to the transaction.
    @param      allocator Allocator to be used during creation.
    @param      device IOHIDDevice object 
    @param      direction The direction, either in or out, for the transaction.
    @param      options Reserved for future use.
    @result     Returns a new IOHIDTransactionRef.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionCreate(_ allocator: CFAllocator?, _ device: IOHIDDevice, _ direction: IOHIDTransactionDirectionType, _ options: IOOptionBits) -> IOHIDTransaction?

/**
    @function   IOHIDTransactionGetDevice
    @abstract   Obtain the device associated with the transaction.
    @param      transaction IOHIDTransaction to be queried. 
    @result     Returns the a reference to the device.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionGetDevice(_ transaction: IOHIDTransaction) -> IOHIDDevice

/**
    @function   IOHIDTransactionGetDirection
    @abstract   Obtain the direction of the transaction.
    @param      transaction IOHIDTransaction to be queried. 
    @result     Returns the transaction direction.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionGetDirection(_ transaction: IOHIDTransaction) -> IOHIDTransactionDirectionType

/**
    @function   IOHIDTransactionSetDirection
    @abstract   Sets the direction of the transaction
    @disussion  This method is useful for manipulating bi-direction (feature) 
                elements such that you can set or get element values without
                creating an additional transaction object.
    @param      transaction IOHIDTransaction object to be modified.
    @param      direction The new transaction direction.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionSetDirection(_ transaction: IOHIDTransaction, _ direction: IOHIDTransactionDirectionType)

/**
    @function   IOHIDTransactionAddElement
    @abstract   Adds an element to the transaction
    @disussion  To minimize device traffic it is important to add elements that
                share a common report type and report id.
    @param      transaction IOHIDTransaction object to be modified.
    @param      element Element to be added to the transaction.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionAddElement(_ transaction: IOHIDTransaction, _ element: IOHIDElement)

/**
    @function   IOHIDTransactionRemoveElement
    @abstract   Removes an element to the transaction
    @param      transaction IOHIDTransaction object to be modified.
    @param      element Element to be removed to the transaction.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionRemoveElement(_ transaction: IOHIDTransaction, _ element: IOHIDElement)

/**
    @function   IOHIDTransactionContainsElement
    @abstract   Queries the transaction to determine if elemement has been added.
    @param      transaction IOHIDTransaction object to be queried.
    @param      element Element to be queried.
    @result     Returns true or false depending if element is present.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionContainsElement(_ transaction: IOHIDTransaction, _ element: IOHIDElement) -> Bool

/**
    @function   IOHIDTransactionScheduleWithRunLoop
    @abstract   Schedules transaction with run loop.
    @discussion Formally associates transaction with client's run loop. 
                Scheduling this transaction with the run loop is necessary 
                before making use of any asynchronous APIs.
    @param      transaction IOHIDTransaction object to be modified.
    @param      runLoop RunLoop to be used when scheduling any asynchronous 
                activity.
    @param      runLoopMode Run loop mode to be used when scheduling any 
                asynchronous activity.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionScheduleWithRunLoop(_ transaction: IOHIDTransaction, _ runLoop: CFRunLoop, _ runLoopMode: CFString)

/**
    @function   IOHIDTransactionUnscheduleFromRunLoop
    @abstract   Unschedules transaction with run loop.
    @discussion Formally disassociates transaction with client's run loop.
    @param      transaction IOHIDTransaction object to be modified.
    @param      runLoop RunLoop to be used when scheduling any asynchronous 
                activity.
    @param      runLoopMode Run loop mode to be used when scheduling any 
                asynchronous activity.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionUnscheduleFromRunLoop(_ transaction: IOHIDTransaction, _ runLoop: CFRunLoop, _ runLoopMode: CFString)

/**
    @function   IOHIDTransactionSetValue
    @abstract   Sets the value for a transaction element.
    @discussion The value set is pended until the transaction is committed and
                is only used if the transaction direction is 
                kIOHIDTransactionDirectionTypeOutput.  Use the 
                kIOHIDTransactionOptionDefaultOutputValue option to set the 
                default element value.
    @param      transaction IOHIDTransaction object to be modified.
    @param      element Element to be modified after a commit.
    @param      value Value to be set for the given element.
    @param      options See IOHIDTransactionOption.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionSetValue(_ transaction: IOHIDTransaction, _ element: IOHIDElement, _ value: IOHIDValue, _ options: IOOptionBits)

/**
    @function   IOHIDTransactionGetValue
    @abstract   Obtains the value for a transaction element.
    @discussion If the transaction direction is 
                kIOHIDTransactionDirectionTypeInput the value represents what
                was obtained from the device from the transaction.  Otherwise, 
                if the transaction direction is 
                kIOHIDTransactionDirectionTypeOutput the value represents the 
                pending value to be sent to the device.  Use the 
                kIOHIDTransactionOptionDefaultOutputValue option to get the 
                default element value.
    @param      transaction IOHIDTransaction object to be queried.
    @param      element Element to be queried.
    @param      options See IOHIDTransactionOption.
    @result     Returns IOHIDValueRef for the given element.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionGetValue(_ transaction: IOHIDTransaction, _ element: IOHIDElement, _ options: IOOptionBits) -> IOHIDValue?

/**
    @function   IOHIDTransactionCommit
    @abstract   Synchronously commits element transaction to the device.
    @param      transaction IOHIDTransaction object to be modified.
    @result     Returns kIOReturnSuccess if successful or a kern_return_t if 
                unsuccessful.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionCommit(_ transaction: IOHIDTransaction) -> IOReturn

/**
    @function   IOHIDTransactionCommitWithCallback
    @abstract   Asynchronously commits element transaction to the device.
    @discussion It is possible for elements from different reports
                to be present in a given transaction causing a commit to
                transcend multiple reports. Keep this in mind when setting a 
                appropriate timeout.
    @param      transaction IOHIDTransaction object to be modified.
    @param      timeout Timeout in milliseconds for the transaction.
    @param      callback Callback of type IOHIDCallback to be used when 
                transaction has been completed.  If null, this method will 
                behave synchronously.
    @param      context Pointer to data to be passed to the callback.
    @result     Returns kIOReturnSuccess if successful or a kern_return_t if 
                unsuccessful.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionCommitWithCallback(_ transaction: IOHIDTransaction, _ timeout: CFTimeInterval, _ callback: IOHIDCallback?, _ context: UnsafeMutableRawPointer?) -> IOReturn

/** 
    @function   IOHIDTransactionClear
    @abstract   Clears element transaction values.
    @discussion In regards to kIOHIDTransactionDirectionTypeOutput direction, 
                default element values will be preserved.
    @param      transaction IOHIDTransaction object to be modified.
*/
@available(macOS 10.5, *)
public func IOHIDTransactionClear(_ transaction: IOHIDTransaction)

/** @interface  IOHIDDeviceDeviceInterface
    @abstract   The object you use to access HID devices from user space, returned by version 1.5 of the IOHIDFamily.
    @discussion The functions listed here will work with any version of the IOHIDDeviceDeviceInterface. 
    
    <b>Note:</b> Please note that methods declared in this interface follow the copy/get/set conventions.
*/
public struct IOHIDDeviceDeviceInterface {

    public init()

    public init(_reserved: UnsafeMutableRawPointer!, QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!, AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, open: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, close: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, getProperty: (@convention(c) (UnsafeMutableRawPointer?, CFString?, UnsafeMutablePointer<Unmanaged<CFTypeRef>?>?) -> IOReturn)!, setProperty: (@convention(c) (UnsafeMutableRawPointer?, CFString?, CFTypeRef?) -> IOReturn)!, getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFTypeRef>?>?) -> IOReturn)!, copyMatchingElements: (@convention(c) (UnsafeMutableRawPointer?, CFDictionary?, UnsafeMutablePointer<Unmanaged<CFArray>?>?, IOOptionBits) -> IOReturn)!, setValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOHIDValue?, UInt32, IOHIDValueCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, getValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, UnsafeMutablePointer<Unmanaged<IOHIDValue>?>?, UInt32, IOHIDValueCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, setInputReportCallback: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt8>?, CFIndex, IOHIDReportCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, setReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafePointer<UInt8>?, CFIndex, UInt32, IOHIDReportCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, getReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutablePointer<UInt8>?, UnsafeMutablePointer<CFIndex>?, UInt32, IOHIDReportCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!)

    public var _reserved: UnsafeMutableRawPointer!

    public var QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!

    public var AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var open: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var close: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var getProperty: (@convention(c) (UnsafeMutableRawPointer?, CFString?, UnsafeMutablePointer<Unmanaged<CFTypeRef>?>?) -> IOReturn)!

    public var setProperty: (@convention(c) (UnsafeMutableRawPointer?, CFString?, CFTypeRef?) -> IOReturn)!

    public var getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFTypeRef>?>?) -> IOReturn)!

    public var copyMatchingElements: (@convention(c) (UnsafeMutableRawPointer?, CFDictionary?, UnsafeMutablePointer<Unmanaged<CFArray>?>?, IOOptionBits) -> IOReturn)!

    public var setValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOHIDValue?, UInt32, IOHIDValueCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var getValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, UnsafeMutablePointer<Unmanaged<IOHIDValue>?>?, UInt32, IOHIDValueCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var setInputReportCallback: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt8>?, CFIndex, IOHIDReportCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var setReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafePointer<UInt8>?, CFIndex, UInt32, IOHIDReportCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var getReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutablePointer<UInt8>?, UnsafeMutablePointer<CFIndex>?, UInt32, IOHIDReportCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!
}

/** @interface  IOHIDDeviceTimeStampedDeviceInterface
    @abstract   The object you use to access HID devices from user space, returned by version 2.1 of the IOHIDFamily.
    @discussion The functions listed here include all of the functions from the IOHIDDeviceDeviceInterface.
    
    <b>Note:</b> Please note that methods declared in this interface follow the copy/get/set conventions.
*/
public struct IOHIDDeviceTimeStampedDeviceInterface {

    public init()

    public init(_reserved: UnsafeMutableRawPointer!, QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!, AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, open: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, close: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, getProperty: (@convention(c) (UnsafeMutableRawPointer?, CFString?, UnsafeMutablePointer<Unmanaged<CFTypeRef>?>?) -> IOReturn)!, setProperty: (@convention(c) (UnsafeMutableRawPointer?, CFString?, CFTypeRef?) -> IOReturn)!, getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFTypeRef>?>?) -> IOReturn)!, copyMatchingElements: (@convention(c) (UnsafeMutableRawPointer?, CFDictionary?, UnsafeMutablePointer<Unmanaged<CFArray>?>?, IOOptionBits) -> IOReturn)!, setValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOHIDValue?, UInt32, IOHIDValueCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, getValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, UnsafeMutablePointer<Unmanaged<IOHIDValue>?>?, UInt32, IOHIDValueCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, setInputReportCallback: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt8>?, CFIndex, IOHIDReportCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, setReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafePointer<UInt8>?, CFIndex, UInt32, IOHIDReportCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, getReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutablePointer<UInt8>?, UnsafeMutablePointer<CFIndex>?, UInt32, IOHIDReportCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, setInputReportWithTimeStampCallback: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt8>?, CFIndex, IOHIDReportWithTimeStampCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!)

    public var _reserved: UnsafeMutableRawPointer!

    public var QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!

    public var AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var open: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var close: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var getProperty: (@convention(c) (UnsafeMutableRawPointer?, CFString?, UnsafeMutablePointer<Unmanaged<CFTypeRef>?>?) -> IOReturn)!

    public var setProperty: (@convention(c) (UnsafeMutableRawPointer?, CFString?, CFTypeRef?) -> IOReturn)!

    public var getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFTypeRef>?>?) -> IOReturn)!

    public var copyMatchingElements: (@convention(c) (UnsafeMutableRawPointer?, CFDictionary?, UnsafeMutablePointer<Unmanaged<CFArray>?>?, IOOptionBits) -> IOReturn)!

    public var setValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOHIDValue?, UInt32, IOHIDValueCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var getValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, UnsafeMutablePointer<Unmanaged<IOHIDValue>?>?, UInt32, IOHIDValueCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var setInputReportCallback: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt8>?, CFIndex, IOHIDReportCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var setReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafePointer<UInt8>?, CFIndex, UInt32, IOHIDReportCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var getReport: (@convention(c) (UnsafeMutableRawPointer?, IOHIDReportType, UInt32, UnsafeMutablePointer<UInt8>?, UnsafeMutablePointer<CFIndex>?, UInt32, IOHIDReportCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    public var setInputReportWithTimeStampCallback: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt8>?, CFIndex, IOHIDReportWithTimeStampCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!
}

/**
    @interface  IOHIDDeviceQueueInterface
    @abstract   The object you use to access a HID queue from user space, returned by version 1.5 of the IOHIDFamily.
    @discussion The functions listed here will work with any version of the IOHIDDeviceQueueInterface.  This behavior is useful when you 
                need to keep track of all values of an input element, rather than just the most recent one.
                <br>
                <b>Note:</b>Absolute element values (based on a fixed origin) will only be placed on a queue if there is a change in value. 
*/
public struct IOHIDDeviceQueueInterface {

    public init()

    public init(_reserved: UnsafeMutableRawPointer!, QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!, AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFTypeRef>?>?) -> IOReturn)!, setDepth: (@convention(c) (UnsafeMutableRawPointer?, UInt32, IOOptionBits) -> IOReturn)!, getDepth: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt32>?) -> IOReturn)!, addElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOOptionBits) -> IOReturn)!, removeElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOOptionBits) -> IOReturn)!, containsElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, UnsafeMutablePointer<DarwinBoolean>?, IOOptionBits) -> IOReturn)!, start: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, stop: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, setValueAvailableCallback: (@convention(c) (UnsafeMutableRawPointer?, IOHIDCallback?, UnsafeMutableRawPointer?) -> IOReturn)!, copyNextValue: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<IOHIDValue>?>?, UInt32, IOOptionBits) -> IOReturn)!)

    public var _reserved: UnsafeMutableRawPointer!

    public var QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!

    public var AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    /** @function   getAsyncEventSource
        @abstract   Obtains the event source for this IOHIDDeviceQueueInterface instance.
        @discussion The returned event source can be of type CFRunLoopSourceRef or CFRunLoopTimerRef.
        @param      self Pointer to the IOHIDDeviceQueueInterface.
        @param      pSource Pointer to a CFType to return the run loop event source.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFTypeRef>?>?) -> IOReturn)!

    /** @function   setDepth
        @abstract   Sets the depth for this IOHIDDeviceQueueInterface instance.
        @discussion Regardless of element value size, queue will guarantee n=depth elements will be serviced.
        @param      self Pointer to the IOHIDDeviceTransactionInterface.
        @param      depth The maximum number of elements in the queue before the oldest elements in the queue begin to be lost.
        @param      options Reserved for future use. Ignored in current implementation. Set to zero.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var setDepth: (@convention(c) (UnsafeMutableRawPointer?, UInt32, IOOptionBits) -> IOReturn)!

    /** @function   getDepth
        @abstract   Obtains the queue depth for this IOHIDDeviceQueueInterface instance.
        @param      self Pointer to the IOHIDDeviceQueueInterface.
        @param      pDepth Pointer to a uint32_t to obtain the number of elements that can be serviced by the queue.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var getDepth: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<UInt32>?) -> IOReturn)!

    /** @function   addElement
        @abstract   Adds an element to this IOHIDDeviceQueueInterface instance.
        @param      self Pointer to the IOHIDDeviceQueueInterface.
        @param      element IOHIDElementRef referencing the element to be added to the queue.
        @param      options Reserved for future use. Ignored in current implementation. Set to zero.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var addElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOOptionBits) -> IOReturn)!

    /** @function   removeElement
        @abstract   Removes an element from this IOHIDDeviceQueueInterface instance.
        @param      self Pointer to the IOHIDDeviceQueueInterface.
        @param      element IOHIDElementRef referencing the element to be removed from the queue.
        @param      options Reserved for future use. Ignored in current implementation. Set to zero.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var removeElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOOptionBits) -> IOReturn)!

    /** @function   containsElement
        @abstract   Determines whether an element has been added to this IOHIDDeviceQueueInterface instance.
        @param      self Pointer to the IOHIDDeviceQueueInterface.
        @param      element IOHIDElementRef referencing the element to be be found in the queue.
        @param      pValue Pointer to a Boolean to return whether or not the element was found in the queue.
        @param      options Reserved for future use. Ignored in current implementation. Set to zero.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var containsElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, UnsafeMutablePointer<DarwinBoolean>?, IOOptionBits) -> IOReturn)!

    /** @function   start
        @abstract   Starts element value delivery to the queue.
        @param      self Pointer to the IOHIDDeviceQueueInterface.
        @param      options Reserved for future use. Ignored in current implementation. Set to zero.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var start: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    /** @function   stop
        @abstract   Stops element value delivery to the queue.
        @param      self Pointer to the IOHIDDeviceQueueInterface.
        @param      options Reserved for future use. Ignored in current implementation. Set to zero.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var stop: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    /** @function   setValueAvailableCallback
        @abstract   Sets callback to be used when the queue transitions to non-empty.
        @discussion In order to make use of asynchronous behavior, the event source obtained using getAsyncEventSource
                    must be added to a run loop. 
        @param      self Pointer to the IOHIDDeviceQueueInterface.
        @param      callback Callback of type IOHIDCallback to be used when data is placed on the queue.
        @param      context Pointer to data to be passed to the callback.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var setValueAvailableCallback: (@convention(c) (UnsafeMutableRawPointer?, IOHIDCallback?, UnsafeMutableRawPointer?) -> IOReturn)!

    /** @function   copyNextValue
        @abstract   Dequeues a retained copy of an element value from the head of an IOHIDDeviceQueueInterface.
        @discussion Because the value is a retained copy, it is up to the caller to release the value using CFRelease. 
                    Use with setValueCallback to avoid polling the queue for data.
        @param      self Pointer to the IOHIDDeviceQueueInterface.
        @param      pValue Pointer to a IOHIDValueRef to return the value at the head of the queue.
        @param      timeout Timeout in milliseconds before aborting an attempt to dequeue a value from the head of a queue.
        @param      options Reserved for future use. Ignored in current implementation. Set to zero.
        @result     Returns kIOReturnSuccess if successful, kIOReturnUnderrun if data is unavailble, or a kern_return_t if unsuccessful.
    */
    public var copyNextValue: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<IOHIDValue>?>?, UInt32, IOOptionBits) -> IOReturn)!
}

/**
    @interface  IOHIDDeviceTransactionInterface
    @abstract   The object you use to access a HID transaction from user space, returned by version 1.5 of the IOHIDFamily.
    @discussion The functions listed here will work with any version of the IOHIDDeviceTransactionInterface. This functionality
                is useful when either setting or getting the values for multiple parsed elements.
*/
public struct IOHIDDeviceTransactionInterface {

    public init()

    public init(_reserved: UnsafeMutableRawPointer!, QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!, AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFTypeRef>?>?) -> IOReturn)!, setDirection: (@convention(c) (UnsafeMutableRawPointer?, IOHIDTransactionDirectionType, IOOptionBits) -> IOReturn)!, getDirection: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<IOHIDTransactionDirectionType>?) -> IOReturn)!, addElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOOptionBits) -> IOReturn)!, removeElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOOptionBits) -> IOReturn)!, containsElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, UnsafeMutablePointer<DarwinBoolean>?, IOOptionBits) -> IOReturn)!, setValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOHIDValue?, IOOptionBits) -> IOReturn)!, getValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, UnsafeMutablePointer<Unmanaged<IOHIDValue>?>?, IOOptionBits) -> IOReturn)!, commit: (@convention(c) (UnsafeMutableRawPointer?, UInt32, IOHIDCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!, clear: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!)

    public var _reserved: UnsafeMutableRawPointer!

    public var QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!

    public var AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    /** @function   getAsyncEventSource
        @abstract   Obtains the event source for this IOHIDDeviceTransactionInterface instance.
        @discussion The returned event source can be of type CFRunLoopSourceRef or CFRunLoopTimerRef.
        @param      self Pointer to the IOHIDDeviceTransactionInterface.
        @param      pSource Pointer to a CFType to return the run loop event source.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var getAsyncEventSource: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<Unmanaged<CFTypeRef>?>?) -> IOReturn)!

    /** @function   setDirection
        @abstract   Sets the direction for this IOHIDDeviceTransactionInterface instance.
        @discussion Direction constants are declared in IOHIDTransactionDirectionType.  Changing directions
                    is useful when dealing with elements of type kIOHIDElementTypeFeature as you use the
                    transaction to both set and get element values.
        @param      self Pointer to the IOHIDDeviceTransactionInterface.
        @param      direction Transaction direction of type IOHIDTransactionDirectionType.
        @param      options Reserved for future use. Ignored in current implementation. Set to zero.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var setDirection: (@convention(c) (UnsafeMutableRawPointer?, IOHIDTransactionDirectionType, IOOptionBits) -> IOReturn)!

    /** @function   getDirection
        @abstract   Obtains the direction for this IOHIDDeviceTransactionInterface instance.
        @discussion Direction constants are declared in IOHIDTransactionDirectionType.
        @param      self Pointer to the IOHIDDeviceTransactionInterface.
        @param      pDirection Pointer to a IOHIDTransactionDirectionType to obtain transaction direction.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var getDirection: (@convention(c) (UnsafeMutableRawPointer?, UnsafeMutablePointer<IOHIDTransactionDirectionType>?) -> IOReturn)!

    /** @function   addElement
        @abstract   Adds an element to this IOHIDDeviceTransactionInterface instance.
        @param      self Pointer to the IOHIDDeviceTransactionInterface.
        @param      element IOHIDElementRef referencing the element to be added to the transaction.
        @param      options Reserved for future use. Ignored in current implementation. Set to zero.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var addElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOOptionBits) -> IOReturn)!

    /** @function   removeElement
        @abstract   Removes an element from this IOHIDDeviceTransactionInterface instance.
        @param      self Pointer to the IOHIDDeviceTransactionInterface.
        @param      element IOHIDElementRef referencing the element to be removed from the transaction.
        @param      options Reserved for future use. Ignored in current implementation. Set to zero.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var removeElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOOptionBits) -> IOReturn)!

    /** @function   containsElement
        @abstract   Checks whether an element has been added to this IOHIDDeviceTransactionInterface instance.
        @param      self Pointer to the IOHIDDeviceTransactionInterface.
        @param      element IOHIDElementRef referencing the element to be be found in the transaction.
        @param      pValue Pointer to a Boolean to return whether or not the element was found in the transaction.
        @param      options Reserved for future use. Ignored in current implementation. Set to zero.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var containsElement: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, UnsafeMutablePointer<DarwinBoolean>?, IOOptionBits) -> IOReturn)!

    /** @function   setValue
        @abstract   Sets the transaction value for an element in this IOHIDDeviceTransactionInterface instance.
        @discussion This method is intended for use with transaction of direction kIOHIDTransactionDirectionTypeOutput.
                    Use the kIOHIDTransactionOptionDefaultOutputValue option to set the default element value.
        @param      self Pointer to the IOHIDDeviceTransactionInterface.
        @param      element IOHIDElementRef referencing the element of interest.
        @param      value IOHIDValueRef referencing element value to be used in the transaction.
        @param      options See IOHIDTransactionOption.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var setValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, IOHIDValue?, IOOptionBits) -> IOReturn)!

    /** @function   getValue
        @abstract   Obtains the transaction value for an element in this IOHIDDeviceTransactionInterface instance.
        @discussion Use the kIOHIDTransactionOptionDefaultOutputValue option to get the default element value.
        @param      self Pointer to the IOHIDDeviceTransactionInterface.
        @param      element IOHIDElementRef referencing the element of interest.
        @param      pValue Pointer to an IOHIDValueRef to return the element value of the transaction.
        @param      options See IOHIDTransactionOption.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var getValue: (@convention(c) (UnsafeMutableRawPointer?, IOHIDElement?, UnsafeMutablePointer<Unmanaged<IOHIDValue>?>?, IOOptionBits) -> IOReturn)!

    /** @function   commit
        @abstract   Commits element transaction to an IOHIDDevice in this IOHIDDeviceTransactionInterface instance.
        @discussion In regards to kIOHIDTransactionDirectionTypeOutput direction, default element values will be used if
                    element values are not set.  If neither are set, that element will be omitted from the commit. After 
                    a transaction is committed, transaction element values will be cleared and default values preserved.
                    <br>
                    <b>Note:</b> It is possible for elements from different reports to be present in a given transaction 
                    causing a commit to transcend multiple reports. Keep this in mind when setting a timeout.
        @param      self Pointer to the IOHIDDeviceTransactionInterface.
        @param      timeout Timeout in milliseconds for issuing the transaction.
        @param      callback Callback of type IOHIDCallback to be used when transaction has been completed.  If null, 
                    this method will behave synchronously.
        @param      context Pointer to data to be passed to the callback.
        @param      options Reserved for future use. Ignored in current implementation. Set to zero.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var commit: (@convention(c) (UnsafeMutableRawPointer?, UInt32, IOHIDCallback?, UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!

    /** @function   clear
        @abstract   Clears element transaction values for an IOHIDDeviceTransactionInterface.
        @discussion In regards to kIOHIDTransactionDirectionTypeOutput direction, default element values will be preserved.
        @param      self Pointer to the IOHIDDeviceTransactionInterface.
        @param      options Reserved for future use. Ignored in current implementation. Set to zero.
        @result     Returns kIOReturnSuccess if successful or a kern_return_t if unsuccessful.
    */
    public var clear: (@convention(c) (UnsafeMutableRawPointer?, IOOptionBits) -> IOReturn)!
}

/**
 * @typedef IOHIDKeyboardEventOptions
 *
 * @abstract
 * Keyboard event options passed in to dispatchKeyboardEvent function in
 * IOHIDEventService.
 *
 * @field kIOHIDKeyboardEventOptionsNoKeyRepeat
 * Default behavior for keyboard events is to repeat keys if the key has been
 * held down for a certain amount of time defined in system preferences. Pass
 * in this option to not apply key repeat logic to this event.
 */
public struct IOHIDKeyboardEventOptions : Hashable, Equatable, RawRepresentable {

    public init(_ rawValue: UInt32)

    public init(rawValue: UInt32)

    public var rawValue: UInt32
}

public var kIOHIDKeyboardEventOptionsNoKeyRepeat: IOHIDKeyboardEventOptions { get }

/**
 * @typedef IOHIDPointerEventOptions
 *
 * @abstract
 * Pointer event options passed in to dispatch(Relative/Absolute)PointerEvent
 * function in IOHIDEventService.
 *
 * @field kIOHIDPointerEventOptionsNoAcceleration
 * Pointer events are subject to an acceleration algorithm. Pass in this option
 * if you do not wish to have acceleration logic applied to the pointer event.
 */
public struct IOHIDPointerEventOptions : Hashable, Equatable, RawRepresentable {

    public init(_ rawValue: UInt32)

    public init(rawValue: UInt32)

    public var rawValue: UInt32
}

public var kIOHIDPointerEventOptionsNoAcceleration: IOHIDPointerEventOptions { get }

/**
 * @typedef IOHIDScrollEventOptions
 *
 * @abstract
 * Scroll event options passed in to dispatchScrollEvent function in
 * IOHIDEventService.
 *
 * @field kIOHIDScrollEventOptionsNoAcceleration
 * Scroll events are subject to an acceleration algorithm. Pass in this option
 * if you do not wish to have acceleration logic applied to the scroll event.
 */
public struct IOHIDScrollEventOptions : Hashable, Equatable, RawRepresentable {

    public init(_ rawValue: UInt32)

    public init(rawValue: UInt32)

    public var rawValue: UInt32
}

public var kIOHIDScrollEventOptionsNoAcceleration: IOHIDScrollEventOptions { get }

/**
    @enum IOHIDServiceSensorControlOptions
    @abstract List of control options  for sensor controls in HID event system
    @discussion Options define behavior of HID event system for handling kIOHIDServiceReportIntervalKey & kIOHIDServiceBatchIntervalKey and associated event dispatch to kIOHIDEventSystemClientTypeRateControlled clients
    @constant kIOHIDServiceSensorControlDecimation  decimate events for kIOHIDEventSystemClientTypeRateControlled clients.
    @constant kIOHIDServiceSensorControlAggregation aggregate all requests associated with kIOHIDServiceReportIntervalKey & kIOHIDServiceBatchIntervalKey properties
    @constant kIOHIDServiceSensorControlDispatchControl disable event dispatch for kIOHIDEventSystemClientTypeRateControlled clients if  kIOHIDServiceReportIntervalKey not requested by client
 */
public struct IOHIDServiceSensorControlOptions : Hashable, Equatable, RawRepresentable {

    public init(_ rawValue: UInt32)

    public init(rawValue: UInt32)

    public var rawValue: UInt32
}

public var kIOHIDServiceSensorControlDecimation: IOHIDServiceSensorControlOptions { get }

public var kIOHIDServiceSensorControlAggregation: IOHIDServiceSensorControlOptions { get }

public var kIOHIDServiceSensorControlDispatchControl: IOHIDServiceSensorControlOptions { get }


