here is documentation from import IOKit


import CoreFoundation
import Dispatch
import IOKit.audio
import IOKit.avc
import IOKit.firewire
import IOKit.graphics
import IOKit.hid
import IOKit.hidsystem
import IOKit.i2c
import IOKit.kext
import IOKit.network
import IOKit.ps
import IOKit.pwr_mgt
import IOKit.sbp2
import IOKit.scsi
import IOKit.serial
import IOKit.storage
import IOKit.stream
import IOKit.usb
import IOKit.video
import _Builtin_stdbool
import _Builtin_stdint

public typealias IOReturn = kern_return_t

public var kIOReturnSuccess: Int32 { get }

public var kIODefaultMemoryType: Int { get }

public var kIODefaultCache: Int { get }

public var kIOInhibitCache: Int { get }

public var kIOWriteThruCache: Int { get }

public var kIOCopybackCache: Int { get }

public var kIOWriteCombineCache: Int { get }

public var kIOCopybackInnerCache: Int { get }

public var kIOPostedWrite: Int { get }

public var kIORealTimeCache: Int { get }

public var kIOPostedReordered: Int { get }

public var kIOPostedCombinedReordered: Int { get }

public var kIOMapAnywhere: UInt32 { get }

public var kIOMapCacheMask: UInt32 { get }

public var kIOMapCacheShift: UInt32 { get }

public var kIOMapDefaultCache: UInt32 { get }

public var kIOMapInhibitCache: UInt32 { get }

public var kIOMapWriteThruCache: UInt32 { get }

public var kIOMapCopybackCache: UInt32 { get }

public var kIOMapWriteCombineCache: UInt32 { get }

public var kIOMapCopybackInnerCache: UInt32 { get }

public var kIOMapPostedWrite: UInt32 { get }

public var kIOMapRealTimeCache: UInt32 { get }

public var kIOMapPostedReordered: UInt32 { get }

public var kIOMapPostedCombinedReordered: UInt32 { get }

public var kIOMapUserOptionsMask: UInt32 { get }

public var kIOMapReadOnly: UInt32 { get }

public var kIOMapStatic: UInt32 { get }

public var kIOMapReference: UInt32 { get }

public var kIOMapUnique: UInt32 { get }

public var kIOMapPrefault: UInt32 { get }

public var kIOMapOverwrite: UInt32 { get }

public var kIOMapGuardedMask: UInt32 { get }

public var kIOMapGuardedSmall: UInt32 { get }

public var kIOMapGuardedLarge: UInt32 { get }

public var IOKIT: Int32 { get }

public typealias IOOptionBits = UInt32

public typealias IOFixed = Int32

public typealias IOVersion = UInt32

public typealias IOItemCount = UInt32

public typealias IOCacheMode = UInt32

public typealias IOByteCount32 = UInt32

public typealias IOByteCount64 = UInt64

public typealias IOPhysicalAddress32 = UInt32

public typealias IOPhysicalAddress64 = UInt64

public typealias IOPhysicalLength32 = UInt32

public typealias IOPhysicalLength64 = UInt64

public typealias IOVirtualAddress = mach_vm_address_t

public typealias IOByteCount = IOByteCount64

public typealias IOLogicalAddress = IOVirtualAddress

public typealias IOPhysicalAddress = IOPhysicalAddress64

public typealias IOPhysicalLength = IOPhysicalLength64

public var IOPhysSize: Int32 { get }

public struct IOPhysicalRange {

    public init()

    public init(address: IOPhysicalAddress, length: IOByteCount)

    public var address: IOPhysicalAddress

    public var length: IOByteCount
}

public struct IOVirtualRange {

    public init()

    public init(address: IOVirtualAddress, length: IOByteCount)

    public var address: IOVirtualAddress

    public var length: IOByteCount
}

public typealias IOAddressRange = IOVirtualRange

public struct IONamedValue {

    public init()

    public init(value: Int32, name: UnsafePointer<CChar>!)

    public var value: Int32

    public var name: UnsafePointer<CChar>!
}

public typealias IOAlignment = UInt32

public typealias io_object_t = mach_port_t

public typealias io_connect_t = io_object_t

public typealias io_enumerator_t = io_object_t

public typealias io_ident_t = io_object_t

public typealias io_iterator_t = io_object_t

public typealias io_registry_entry_t = io_object_t

public typealias io_service_t = io_object_t

public typealias uext_object_t = io_object_t

public var IO_OBJECT_NULL: io_object_t { get }

public var kNanosecondScale: Int { get }

public var kMicrosecondScale: Int { get }

public var kMillisecondScale: Int { get }

public var kSecondScale: Int { get }

public var kTickScale: Int { get }

public var kIOConnectMethodVarOutputSize: Int { get }

public typealias IODeviceNumber = UInt32

public var kIOMaxBusStall40usec: Int { get }

public var kIOMaxBusStall30usec: Int { get }

public var kIOMaxBusStall25usec: Int { get }

public var kIOMaxBusStall20usec: Int { get }

public var kIOMaxBusStall10usec: Int { get }

public var kIOMaxBusStall5usec: Int { get }

public var kIOMaxBusStallNone: Int { get }

public var kIOKitBuildVersionKey: String { get }

public var kIOKitDiagnosticsKey: String { get }

public var kIORegistryPlanesKey: String { get }

public var kIOCatalogueKey: String { get }

public var kIOServicePlane: String { get }

public var kIOPowerPlane: String { get }

public var kIODeviceTreePlane: String { get }

public var kIOAudioPlane: String { get }

public var kIOFireWirePlane: String { get }

public var kIOUSBPlane: String { get }

public var kIORegistryEntryIDKey: String { get }

public var kIORegistryEntryPropertyKeysKey: String { get }

public var kIORegistryEntryAllowableSetPropertiesKey: String { get }

public var kIORegistryEntryDefaultLockingSetPropertiesKey: String { get }

public var kIOServiceClass: String { get }

public var kIOResourcesClass: String { get }

public var kIOClassKey: String { get }

public var kIOProbeScoreKey: String { get }

public var kIOKitDebugKey: String { get }

public var kIOUserClassKey: String { get }

public var kIOUserClassesKey: String { get }

public var kIOSupportedPropertiesKey: String { get }

public var kIOUserServicePropertiesKey: String { get }

public var kIOProviderClassKey: String { get }

public var kIONameMatchKey: String { get }

public var kIOPropertyMatchKey: String { get }

public var kIOPropertyExistsMatchKey: String { get }

public var kIOPathMatchKey: String { get }

public var kIOLocationMatchKey: String { get }

public var kIOParentMatchKey: String { get }

public var kIOResourceMatchKey: String { get }

public var kIOResourceMatchedKey: String { get }

public var kIOMatchedServiceCountKey: String { get }

public var kIONameMatchedKey: String { get }

public var kIOMatchCategoryKey: String { get }

public var kIODefaultMatchCategoryKey: String { get }

public var kIOMatchedPersonalityKey: String { get }

public var kIORematchPersonalityKey: String { get }

public var kIORematchCountKey: String { get }

public var kIODEXTMatchCountKey: String { get }

public var kIOUserClientEntitlementsKey: String { get }

public var kIOServiceDEXTEntitlementsKey: String { get }

public var kIODriverKitEntitlementKey: String { get }

public var kIODriverKitUserClientEntitlementsKey: String { get }

public var kIODriverKitRequiredEntitlementsKey: String { get }

public var kIODriverKitTestDriverEntitlementKey: String { get }

public var kIODriverKitUserClientEntitlementAllowAnyKey: String { get }

public var kIODriverKitUserClientEntitlementAdministratorKey: String { get }

public var kIODriverKitUserClientEntitlementCommunicatesWithDriversKey: String { get }

public var kIODriverKitUserClientEntitlementAllowThirdPartyUserClientsKey: String { get }

public var kIODriverKitUSBTransportEntitlementKey: String { get }

public var kIODriverKitHIDTransportEntitlementKey: String { get }

public var kIODriverKitHIDFamilyDeviceEntitlementKey: String { get }

public var kIODriverKitHIDFamilyEventServiceEntitlementKey: String { get }

public var kIODriverKitTransportBuiltinEntitlementKey: String { get }

public var kIONVRAMReadAccessKey: String { get }

public var kIONVRAMWriteAccessKey: String { get }

public var kIOResourcesSetPropertyKey: String { get }

public var kIONVRAMSystemAllowKey: String { get }

public var kIOMatchDeferKey: String { get }

public var kIOAllCPUInitializedKey: String { get }

public var kIOUserClientClassKey: String { get }

public var kIOMapperIDKey: String { get }

public var kIOUserClientCrossEndianKey: String { get }

public var kIOUserClientCrossEndianCompatibleKey: String { get }

public var kIOUserClientSharedInstanceKey: String { get }

public var kIOUserClientDefaultLockingKey: String { get }

public var kIOUserClientDefaultLockingSetPropertiesKey: String { get }

public var kIOUserClientDefaultLockingSingleThreadExternalMethodKey: String { get }

public var kIOUserClientCreatorKey: String { get }

public var kIOUserServerCDHashKey: String { get }

public var kIOUserUserClientKey: String { get }

public var kIOUserServerOneProcessKey: String { get }

public var kIOUserServerPreserveUserspaceRebootKey: String { get }

public var kIOPublishNotification: String { get }

public var kIOFirstPublishNotification: String { get }

public var kIOMatchedNotification: String { get }

public var kIOFirstMatchNotification: String { get }

public var kIOTerminatedNotification: String { get }

public var kIOWillTerminateNotification: String { get }

public var kIOGeneralInterest: String { get }

public var kIOBusyInterest: String { get }

public var kIOAppPowerStateInterest: String { get }

public var kIOPriorityPowerStateInterest: String { get }

public var kIOPlatformDeviceMessageKey: String { get }

public var kIOCFPlugInTypesKey: String { get }

public var kIOCompatibilityMatchKey: String { get }

public var kIOCompatibilityPropertiesKey: String { get }

public var kIOPathKey: String { get }

public var kIOCommandPoolSizeKey: String { get }

public var kIOMaximumPriorityCountKey: String { get }

public var kIOMaximumBlockCountReadKey: String { get }

public var kIOMaximumBlockCountWriteKey: String { get }

public var kIOMaximumByteCountReadKey: String { get }

public var kIOMaximumByteCountWriteKey: String { get }

public var kIOMaximumSegmentCountReadKey: String { get }

public var kIOMaximumSegmentCountWriteKey: String { get }

public var kIOMaximumSegmentByteCountReadKey: String { get }

public var kIOMaximumSegmentByteCountWriteKey: String { get }

public var kIOMinimumSegmentAlignmentByteCountKey: String { get }

public var kIOMaximumSegmentAddressableBitCountKey: String { get }

public var kIOMinimumSaturationByteCountKey: String { get }

public var kIOMaximumSwapWriteKey: String { get }

public var kIOIconKey: String { get }

public var kIOBundleResourceFileKey: String { get }

public var kIOBusBadgeKey: String { get }

public var kIODeviceIconKey: String { get }

public var kIOPlatformSerialNumberKey: String { get }

public var kIOPlatformUUIDKey: String { get }

public var kIONVRAMBootArgsKey: String { get }

public var kIONVRAMDeletePropertyKey: String { get }

public var kIONVRAMSyncNowPropertyKey: String { get }

public var kIONVRAMActivateCSRConfigPropertyKey: String { get }

public var kIODTNVRAMPanicInfoKey: String { get }

public var kIONVRAMDeletePropertyKeyWRet: String { get }

public var kIOBootDeviceKey: String { get }

public var kIOBootDevicePathKey: String { get }

public var kIOBootDeviceSizeKey: String { get }

public var kOSBuildVersionKey: String { get }

public var kIOStateNotificationItemCreateKey: String { get }

public var kIOStateNotificationItemSetKey: String { get }

public var kIOStateNotificationItemCopyKey: String { get }

public var kIOStateNotificationNameKey: String { get }

public var kIOStateNotificationEntitlementSetKey: String { get }

public var kIOStateNotificationEntitlementGetKey: String { get }

public var kIOSystemStateClamshellKey: String { get }

public var kIOSystemStateSleepDescriptionKey: String { get }

public var kIOSystemStateSleepDescriptionReasonKey: String { get }

public var kIOSystemStateSleepDescriptionHibernateStateKey: String { get }

public var kIOSystemStateSleepDescriptionHibernateStateInactive: Int { get }

public var kIOSystemStateSleepDescriptionHibernateStateHibernating: Int { get }

public var kIOSystemStateSleepDescriptionHibernateStateWakingFromHibernate: Int { get }

public var kIOSystemStateWakeDescriptionKey: String { get }

public var kIOSystemStateWakeDescriptionWakeReasonKey: String { get }

public var kIOSystemStateWakeDescriptionContinuousTimeOffsetKey: String { get }

public var kIOSystemStateHaltDescriptionKey: String { get }

public var kIOSystemStateHaltDescriptionHaltStateKey: String { get }

public var kIOSystemStatePowerSourceDescriptionKey: String { get }

public var kIOSystemStatePowerSourceDescriptionACAttachedKey: String { get }

public var kFirstIOKitNotificationType: Int { get }

public var kIOServicePublishNotificationType: Int { get }

public var kIOServiceMatchedNotificationType: Int { get }

public var kIOServiceTerminatedNotificationType: Int { get }

public var kIOAsyncCompletionNotificationType: Int { get }

public var kIOServiceMessageNotificationType: Int { get }

public var kLastIOKitNotificationType: Int { get }

public var kIOKitNoticationTypeMask: Int { get }

public var kIOKitNoticationTypeSizeAdjShift: Int { get }

public var kIOKitNoticationMsgSizeMask: Int { get }

public var kOSNotificationMessageID: Int { get }

public var kOSAsyncCompleteMessageID: Int { get }

public var kMaxAsyncArgs: Int { get }

public var kIOAsyncReservedIndex: Int { get }

public var kIOAsyncReservedCount: Int { get }

public var kIOAsyncCalloutFuncIndex: Int { get }

public var kIOAsyncCalloutRefconIndex: Int { get }

public var kIOAsyncCalloutCount: Int { get }

public var kIOMatchingCalloutFuncIndex: Int { get }

public var kIOMatchingCalloutRefconIndex: Int { get }

public var kIOMatchingCalloutCount: Int { get }

public var kIOInterestCalloutFuncIndex: Int { get }

public var kIOInterestCalloutRefconIndex: Int { get }

public var kIOInterestCalloutServiceIndex: Int { get }

public var kIOInterestCalloutCount: Int { get }

public var kOSAsyncRef64Count: Int { get }

public var kOSAsyncRef64Size: Int { get }

public typealias OSAsyncReference64 = (io_user_reference_t, io_user_reference_t, io_user_reference_t, io_user_reference_t, io_user_reference_t, io_user_reference_t, io_user_reference_t, io_user_reference_t)

public struct OSNotificationHeader64 {

    public init()

    public var size: mach_msg_size_t

    public var type: natural_t

    public var reference: OSAsyncReference64
}

public struct IOServiceInterestContent64 {

    public init()

    public init(messageType: natural_t, messageArgument: io_user_reference_t)

    public var messageType: natural_t

    public var messageArgument: io_user_reference_t
}

public var kOSAsyncRefCount: Int { get }

public var kOSAsyncRefSize: Int { get }

public typealias OSAsyncReference = (natural_t, natural_t, natural_t, natural_t, natural_t, natural_t, natural_t, natural_t)

public struct OSNotificationHeader {

    public init()

    public var size: mach_msg_size_t

    public var type: natural_t

    public var reference: OSAsyncReference
}

public struct IOServiceInterestContent {

    public init()

    public init(messageType: natural_t, messageArgument: UnsafeMutableRawPointer?)

    public var messageType: natural_t

    public var messageArgument: UnsafeMutableRawPointer?
}

public struct IOAsyncCompletionContent {

    public init()

    public var result: IOReturn
}

/** @header IOKitLib
IOKitLib implements non-kernel task access to common IOKit object types - IORegistryEntry, IOService, IOIterator etc. These functions are generic - families may provide API that is more specific.<br>
IOKitLib represents IOKit objects outside the kernel with the types io_object_t, io_registry_entry_t, io_service_t, & io_connect_t. Function names usually begin with the type of object they are compatible with - eg. IOObjectRelease can be used with any io_object_t. Inside the kernel, the c++ class hierarchy allows the subclasses of each object type to receive the same requests from user level clients, for example in the kernel, IOService is a subclass of IORegistryEntry, which means any of the IORegistryEntryXXX functions in IOKitLib may be used with io_service_t's as well as io_registry_t's. There are functions available to introspect the class of the kernel object which any io_object_t et al. represents.
IOKit objects returned by all functions should be released with IOObjectRelease.
*/
public typealias IONotificationPortRef = OpaquePointer

/** @typedef IOServiceMatchingCallback
    @abstract Callback function to be notified of IOService publication.
    @param refcon The refcon passed when the notification was installed.
    @param iterator The notification iterator which now has new objects.
*/
public typealias IOServiceMatchingCallback = @convention(c) (UnsafeMutableRawPointer?, io_iterator_t) -> Void

/** @typedef IOServiceInterestCallback
    @abstract Callback function to be notified of changes in state of an IOService.
    @param refcon The refcon passed when the notification was installed.
    @param service The IOService whose state has changed.
    @param messageType A messageType enum, defined by IOKit/IOMessage.h or by the IOService's family.
    @param messageArgument An argument for the message, dependent on the messageType.  If the message data is larger than sizeof(void*), then messageArgument contains a pointer to the message data; otherwise, messageArgument contains the message data.
*/
public typealias IOServiceInterestCallback = @convention(c) (UnsafeMutableRawPointer?, io_service_t, UInt32, UnsafeMutableRawPointer?) -> Void

/** @const kIOMainPortDefault
    @abstract The default mach port used to initiate communication with IOKit.
    @discussion When specifying a main port to IOKit functions, the NULL argument indicates "use the default". This is a synonym for NULL, if you'd rather use a named constant. */
@available(macOS 12.0, *)
public let kIOMainPortDefault: mach_port_t

/** @function IOMainPort
    @abstract Returns the mach port used to initiate communication with IOKit.
    @discussion Functions that don't specify an existing object require the IOKit main port to be passed. This function obtains that port.
    @param bootstrapPort Pass MACH_PORT_NULL for the default.
    @param mainPort The main port is returned.
    @result A kern_return_t error code. */
@available(macOS 12.0, *)
public func IOMainPort(_ bootstrapPort: mach_port_t, _ mainPort: UnsafeMutablePointer<mach_port_t>!) -> kern_return_t

/** @const kIOMasterPortDefault
    @abstract Deprecated name for kIOMainPortDefault. */
@available(macOS, introduced: 10.0, deprecated: 12.0, renamed: "kIOMainPortDefault")
public let kIOMasterPortDefault: mach_port_t

/** @function IOMasterPort
    @abstract Deprecated name for IOMainPort(). */
@available(macOS, introduced: 10.0, deprecated: 12.0, renamed: "kIOMainPortDefault")
public func IOMasterPort(_ bootstrapPort: mach_port_t, _ mainPort: UnsafeMutablePointer<mach_port_t>!) -> kern_return_t

/** @function IONotificationPortCreate
    @abstract Creates and returns a notification object for receiving IOKit notifications of new devices or state changes.
    @discussion Creates the notification object to receive notifications from IOKit of new device arrivals or state changes. The notification object can be supply a CFRunLoopSource, or mach_port_t to be used to listen for events.
    @param mainPort The main port obtained from IOMainPort(). Pass kIOMainPortDefault to look up the default main port.
    @result A reference to the notification object. */
public func IONotificationPortCreate(_ mainPort: mach_port_t) -> IONotificationPortRef!

/** @function IONotificationPortDestroy
    @abstract Destroys a notification object created with IONotificationPortCreate.
                Also destroys any mach_port's or CFRunLoopSources obtained from 
                <code>@link IONotificationPortGetRunLoopSource @/link</code>
                or <code>@link IONotificationPortGetMachPort @/link</code>
    @param notify A reference to the notification object. */
public func IONotificationPortDestroy(_ notify: IONotificationPortRef!)

/** @function IONotificationPortGetRunLoopSource
    @abstract Returns a CFRunLoopSource to be used to listen for notifications.
    @discussion A notification object may deliver notifications to a CFRunLoop 
                by adding the run loop source returned by this function to the run loop.

                The caller should not release this CFRunLoopSource. Just call 
                <code>@link IONotificationPortDestroy @/link</code> to dispose of the
                IONotificationPortRef and the CFRunLoopSource when done.
    @param notify The notification object.
    @result A CFRunLoopSourceRef for the notification object. */
public func IONotificationPortGetRunLoopSource(_ notify: IONotificationPortRef!) -> Unmanaged<CFRunLoopSource>!

/** @function IONotificationPortGetMachPort
    @abstract Returns a mach_port to be used to listen for notifications.
    @discussion A notification object may deliver notifications to a mach messaging client 
                if they listen for messages on the port obtained from this function. 
                Callbacks associated with the notifications may be delivered by calling 
                IODispatchCalloutFromMessage with messages received.
                
                The caller should not release this mach_port_t. Just call 
                <code>@link IONotificationPortDestroy @/link</code> to dispose of the
                mach_port_t and IONotificationPortRef when done.
    @param notify The notification object.
    @result A mach_port for the notification object. */
public func IONotificationPortGetMachPort(_ notify: IONotificationPortRef!) -> mach_port_t

/** @function IONotificationPortSetImportanceReceiver
    @abstract Configure a notification port to be an importance receiver.
    @discussion Sets the MACH_PORT_IMPORTANCE_RECEIVER attribute on the underlying mach port.
                Importance-donating messages sent to a notification port with this
                attribute enabled will boost the importance of the receiving process for the
                duration of the notification handler.
    @param notify The notification object.
    @result A kern_return_t error code. */
public func IONotificationPortSetImportanceReceiver(_ notify: IONotificationPortRef!) -> kern_return_t

/** @function IONotificationPortSetDispatchQueue
    @abstract Sets a dispatch queue to be used to listen for notifications.
    @discussion A notification object may deliver notifications to a dispatch client.
    @param notify The notification object.
    @param queue A dispatch queue. */
@available(macOS 10.6, *)
public func IONotificationPortSetDispatchQueue(_ notify: IONotificationPortRef!, _ queue: dispatch_queue_t!)

/** @function IODispatchCalloutFromMessage
    @abstract Dispatches callback notifications from a mach message.
    @discussion A notification object may deliver notifications to a mach messaging client, 
                which should call this function to generate the callbacks associated with the notifications arriving on the port.
    @param unused Not used, set to zero.
    @param msg A pointer to the message received.
    @param reference Pass the IONotificationPortRef for the object. */
public func IODispatchCalloutFromMessage(_ unused: UnsafeMutableRawPointer!, _ msg: UnsafeMutablePointer<mach_msg_header_t>!, _ reference: UnsafeMutableRawPointer!)

/** @function IOCreateReceivePort
    @abstract Creates and returns a mach port suitable for receiving IOKit messages of the specified type.
    @discussion In the future IOKit may use specialized messages and ports
    instead of the standard ports created by mach_port_allocate(). Use this
    function instead of mach_port_allocate() to ensure compatibility with future
    revisions of IOKit.
    @param msgType Type of message to be sent to this port
    (kOSNotificationMessageID or kOSAsyncCompleteMessageID)
    @param recvPort The created port is returned.
    @result A kern_return_t error code. */
public func IOCreateReceivePort(_ msgType: UInt32, _ recvPort: UnsafeMutablePointer<mach_port_t>!) -> kern_return_t

/** @function IOObjectRelease
    @abstract Releases an object handle previously returned by IOKitLib.
    @discussion All objects returned by IOKitLib should be released with this function when access to them is no longer needed. Using the object after it has been released may or may not return an error, depending on how many references the task has to the same object in the kernel.
    @param object The IOKit object to release.
    @result A kern_return_t error code. */
public func IOObjectRelease(_ object: io_object_t) -> kern_return_t

/** @function IOObjectRetain
    @abstract Retains an object handle previously returned by IOKitLib.
    @discussion Gives the caller an additional reference to an existing object handle previously returned by IOKitLib.
    @param object The IOKit object to retain.
    @result A kern_return_t error code. */
public func IOObjectRetain(_ object: io_object_t) -> kern_return_t

/** @function IOObjectGetClass
    @abstract Return the class name of an IOKit object.
    @discussion This function uses the OSMetaClass system in the kernel to derive the name of the class the object is an instance of.
    @param object The IOKit object.
    @param className Caller allocated buffer to receive the name string.
    @result A kern_return_t error code. */
public func IOObjectGetClass(_ object: io_object_t, _ className: UnsafeMutablePointer<CChar>!) -> kern_return_t

/** @function IOObjectCopyClass
    @abstract Return the class name of an IOKit object.
    @discussion This function does the same thing as IOObjectGetClass, but returns the result as a CFStringRef.
    @param object The IOKit object.
    @result The resulting CFStringRef. This should be released by the caller. If a valid object is not passed in, then NULL is returned.*/
@available(macOS 10.4, *)
public func IOObjectCopyClass(_ object: io_object_t) -> Unmanaged<CFString>!

/** @function IOObjectCopySuperclassForClass
    @abstract Return the superclass name of the given class.
    @discussion This function uses the OSMetaClass system in the kernel to derive the name of the superclass of the class.
    @param classname The name of the class as a CFString.
    @result The resulting CFStringRef. This should be released by the caller. If there is no superclass, or a valid class name is not passed in, then NULL is returned.*/
@available(macOS 10.4, *)
public func IOObjectCopySuperclassForClass(_ classname: CFString!) -> Unmanaged<CFString>!

/** @function IOObjectCopyBundleIdentifierForClass
    @abstract Return the bundle identifier of the given class.
    @discussion This function uses the OSMetaClass system in the kernel to derive the name of the kmod, which is the same as the bundle identifier.
    @param classname The name of the class as a CFString.
    @result The resulting CFStringRef. This should be released by the caller. If a valid class name is not passed in, then NULL is returned.*/
@available(macOS 10.4, *)
public func IOObjectCopyBundleIdentifierForClass(_ classname: CFString!) -> Unmanaged<CFString>!

/** @function IOObjectConformsTo
    @abstract Performs an OSDynamicCast operation on an IOKit object.
    @discussion This function uses the OSMetaClass system in the kernel to determine if the object will dynamic cast to a class, specified as a C-string. In other words, if the object is of that class or a subclass.
    @param object An IOKit object.
    @param className The name of the class, as a C-string.
    @result If the object handle is valid, and represents an object in the kernel that dynamic casts to the class true is returned, otherwise false. */
public func IOObjectConformsTo(_ object: io_object_t, _ className: UnsafePointer<CChar>!) -> boolean_t

/** @function IOObjectIsEqualTo
    @abstract Checks two object handles to see if they represent the same kernel object.
    @discussion If two object handles are returned by IOKitLib functions, this function will compare them to see if they represent the same kernel object.
    @param object An IOKit object.
    @param anObject Another IOKit object.
    @result If both object handles are valid, and represent the same object in the kernel true is returned, otherwise false. */
public func IOObjectIsEqualTo(_ object: io_object_t, _ anObject: io_object_t) -> boolean_t

/** @function IOObjectGetKernelRetainCount
    @abstract Returns kernel retain count of an IOKit object.
    @discussion This function may be used in diagnostics to determine the current retain count of the kernel object at the kernel level.
    @param object An IOKit object.
    @result If the object handle is valid, the kernel objects retain count is returned, otherwise zero is returned. */
@available(macOS 10.6, *)
public func IOObjectGetKernelRetainCount(_ object: io_object_t) -> UInt32

/** @function IOObjectGetUserRetainCount
    @abstract Returns the retain count for the current process of an IOKit object.
    @discussion This function may be used in diagnostics to determine the current retain count for the calling process of the kernel object.
    @param object An IOKit object.
    @result If the object handle is valid, the objects user retain count is returned, otherwise zero is returned. */
@available(macOS 10.6, *)
public func IOObjectGetUserRetainCount(_ object: io_object_t) -> UInt32

/** @function IOObjectGetRetainCount
    @abstract Returns kernel retain count of an IOKit object. Identical to IOObjectGetKernelRetainCount() but available prior to Mac OS 10.6.
    @discussion This function may be used in diagnostics to determine the current retain count of the kernel object at the kernel level.
    @param object An IOKit object.
    @result If the object handle is valid, the kernel objects retain count is returned, otherwise zero is returned. */
public func IOObjectGetRetainCount(_ object: io_object_t) -> UInt32

/** @function IOIteratorNext
    @abstract Returns the next object in an iteration.
    @discussion This function returns the next object in an iteration, or zero if no more remain or the iterator is invalid.
    @param iterator An IOKit iterator handle.
    @result If the iterator handle is valid, the next element in the iteration is returned, otherwise zero is returned. The element should be released by the caller when it is finished. */
public func IOIteratorNext(_ iterator: io_iterator_t) -> io_object_t

/** @function IOIteratorReset
    @abstract Resets an iteration back to the beginning.
    @discussion If an iterator is invalid, or if the caller wants to start over, IOIteratorReset will set the iteration back to the beginning.
    @param iterator An IOKit iterator handle. */
public func IOIteratorReset(_ iterator: io_iterator_t)

/** @function IOIteratorIsValid
    @abstract Checks an iterator is still valid.
    @discussion Some iterators will be made invalid if changes are made to the structure they are iterating over. This function checks the iterator is still valid and should be called when IOIteratorNext returns zero. An invalid iterator can be reset and the iteration restarted.
    @param iterator An IOKit iterator handle.
    @result True if the iterator handle is valid, otherwise false is returned. */
public func IOIteratorIsValid(_ iterator: io_iterator_t) -> boolean_t

/**
    @function IOServiceGetMatchingService
    @abstract Look up a registered IOService object that matches a matching dictionary.
    @discussion This is the preferred method of finding IOService objects currently registered by IOKit (that is, objects that have had their registerService() methods invoked). To find IOService objects that aren't yet registered, use an iterator as created by IORegistryEntryCreateIterator(). IOServiceAddMatchingNotification can also supply this information and install a notification of new IOServices. The matching information used in the matching dictionary may vary depending on the class of service being looked up.
    @param mainPort The main port obtained from IOMainPort(). Pass kIOMainPortDefault to look up the default main port.
    @param matching A CF dictionary containing matching information, of which one reference is always consumed by this function (Note prior to the Tiger release there was a small chance that the dictionary might not be released if there was an error attempting to serialize the dictionary). IOKitLib can construct matching dictionaries for common criteria with helper functions such as IOServiceMatching, IOServiceNameMatching, IOBSDNameMatching.
    @result The first service matched is returned on success. The service must be released by the caller.
  */
public func IOServiceGetMatchingService(_ mainPort: mach_port_t, _ matching: CFDictionary!) -> io_service_t

/** @function IOServiceGetMatchingServices
    @abstract Look up registered IOService objects that match a matching dictionary.
    @discussion This is the preferred method of finding IOService objects currently registered by IOKit (that is, objects that have had their registerService() methods invoked). To find IOService objects that aren't yet registered, use an iterator as created by IORegistryEntryCreateIterator(). IOServiceAddMatchingNotification can also supply this information and install a notification of new IOServices. The matching information used in the matching dictionary may vary depending on the class of service being looked up.
    @param mainPort The main port obtained from IOMainPort(). Pass kIOMainPortDefault to look up the default main port.
    @param matching A CF dictionary containing matching information, of which one reference is always consumed by this function (Note prior to the Tiger release there was a small chance that the dictionary might not be released if there was an error attempting to serialize the dictionary). IOKitLib can construct matching dictionaries for common criteria with helper functions such as IOServiceMatching, IOServiceNameMatching, IOBSDNameMatching.
    @param existing An iterator handle, or NULL, is returned on success, and should be released by the caller when the iteration is finished. If NULL is returned, the iteration was successful but found no matching services.
    @result A kern_return_t error code. */
public func IOServiceGetMatchingServices(_ mainPort: mach_port_t, _ matching: CFDictionary!, _ existing: UnsafeMutablePointer<io_iterator_t>!) -> kern_return_t

@available(*, deprecated)
public func IOServiceAddNotification(_ mainPort: mach_port_t, _ notificationType: UnsafePointer<CChar>!, _ matching: CFDictionary!, _ wakePort: mach_port_t, _ reference: UInt, _ notification: UnsafeMutablePointer<io_iterator_t>!) -> kern_return_t

/** @function IOServiceAddMatchingNotification
    @abstract Look up registered IOService objects that match a matching dictionary, and install a notification request of new IOServices that match.
    @discussion This is the preferred method of finding IOService objects that may arrive at any time. The type of notification specifies the state change the caller is interested in, on IOService's that match the match dictionary. Notification types are identified by name, and are defined in IOKitKeys.h. The matching information used in the matching dictionary may vary depending on the class of service being looked up.
    @param notifyPort A IONotificationPortRef object that controls how messages will be sent when the armed notification is fired. When the notification is delivered, the io_iterator_t representing the notification should be iterated through to pick up all outstanding objects. When the iteration is finished the notification is rearmed. See IONotificationPortCreate.
    @param notificationType A notification type from IOKitKeys.h
<br>    kIOPublishNotification Delivered when an IOService is registered.
<br>    kIOFirstPublishNotification Delivered when an IOService is registered, but only once per IOService instance. Some IOService's may be reregistered when their state is changed.
<br>    kIOMatchedNotification Delivered when an IOService has had all matching drivers in the kernel probed and started.
<br>    kIOFirstMatchNotification Delivered when an IOService has had all matching drivers in the kernel probed and started, but only once per IOService instance. Some IOService's may be reregistered when their state is changed.
<br>    kIOTerminatedNotification Delivered after an IOService has been terminated.
    @param matching A CF dictionary containing matching information, of which one reference is always consumed by this function (Note prior to the Tiger release there was a small chance that the dictionary might not be released if there was an error attempting to serialize the dictionary). IOKitLib can construct matching dictionaries for common criteria with helper functions such as IOServiceMatching, IOServiceNameMatching, IOBSDNameMatching.
    @param callback A callback function called when the notification fires.
    @param refCon A reference constant for the callbacks use.
    @param notification An iterator handle is returned on success, and should be released by the caller when the notification is to be destroyed. The notification is armed when the iterator is emptied by calls to IOIteratorNext - when no more objects are returned, the notification is armed. Note the notification is not armed when first created.
    @result A kern_return_t error code. */
public func IOServiceAddMatchingNotification(_ notifyPort: IONotificationPortRef!, _ notificationType: UnsafePointer<CChar>!, _ matching: CFDictionary!, _ callback: IOServiceMatchingCallback!, _ refCon: UnsafeMutableRawPointer!, _ notification: UnsafeMutablePointer<io_iterator_t>!) -> kern_return_t

/** @function IOServiceAddInterestNotification
    @abstract Register for notification of state changes in an IOService.
    @discussion IOService objects deliver notifications of their state changes to their clients via the IOService::messageClients API, and to other interested parties including callers of this function. Message types are defined IOKit/IOMessage.h.
    @param notifyPort A IONotificationPortRef object that controls how messages will be sent when the notification is fired. See IONotificationPortCreate.
    @param interestType A notification type from IOKitKeys.h
<br>    kIOGeneralInterest General state changes delivered via the IOService::messageClients API.
<br>    kIOBusyInterest Delivered when the IOService changes its busy state to or from zero. The message argument contains the new busy state causing the notification.
    @param callback A callback function called when the notification fires, with messageType and messageArgument for the state change.
    @param refCon A reference constant for the callbacks use.
    @param notification An object handle is returned on success, and should be released by the caller when the notification is to be destroyed.
    @result A kern_return_t error code. */
public func IOServiceAddInterestNotification(_ notifyPort: IONotificationPortRef!, _ service: io_service_t, _ interestType: UnsafePointer<CChar>!, _ callback: IOServiceInterestCallback!, _ refCon: UnsafeMutableRawPointer!, _ notification: UnsafeMutablePointer<io_object_t>!) -> kern_return_t

/** @function IOServiceMatchPropertyTable
    @abstract Match an IOService objects with matching dictionary.
    @discussion This function calls the matching method of an IOService object and returns the boolean result.
    @param service The IOService object to match.
    @param matching A CF dictionary containing matching information. IOKitLib can construct matching dictionaries for common criteria with helper functions such as IOServiceMatching, IOServiceNameMatching, IOBSDNameMatching.
    @param matches The boolean result is returned.
    @result A kern_return_t error code. */
public func IOServiceMatchPropertyTable(_ service: io_service_t, _ matching: CFDictionary!, _ matches: UnsafeMutablePointer<boolean_t>!) -> kern_return_t

/** @function IOServiceGetBusyState
    @abstract Returns the busyState of an IOService.
    @discussion Many activities in IOService are asynchronous. When registration, matching, or termination is in progress on an IOService, its busyState is increased by one. Change in busyState to or from zero also changes the IOService's provider's busyState by one, which means that an IOService is marked busy when any of the above activities is occurring on it or any of its clients.
    @param service The IOService whose busyState to return.
    @param busyState The busyState count is returned.
    @result A kern_return_t error code. */
public func IOServiceGetBusyState(_ service: io_service_t, _ busyState: UnsafeMutablePointer<UInt32>!) -> kern_return_t

/** @function IOServiceWaitQuiet
    @abstract Wait for an IOService's busyState to be zero.
    @discussion Blocks the caller until an IOService is non busy, see IOServiceGetBusyState.
    @param service The IOService wait on.
    @param waitTime Specifies a maximum time to wait. Pass NULL to wait forever.
    @result Returns an error code if mach synchronization primitives fail, kIOReturnTimeout, or kIOReturnSuccess. */
public func IOServiceWaitQuiet(_ service: io_service_t, _ waitTime: UnsafeMutablePointer<mach_timespec_t>!) -> kern_return_t

/** @function IOKitGetBusyState
    @abstract Returns the busyState of all IOServices.
    @discussion Many activities in IOService are asynchronous. When registration, matching, or termination is in progress on an IOService, its busyState is increased by one. Change in busyState to or from zero also changes the IOService's provider's busyState by one, which means that an IOService is marked busy when any of the above activities is occurring on it or any of its clients. IOKitGetBusyState returns the busy state of the root of the service plane which reflects the busy state of all IOServices.
    @param mainPort The main port obtained from IOMainPort(). Pass kIOMainPortDefault to look up the default main port.
    @param busyState The busyState count is returned.
    @result A kern_return_t error code. */
public func IOKitGetBusyState(_ mainPort: mach_port_t, _ busyState: UnsafeMutablePointer<UInt32>!) -> kern_return_t

/** @function IOKitWaitQuiet
    @abstract Wait for all IOServices' busyState to be zero.
    @discussion Blocks the caller until all IOServices are non busy, see IOKitGetBusyState.
    @param mainPort The main port obtained from IOMainPort(). Pass kIOMainPortDefault to look up the default main port.
    @param waitTime Specifies a maximum time to wait.
    @result Returns an error code if mach synchronization primitives fail, kIOReturnTimeout, or kIOReturnSuccess. */
public func IOKitWaitQuiet(_ mainPort: mach_port_t, _ waitTime: UnsafeMutablePointer<mach_timespec_t>!) -> kern_return_t

/** @function IOServiceOpen
    @abstract A request to create a connection to an IOService.
    @discussion A non kernel client may request a connection be opened via the IOServiceOpen() library function, which will call IOService::newUserClient in the kernel. The rules & capabilities of user level clients are family dependent, the default IOService implementation returns kIOReturnUnsupported.
    @param service The IOService object to open a connection to, usually obtained via the IOServiceGetMatchingServices or IOServiceAddNotification APIs.
    @param owningTask The mach task requesting the connection.
    @param type A constant specifying the type of connection to be created,  interpreted only by the IOService's family.
    @param connect An io_connect_t handle is returned on success, to be used with the IOConnectXXX APIs. It should be destroyed with IOServiceClose().
    @result A return code generated by IOService::newUserClient. */
public func IOServiceOpen(_ service: io_service_t, _ owningTask: task_port_t, _ type: UInt32, _ connect: UnsafeMutablePointer<io_connect_t>!) -> kern_return_t

/** @function IOServiceRequestProbe
    @abstract A request to rescan a bus for device changes.
    @discussion A non kernel client may request a bus or controller rescan for added or removed devices, if the bus family does automatically notice such changes. For example, SCSI bus controllers do not notice device changes. The implementation of this routine is family dependent, and the default IOService implementation returns kIOReturnUnsupported.
    @param service The IOService object to request a rescan, usually obtained via the IOServiceGetMatchingServices or IOServiceAddNotification APIs.
    @param options An options mask, interpreted only by the IOService's family.
    @result A return code generated by IOService::requestProbe. */
@available(macOS 1.0, *)
public func IOServiceRequestProbe(_ service: io_service_t, _ options: UInt32) -> kern_return_t

public var kIOServiceInteractionAllowed: Int { get }

/** @function IOServiceAuthorize
    @abstract Authorize access to an IOService.
    @discussion Determine whether this application is authorized to invoke IOServiceOpen() for a given IOService, either by confirming that it has been previously authorized by the user, or by soliciting the console user.
    @param service The IOService object to be authorized, usually obtained via the IOServiceGetMatchingServices or IOServiceAddNotification APIs.
    @param options kIOServiceInteractionAllowed may be set to permit user interaction, if required.
    @result kIOReturnSuccess if the IOService is authorized, kIOReturnNotPermitted if the IOService is not authorized. */
@available(macOS 1.0, *)
public func IOServiceAuthorize(_ service: io_service_t, _ options: UInt32) -> kern_return_t

@available(macOS 1.0, *)
public func IOServiceOpenAsFileDescriptor(_ service: io_service_t, _ oflag: Int32) -> Int32

/** @function IOServiceClose
    @abstract Close a connection to an IOService and destroy the connect handle.
    @discussion A connection created with the IOServiceOpen should be closed when the connection is no longer to be used with IOServiceClose.
    @param connect The connect handle created by IOServiceOpen. It will be destroyed by this function, and should not be released with IOObjectRelease.
    @result A kern_return_t error code. */
public func IOServiceClose(_ connect: io_connect_t) -> kern_return_t

/** @function IOConnectAddRef
    @abstract Adds a reference to the connect handle.
    @discussion Adds a reference to the connect handle.
    @param connect The connect handle created by IOServiceOpen.
    @result A kern_return_t error code. */
public func IOConnectAddRef(_ connect: io_connect_t) -> kern_return_t

/** @function IOConnectRelease
    @abstract Remove a reference to the connect handle.
    @discussion Removes a reference to the connect handle.  If the last reference is removed an implicit IOServiceClose is performed.
    @param connect The connect handle created by IOServiceOpen.
    @result A kern_return_t error code. */
public func IOConnectRelease(_ connect: io_connect_t) -> kern_return_t

/** @function IOConnectGetService
    @abstract Returns the IOService a connect handle was opened on.
    @discussion Finds the service object a connection was opened on.
    @param connect The connect handle created by IOServiceOpen.
    @param service On success, the service handle the connection was opened on, which should be released with IOObjectRelease.
    @result A kern_return_t error code. */
public func IOConnectGetService(_ connect: io_connect_t, _ service: UnsafeMutablePointer<io_service_t>!) -> kern_return_t

/** @function IOConnectSetNotificationPort
    @abstract Set a port to receive family specific notifications.
    @discussion This is a generic method to pass a mach port send right to be be used by family specific notifications. 
    @param connect The connect handle created by IOServiceOpen.
    @param type The type of notification requested, not interpreted by IOKit and family defined.
    @param port The port to which to send notifications.
    @param reference Some families may support passing a reference parameter for the callers use with the notification.
    @result A kern_return_t error code. */
public func IOConnectSetNotificationPort(_ connect: io_connect_t, _ type: UInt32, _ port: mach_port_t, _ reference: UInt) -> kern_return_t

public func IOConnectMapMemory(_ connect: io_connect_t, _ memoryType: UInt32, _ intoTask: task_port_t, _ atAddress: UnsafeMutablePointer<mach_vm_address_t>!, _ ofSize: UnsafeMutablePointer<mach_vm_size_t>!, _ options: IOOptionBits) -> kern_return_t

/** @function IOConnectMapMemory64
    @abstract Map hardware or shared memory into the caller's task.
    @discussion This is a generic method to create a mapping in the callers task. The family will interpret the type parameter to determine what sort of mapping is being requested. Cache modes and placed mappings may be requested by the caller.
    @param connect The connect handle created by IOServiceOpen.
    @param memoryType What is being requested to be mapped, not interpreted by IOKit and family defined. The family may support physical hardware or shared memory mappings.
    @param intoTask The task port for the task in which to create the mapping. This may be different to the task which the opened the connection.
    @param atAddress An in/out parameter - if the kIOMapAnywhere option is not set, the caller should pass the address where it requests the mapping be created, otherwise nothing need to set on input. The address of the mapping created is passed back on success.
    @param ofSize The size of the mapping created is passed back on success.
    @result A kern_return_t error code. */
public func IOConnectMapMemory64(_ connect: io_connect_t, _ memoryType: UInt32, _ intoTask: task_port_t, _ atAddress: UnsafeMutablePointer<mach_vm_address_t>!, _ ofSize: UnsafeMutablePointer<mach_vm_size_t>!, _ options: IOOptionBits) -> kern_return_t

public func IOConnectUnmapMemory(_ connect: io_connect_t, _ memoryType: UInt32, _ fromTask: task_port_t, _ atAddress: mach_vm_address_t) -> kern_return_t

/** @function IOConnectUnmapMemory64
    @abstract Remove a mapping made with IOConnectMapMemory64.
    @discussion This is a generic method to remove a mapping in the callers task.
    @param connect The connect handle created by IOServiceOpen.
    @param memoryType The memory type originally requested in IOConnectMapMemory.
    @param fromTask The task port for the task in which to remove the mapping. This may be different to the task which the opened the connection.
    @param atAddress The address of the mapping to be removed.
    @result A kern_return_t error code. */
public func IOConnectUnmapMemory64(_ connect: io_connect_t, _ memoryType: UInt32, _ fromTask: task_port_t, _ atAddress: mach_vm_address_t) -> kern_return_t

/** @function IOConnectSetCFProperties
    @abstract Set CF container based properties on a connection.
    @discussion This is a generic method to pass a CF container of properties to the connection. The properties are interpreted by the family and commonly represent configuration settings, but may be interpreted as anything.
    @param connect The connect handle created by IOServiceOpen.
    @param properties A CF container - commonly a CFDictionary but this is not enforced. The container should consist of objects which are understood by IOKit - these are currently : CFDictionary, CFArray, CFSet, CFString, CFData, CFNumber, CFBoolean, and are passed in the kernel as the corresponding OSDictionary etc. objects.
    @result A kern_return_t error code returned by the family. */
@available(macOS 1.0, *)
public func IOConnectSetCFProperties(_ connect: io_connect_t, _ properties: CFTypeRef!) -> kern_return_t

/** @function IOConnectSetCFProperty
    @abstract Set a CF container based property on a connection.
    @discussion This is a generic method to pass a CF property to the connection. The property is interpreted by the family and commonly represent configuration settings, but may be interpreted as anything.
    @param connect The connect handle created by IOServiceOpen.
    @param propertyName The name of the property as a CFString.
    @param property A CF container - should consist of objects which are understood by IOKit - these are currently : CFDictionary, CFArray, CFSet, CFString, CFData, CFNumber, CFBoolean, and are passed in the kernel as the corresponding OSDictionary etc. objects.
    @result A kern_return_t error code returned by the object. */
@available(macOS 1.0, *)
public func IOConnectSetCFProperty(_ connect: io_connect_t, _ propertyName: CFString!, _ property: CFTypeRef!) -> kern_return_t

@available(macOS 10.5, *)
public func IOConnectCallMethod(_ connection: mach_port_t, _ selector: UInt32, _ input: UnsafePointer<UInt64>!, _ inputCnt: UInt32, _ inputStruct: UnsafeRawPointer!, _ inputStructCnt: Int, _ output: UnsafeMutablePointer<UInt64>!, _ outputCnt: UnsafeMutablePointer<UInt32>!, _ outputStruct: UnsafeMutableRawPointer!, _ outputStructCnt: UnsafeMutablePointer<Int>!) -> kern_return_t

@available(macOS 10.5, *)
public func IOConnectCallAsyncMethod(_ connection: mach_port_t, _ selector: UInt32, _ wake_port: mach_port_t, _ reference: UnsafeMutablePointer<UInt64>!, _ referenceCnt: UInt32, _ input: UnsafePointer<UInt64>!, _ inputCnt: UInt32, _ inputStruct: UnsafeRawPointer!, _ inputStructCnt: Int, _ output: UnsafeMutablePointer<UInt64>!, _ outputCnt: UnsafeMutablePointer<UInt32>!, _ outputStruct: UnsafeMutableRawPointer!, _ outputStructCnt: UnsafeMutablePointer<Int>!) -> kern_return_t

@available(macOS 10.5, *)
public func IOConnectCallStructMethod(_ connection: mach_port_t, _ selector: UInt32, _ inputStruct: UnsafeRawPointer!, _ inputStructCnt: Int, _ outputStruct: UnsafeMutableRawPointer!, _ outputStructCnt: UnsafeMutablePointer<Int>!) -> kern_return_t

@available(macOS 10.5, *)
public func IOConnectCallAsyncStructMethod(_ connection: mach_port_t, _ selector: UInt32, _ wake_port: mach_port_t, _ reference: UnsafeMutablePointer<UInt64>!, _ referenceCnt: UInt32, _ inputStruct: UnsafeRawPointer!, _ inputStructCnt: Int, _ outputStruct: UnsafeMutableRawPointer!, _ outputStructCnt: UnsafeMutablePointer<Int>!) -> kern_return_t

@available(macOS 10.5, *)
public func IOConnectCallScalarMethod(_ connection: mach_port_t, _ selector: UInt32, _ input: UnsafePointer<UInt64>!, _ inputCnt: UInt32, _ output: UnsafeMutablePointer<UInt64>!, _ outputCnt: UnsafeMutablePointer<UInt32>!) -> kern_return_t

@available(macOS 10.5, *)
public func IOConnectCallAsyncScalarMethod(_ connection: mach_port_t, _ selector: UInt32, _ wake_port: mach_port_t, _ reference: UnsafeMutablePointer<UInt64>!, _ referenceCnt: UInt32, _ input: UnsafePointer<UInt64>!, _ inputCnt: UInt32, _ output: UnsafeMutablePointer<UInt64>!, _ outputCnt: UnsafeMutablePointer<UInt32>!) -> kern_return_t

@available(macOS 1.0, *)
public func IOConnectTrap0(_ connect: io_connect_t, _ index: UInt32) -> kern_return_t

@available(macOS 1.0, *)
public func IOConnectTrap1(_ connect: io_connect_t, _ index: UInt32, _ p1: UInt) -> kern_return_t

@available(macOS 1.0, *)
public func IOConnectTrap2(_ connect: io_connect_t, _ index: UInt32, _ p1: UInt, _ p2: UInt) -> kern_return_t

@available(macOS 1.0, *)
public func IOConnectTrap3(_ connect: io_connect_t, _ index: UInt32, _ p1: UInt, _ p2: UInt, _ p3: UInt) -> kern_return_t

@available(macOS 1.0, *)
public func IOConnectTrap4(_ connect: io_connect_t, _ index: UInt32, _ p1: UInt, _ p2: UInt, _ p3: UInt, _ p4: UInt) -> kern_return_t

@available(macOS 1.0, *)
public func IOConnectTrap5(_ connect: io_connect_t, _ index: UInt32, _ p1: UInt, _ p2: UInt, _ p3: UInt, _ p4: UInt, _ p5: UInt) -> kern_return_t

@available(macOS 1.0, *)
public func IOConnectTrap6(_ connect: io_connect_t, _ index: UInt32, _ p1: UInt, _ p2: UInt, _ p3: UInt, _ p4: UInt, _ p5: UInt, _ p6: UInt) -> kern_return_t

/** @function IOConnectAddClient
    @abstract Inform a connection of a second connection.
    @discussion This is a generic method to inform a family connection of a second connection, and is rarely used.
    @param connect The connect handle created by IOServiceOpen.
    @param client Another connect handle created by IOServiceOpen.
    @result A kern_return_t error code returned by the family. */
@available(macOS 1.0, *)
public func IOConnectAddClient(_ connect: io_connect_t, _ client: io_connect_t) -> kern_return_t

/** @function IORegistryGetRootEntry
    @abstract Return a handle to the registry root.
    @discussion This method provides an accessor to the root of the registry for the machine. The root may be passed to a registry iterator when iterating a plane, and contains properties that describe the available planes, and diagnostic information for IOKit.
    @param mainPort The main port obtained from IOMainPort(). Pass kIOMainPortDefault to look up the default main port.
    @result A handle to the IORegistryEntry root instance, to be released with IOObjectRelease by the caller, or MACH_PORT_NULL on failure. */
public func IORegistryGetRootEntry(_ mainPort: mach_port_t) -> io_registry_entry_t

/** @function IORegistryEntryFromPath
    @abstract Looks up a registry entry by path.
    @discussion This function parses paths to lookup registry entries. The path should begin with '<plane name>:' If there are characters remaining unparsed after an entry has been looked up, this is considered an invalid lookup. Paths are further documented in IORegistryEntry.h
    @param mainPort The main port obtained from IOMainPort(). Pass kIOMainPortDefault to look up the default main port.
    @param path A C-string path.
    @result A handle to the IORegistryEntry which was found with the path, to be released with IOObjectRelease by the caller, or MACH_PORT_NULL on failure. */
public func IORegistryEntryFromPath(_ mainPort: mach_port_t, _ path: UnsafePointer<CChar>!) -> io_registry_entry_t

/** @function IORegistryEntryFromPathCFString
    @abstract Looks up a registry entry by path.
    @discussion This function parses paths to lookup registry entries. The path should begin with '<plane name>:' If there are characters remaining unparsed after an entry has been looked up, this is considered an invalid lookup. Paths are further documented in IORegistryEntry.h
    @param mainPort The main port obtained from IOMainPort(). Pass kIOMainPortDefault to look up the default main port.
    @param path A CFString path.
    @result A handle to the IORegistryEntry which was found with the path, to be released with IOObjectRelease by the caller, or MACH_PORT_NULL on failure. */
@available(macOS 10.11, *)
public func IORegistryEntryCopyFromPath(_ mainPort: mach_port_t, _ path: CFString!) -> io_registry_entry_t

public var kIORegistryIterateRecursively: Int { get }

public var kIORegistryIterateParents: Int { get }

/** @function IORegistryCreateIterator
    @abstract Create an iterator rooted at the registry root.
    @discussion This method creates an IORegistryIterator in the kernel that is set up with options to iterate children of the registry root entry, and to recurse automatically into entries as they are returned, or only when instructed with calls to IORegistryIteratorEnterEntry. The iterator object keeps track of entries that have been recursed into previously to avoid loops.
    @param mainPort The main port obtained from IOMainPort(). Pass kIOMainPortDefault to look up the default main port.
    @param plane The name of an existing registry plane. Plane names are defined in IOKitKeys.h, eg. kIOServicePlane.
    @param options kIORegistryIterateRecursively may be set to recurse automatically into each entry as it is returned from IOIteratorNext calls on the registry iterator. 
    @param iterator A created iterator handle, to be released by the caller when it has finished with it.
    @result A kern_return_t error code. */
public func IORegistryCreateIterator(_ mainPort: mach_port_t, _ plane: UnsafePointer<CChar>!, _ options: IOOptionBits, _ iterator: UnsafeMutablePointer<io_iterator_t>!) -> kern_return_t

/** @function IORegistryEntryCreateIterator
    @abstract Create an iterator rooted at a given registry entry.
    @discussion This method creates an IORegistryIterator in the kernel that is set up with options to iterate children or parents of a root entry, and to recurse automatically into entries as they are returned, or only when instructed with calls to IORegistryIteratorEnterEntry. The iterator object keeps track of entries that have been recursed into previously to avoid loops.
    @param entry The root entry to begin the iteration at.
    @param plane The name of an existing registry plane. Plane names are defined in IOKitKeys.h, eg. kIOServicePlane.
    @param options kIORegistryIterateRecursively may be set to recurse automatically into each entry as it is returned from IOIteratorNext calls on the registry iterator. kIORegistryIterateParents may be set to iterate the parents of each entry, by default the children are iterated.
    @param iterator A created iterator handle, to be released by the caller when it has finished with it.
    @result A kern_return_t error code. */
public func IORegistryEntryCreateIterator(_ entry: io_registry_entry_t, _ plane: UnsafePointer<CChar>!, _ options: IOOptionBits, _ iterator: UnsafeMutablePointer<io_iterator_t>!) -> kern_return_t

/** @function IORegistryIteratorEnterEntry
    @abstract Recurse into the current entry in the registry iteration.
    @discussion This method makes the current entry, ie. the last entry returned by IOIteratorNext, the root in a new level of recursion.
    @result A kern_return_t error code. */
public func IORegistryIteratorEnterEntry(_ iterator: io_iterator_t) -> kern_return_t

/** @function IORegistryIteratorExitEntry
    @abstract Exits a level of recursion, restoring the current entry.
    @discussion This method undoes an IORegistryIteratorEnterEntry, restoring the current entry. If there are no more levels of recursion to exit false is returned, otherwise true is returned.
    @result kIOReturnSuccess if a level of recursion was undone, kIOReturnNoDevice if no recursive levels are left in the iteration. */
public func IORegistryIteratorExitEntry(_ iterator: io_iterator_t) -> kern_return_t

/** @function IORegistryEntryGetName
    @abstract Returns a C-string name assigned to a registry entry.
    @discussion Registry entries can be named in a particular plane, or globally. This function returns the entry's global name. The global name defaults to the entry's meta class name if it has not been named.
    @param entry The registry entry handle whose name to look up.
    @param name The caller's buffer to receive the name.
    @result A kern_return_t error code. */
public func IORegistryEntryGetName(_ entry: io_registry_entry_t, _ name: UnsafeMutablePointer<CChar>!) -> kern_return_t

/** @function IORegistryEntryGetNameInPlane
    @abstract Returns a C-string name assigned to a registry entry, in a specified plane.
    @discussion Registry entries can be named in a particular plane, or globally. This function returns the entry's name in the specified plane or global name if it has not been named in that plane. The global name defaults to the entry's meta class name if it has not been named.
    @param entry The registry entry handle whose name to look up.
    @param plane The name of an existing registry plane. Plane names are defined in IOKitKeys.h, eg. kIOServicePlane.
    @param name The caller's buffer to receive the name.
    @result A kern_return_t error code. */
public func IORegistryEntryGetNameInPlane(_ entry: io_registry_entry_t, _ plane: UnsafePointer<CChar>!, _ name: UnsafeMutablePointer<CChar>!) -> kern_return_t

/** @function IORegistryEntryGetLocationInPlane
    @abstract Returns a C-string location assigned to a registry entry, in a specified plane.
    @discussion Registry entries can given a location string in a particular plane, or globally. If the entry has had a location set in the specified plane that location string will be returned, otherwise the global location string is returned. If no global location string has been set, an error is returned.
    @param entry The registry entry handle whose name to look up.
    @param plane The name of an existing registry plane. Plane names are defined in IOKitKeys.h, eg. kIOServicePlane.
    @param location The caller's buffer to receive the location string.
    @result A kern_return_t error code. */
public func IORegistryEntryGetLocationInPlane(_ entry: io_registry_entry_t, _ plane: UnsafePointer<CChar>!, _ location: UnsafeMutablePointer<CChar>!) -> kern_return_t

/** @function IORegistryEntryGetPath
    @abstract Create a path for a registry entry.
    @discussion The path for a registry entry is copied to the caller's buffer. The path describes the entry's attachment in a particular plane, which must be specified. The path begins with the plane name followed by a colon, and then followed by '/' separated path components for each of the entries between the root and the registry entry. An alias may also exist for the entry, and will be returned if available.
    @param entry The registry entry handle whose path to look up.
    @param plane The name of an existing registry plane. Plane names are defined in IOKitKeys.h, eg. kIOServicePlane.
    @param path A char buffer allocated by the caller.
    @result IORegistryEntryGetPath will fail if the entry is not attached in the plane, or if the buffer is not large enough to contain the path. */
public func IORegistryEntryGetPath(_ entry: io_registry_entry_t, _ plane: UnsafePointer<CChar>!, _ path: UnsafeMutablePointer<CChar>!) -> kern_return_t

/** @function IORegistryEntryCopyPath
    @abstract Create a path for a registry entry.
    @discussion The path for a registry entry is returned as a CFString The path describes the entry's attachment in a particular plane, which must be specified. The path begins with the plane name followed by a colon, and then followed by '/' separated path components for each of the entries between the root and the registry entry. An alias may also exist for the entry, and will be returned if available.
    @param entry The registry entry handle whose path to look up.
    @param plane The name of an existing registry plane. Plane names are defined in IOKitKeys.h, eg. kIOServicePlane.
    @result An instance of CFString on success, to be released by the caller. IORegistryEntryCopyPath will fail if the entry is not attached in the plane. */
@available(macOS 10.11, *)
public func IORegistryEntryCopyPath(_ entry: io_registry_entry_t, _ plane: UnsafePointer<CChar>!) -> Unmanaged<CFString>!

/** @function IORegistryEntryGetRegistryEntryID
    @abstract Returns an ID for the registry entry that is global to all tasks.
    @discussion The entry ID returned by IORegistryEntryGetRegistryEntryID can be used to identify a registry entry across all tasks. A registry entry may be looked up by its entryID by creating a matching dictionary with IORegistryEntryIDMatching() to be used with the IOKit matching functions. The ID is valid only until the machine reboots.
    @param entry The registry entry handle whose ID to look up.
    @param entryID The resulting ID.
    @result A kern_return_t error code. */
public func IORegistryEntryGetRegistryEntryID(_ entry: io_registry_entry_t, _ entryID: UnsafeMutablePointer<UInt64>!) -> kern_return_t

/** @function IORegistryEntryCreateCFProperties
    @abstract Create a CF dictionary representation of a registry entry's property table.
    @discussion This function creates an instantaneous snapshot of a registry entry's property table, creating a CFDictionary analogue in the caller's task. Not every object available in the kernel is represented as a CF container; currently OSDictionary, OSArray, OSSet, OSSymbol, OSString, OSData, OSNumber, OSBoolean are created as their CF counterparts. 
    @param entry The registry entry handle whose property table to copy.
    @param properties A CFDictionary is created and returned the caller on success. The caller should release with CFRelease.
    @param allocator The CF allocator to use when creating the CF containers.
    @param options No options are currently defined.
    @result A kern_return_t error code. */
public func IORegistryEntryCreateCFProperties(_ entry: io_registry_entry_t, _ properties: UnsafeMutablePointer<Unmanaged<CFMutableDictionary>?>!, _ allocator: CFAllocator!, _ options: IOOptionBits) -> kern_return_t

/** @function IORegistryEntryCreateCFProperty
    @abstract Create a CF representation of a registry entry's property.
    @discussion This function creates an instantaneous snapshot of a registry entry property, creating a CF container analogue in the caller's task. Not every object available in the kernel is represented as a CF container; currently OSDictionary, OSArray, OSSet, OSSymbol, OSString, OSData, OSNumber, OSBoolean are created as their CF counterparts. 
    @param entry The registry entry handle whose property to copy.
    @param key A CFString specifying the property name.
    @param allocator The CF allocator to use when creating the CF container.
    @param options No options are currently defined.
    @result A CF container is created and returned the caller on success. The caller should release with CFRelease. */
public func IORegistryEntryCreateCFProperty(_ entry: io_registry_entry_t, _ key: CFString!, _ allocator: CFAllocator!, _ options: IOOptionBits) -> Unmanaged<CFTypeRef>!

/** @function IORegistryEntrySearchCFProperty
    @abstract Create a CF representation of a registry entry's property.
    @discussion This function creates an instantaneous snapshot of a registry entry property, creating a CF container analogue in the caller's task. Not every object available in the kernel is represented as a CF container; currently OSDictionary, OSArray, OSSet, OSSymbol, OSString, OSData, OSNumber, OSBoolean are created as their CF counterparts. 
This function will search for a property, starting first with specified registry entry's property table, then iterating recusively through either the parent registry entries or the child registry entries of this entry. Once the first occurrence is found, it will lookup and return the value of the property, using the same semantics as IORegistryEntryCreateCFProperty. The iteration keeps track of entries that have been recursed into previously to avoid loops.
    @param entry The registry entry at which to start the search.
    @param plane The name of an existing registry plane. Plane names are defined in IOKitKeys.h, eg. kIOServicePlane.
    @param key A CFString specifying the property name.
    @param allocator The CF allocator to use when creating the CF container.
    @param options kIORegistryIterateRecursively may be set to recurse automatically into the registry hierarchy. Without this option, this method degenerates into the standard IORegistryEntryCreateCFProperty() call. kIORegistryIterateParents may be set to iterate the parents of the entry, in place of the children.
    @result A CF container is created and returned the caller on success. The caller should release with CFRelease. */
public func IORegistryEntrySearchCFProperty(_ entry: io_registry_entry_t, _ plane: UnsafePointer<CChar>!, _ key: CFString!, _ allocator: CFAllocator!, _ options: IOOptionBits) -> CFTypeRef!

@available(macOS 1.0, *)
public func IORegistryEntryGetProperty(_ entry: io_registry_entry_t, _ propertyName: UnsafePointer<CChar>!, _ buffer: UnsafeMutablePointer<CChar>!, _ size: UnsafeMutablePointer<UInt32>!) -> kern_return_t

/** @function IORegistryEntrySetCFProperties
    @abstract Set CF container based properties in a registry entry.
    @discussion This is a generic method to pass a CF container of properties to an object in the registry. Setting properties in a registry entry is not generally supported, it is more common to support IOConnectSetCFProperties for connection based property setting. The properties are interpreted by the object.
    @param entry The registry entry whose properties to set.
    @param properties A CF container - commonly a CFDictionary but this is not enforced. The container should consist of objects which are understood by IOKit - these are currently : CFDictionary, CFArray, CFSet, CFString, CFData, CFNumber, CFBoolean, and are passed in the kernel as the corresponding OSDictionary etc. objects.
    @result A kern_return_t error code returned by the object. */
@available(macOS 1.0, *)
public func IORegistryEntrySetCFProperties(_ entry: io_registry_entry_t, _ properties: CFTypeRef!) -> kern_return_t

/** @function IORegistryEntrySetCFProperty
    @abstract Set a CF container based property in a registry entry.
    @discussion This is a generic method to pass a CF container as a property to an object in the registry. Setting properties in a registry entry is not generally supported, it is more common to support IOConnectSetCFProperty for connection based property setting. The property is interpreted by the object.
    @param entry The registry entry whose property to set.
    @param propertyName The name of the property as a CFString.
    @param property A CF container - should consist of objects which are understood by IOKit - these are currently : CFDictionary, CFArray, CFSet, CFString, CFData, CFNumber, CFBoolean, and are passed in the kernel as the corresponding OSDictionary etc. objects.
    @result A kern_return_t error code returned by the object. */
@available(macOS 1.0, *)
public func IORegistryEntrySetCFProperty(_ entry: io_registry_entry_t, _ propertyName: CFString!, _ property: CFTypeRef!) -> kern_return_t

/** @function IORegistryEntryGetChildIterator
    @abstract Returns an iterator over an registry entry's child entries in a plane.
    @discussion This method creates an iterator which will return each of a registry entry's child entries in a specified plane.
    @param entry The registry entry whose children to iterate over.
    @param plane The name of an existing registry plane. Plane names are defined in IOKitKeys.h, eg. kIOServicePlane.
    @param iterator The created iterator over the children of the entry, on success. The iterator must be released when the iteration is finished.
    @result A kern_return_t error code. */
public func IORegistryEntryGetChildIterator(_ entry: io_registry_entry_t, _ plane: UnsafePointer<CChar>!, _ iterator: UnsafeMutablePointer<io_iterator_t>!) -> kern_return_t

/** @function IORegistryEntryGetChildEntry
    @abstract Returns the first child of a registry entry in a plane.
    @discussion This function will return the child which first attached to a registry entry in a plane.
    @param entry The registry entry whose child to look up.
    @param plane The name of an existing registry plane. Plane names are defined in IOKitKeys.h, eg. kIOServicePlane.
    @param child The first child of the registry entry, on success. The child must be released by the caller.
    @result A kern_return_t error code. */
public func IORegistryEntryGetChildEntry(_ entry: io_registry_entry_t, _ plane: UnsafePointer<CChar>!, _ child: UnsafeMutablePointer<io_registry_entry_t>!) -> kern_return_t

/** @function IORegistryEntryGetParentIterator
    @abstract Returns an iterator over an registry entry's parent entries in a plane.
    @discussion This method creates an iterator which will return each of a registry entry's parent entries in a specified plane.
    @param entry The registry entry whose parents to iterate over.
    @param plane The name of an existing registry plane. Plane names are defined in IOKitKeys.h, eg. kIOServicePlane.
    @param iterator The created iterator over the parents of the entry, on success. The iterator must be released when the iteration is finished.
    @result A kern_return_t error. */
public func IORegistryEntryGetParentIterator(_ entry: io_registry_entry_t, _ plane: UnsafePointer<CChar>!, _ iterator: UnsafeMutablePointer<io_iterator_t>!) -> kern_return_t

/** @function IORegistryEntryGetParentEntry
    @abstract Returns the first parent of a registry entry in a plane.
    @discussion This function will return the parent to which the registry entry was first attached in a plane.
    @param entry The registry entry whose parent to look up.
    @param plane The name of an existing registry plane. Plane names are defined in IOKitKeys.h, eg. kIOServicePlane.
    @param parent The first parent of the registry entry, on success. The parent must be released by the caller.
    @result A kern_return_t error code. */
public func IORegistryEntryGetParentEntry(_ entry: io_registry_entry_t, _ plane: UnsafePointer<CChar>!, _ parent: UnsafeMutablePointer<io_registry_entry_t>!) -> kern_return_t

/** @function IORegistryEntryInPlane
    @abstract Determines if the registry entry is attached in a plane.
    @discussion This method determines if the entry is attached in a plane to any other entry.
    @param entry The registry entry.
    @param plane The name of an existing registry plane. Plane names are defined in IOKitKeys.h, eg. kIOServicePlane.
    @result If the entry has a parent in the plane, true is returned, otherwise false is returned. */
public func IORegistryEntryInPlane(_ entry: io_registry_entry_t, _ plane: UnsafePointer<CChar>!) -> boolean_t

/** @function IOServiceMatching
    @abstract Create a matching dictionary that specifies an IOService class match.
    @discussion A very common matching criteria for IOService is based on its class. IOServiceMatching will create a matching dictionary that specifies any IOService of a class, or its subclasses. The class is specified by C-string name.
    @param name The class name, as a const C-string. Class matching is successful on IOService's of this class or any subclass.
    @result The matching dictionary created, is returned on success, or zero on failure. The dictionary is commonly passed to IOServiceGetMatchingServices or IOServiceAddNotification which will consume a reference, otherwise it should be released with CFRelease by the caller. */
public func IOServiceMatching(_ name: UnsafePointer<CChar>!) -> CFMutableDictionary!

/** @function IOServiceNameMatching
    @abstract Create a matching dictionary that specifies an IOService name match.
    @discussion A common matching criteria for IOService is based on its name. IOServiceNameMatching will create a matching dictionary that specifies an IOService with a given name. Some IOServices created from the device tree will perform name matching on the standard compatible, name, model properties.
    @param name The IOService name, as a const C-string.
    @result The matching dictionary created, is returned on success, or zero on failure. The dictionary is commonly passed to IOServiceGetMatchingServices or IOServiceAddNotification which will consume a reference, otherwise it should be released with CFRelease by the caller. */
public func IOServiceNameMatching(_ name: UnsafePointer<CChar>!) -> CFMutableDictionary!

/** @function IOBSDNameMatching
    @abstract Create a matching dictionary that specifies an IOService match based on BSD device name.
    @discussion IOServices that represent BSD devices have an associated BSD name. This function creates a matching dictionary that will match IOService's with a given BSD name.
    @param mainPort The main port obtained from IOMainPort(). Pass kIOMainPortDefault to look up the default main port.
    @param options No options are currently defined.
    @param bsdName The BSD name, as a const char *.
    @result The matching dictionary created, is returned on success, or zero on failure. The dictionary is commonly passed to IOServiceGetMatchingServices or IOServiceAddNotification which will consume a reference, otherwise it should be released with CFRelease by the caller. */
public func IOBSDNameMatching(_ mainPort: mach_port_t, _ options: UInt32, _ bsdName: UnsafePointer<CChar>!) -> CFMutableDictionary!

@available(*, deprecated)
public func IOOpenFirmwarePathMatching(_ mainPort: mach_port_t, _ options: UInt32, _ path: UnsafePointer<CChar>!) -> Unmanaged<CFMutableDictionary>!

/** @function IORegistryEntryIDMatching
    @abstract Create a matching dictionary that specifies an IOService match based on a registry entry ID.
    @discussion This function creates a matching dictionary that will match a registered, active IOService found with the given registry entry ID. The entry ID for a registry entry is returned by IORegistryEntryGetRegistryEntryID().
    @param entryID The registry entry ID to be found. 
    @result The matching dictionary created, is returned on success, or zero on failure. The dictionary is commonly passed to IOServiceGetMatchingServices or IOServiceAddNotification which will consume a reference, otherwise it should be released with CFRelease by the caller. */
public func IORegistryEntryIDMatching(_ entryID: UInt64) -> CFMutableDictionary!

@available(*, deprecated)
public func IOServiceOFPathToBSDName(_ mainPort: mach_port_t, _ openFirmwarePath: UnsafePointer<CChar>!, _ bsdName: UnsafeMutablePointer<CChar>!) -> kern_return_t

/** @typedef IOAsyncCallback0
    @abstract standard callback function for asynchronous I/O requests with
    no extra arguments beyond a refcon and result code.
    @param refcon The refcon passed into the original I/O request
    @param result The result of the I/O operation
*/
public typealias IOAsyncCallback0 = @convention(c) (UnsafeMutableRawPointer?, IOReturn) -> Void

/** @typedef IOAsyncCallback1
    @abstract standard callback function for asynchronous I/O requests with
    one extra argument beyond a refcon and result code.
    This is often a count of the number of bytes transferred
    @param refcon The refcon passed into the original I/O request
    @param result The result of the I/O operation
    @param arg0    Extra argument
*/
public typealias IOAsyncCallback1 = @convention(c) (UnsafeMutableRawPointer?, IOReturn, UnsafeMutableRawPointer?) -> Void

/** @typedef IOAsyncCallback2
    @abstract standard callback function for asynchronous I/O requests with
    two extra arguments beyond a refcon and result code.
    @param refcon The refcon passed into the original I/O request
    @param result The result of the I/O operation
    @param arg0    Extra argument
    @param arg1    Extra argument
*/
public typealias IOAsyncCallback2 = @convention(c) (UnsafeMutableRawPointer?, IOReturn, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> Void

/** @typedef IOAsyncCallback
    @abstract standard callback function for asynchronous I/O requests with
    lots of extra arguments beyond a refcon and result code.
    @param refcon The refcon passed into the original I/O request
    @param result The result of the I/O operation
    @param args    Array of extra arguments
    @param numArgs Number of extra arguments
*/
public typealias IOAsyncCallback = @convention(c) (UnsafeMutableRawPointer?, IOReturn, UnsafeMutablePointer<UnsafeMutableRawPointer?>?, UInt32) -> Void

@available(macOS 1.0, *)
public func OSGetNotificationFromMessage(_ msg: UnsafeMutablePointer<mach_msg_header_t>!, _ index: UInt32, _ type: UnsafeMutablePointer<UInt32>!, _ reference: UnsafeMutablePointer<UInt>!, _ content: UnsafeMutablePointer<UnsafeMutableRawPointer?>!, _ size: UnsafeMutablePointer<vm_size_t>!) -> kern_return_t

@available(macOS 1.0, *)
public func IOCatalogueSendData(_ mainPort: mach_port_t, _ flag: UInt32, _ buffer: UnsafePointer<CChar>!, _ size: UInt32) -> kern_return_t

@available(macOS 1.0, *)
public func IOCatalogueTerminate(_ mainPort: mach_port_t, _ flag: UInt32, _ description: UnsafeMutablePointer<CChar>!) -> kern_return_t

@available(macOS 1.0, *)
public func IOCatalogueGetData(_ mainPort: mach_port_t, _ flag: UInt32, _ buffer: UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>!, _ size: UnsafeMutablePointer<UInt32>!) -> kern_return_t

@available(macOS 1.0, *)
public func IOCatalogueModuleLoaded(_ mainPort: mach_port_t, _ name: UnsafeMutablePointer<CChar>!) -> kern_return_t

@available(macOS 1.0, *)
public func IOCatalogueReset(_ mainPort: mach_port_t, _ flag: UInt32) -> kern_return_t

public var kIOBSDKey: String { get }

public var kIOBSDNameKey: String { get }

public var kIOBSDNamesKey: String { get }

public var kIOBSDMajorKey: String { get }

public var kIOBSDMinorKey: String { get }

public var kIOBSDUnitKey: String { get }

/**
 * @typedef IODataQueueEntry
 * @abstract Represents an entry within the data queue
 * @discussion This is a variable sized struct.  The data field simply represents the start of the data region.  The size of the data region is stored in the size field.  The whole size of the specific entry is the size of a UInt32 plus the size of the data region.
 * @field size The size of the following data region.
 * @field data Represents the beginning of the data region.  The address of the data field is a pointer to the start of the data region.
 */
public struct _IODataQueueEntry {

    public init()

    public init(size: UInt32, data: (UInt8, UInt8, UInt8, UInt8))

    public var size: UInt32

    public var data: (UInt8, UInt8, UInt8, UInt8)
}

/**
 * @typedef IODataQueueEntry
 * @abstract Represents an entry within the data queue
 * @discussion This is a variable sized struct.  The data field simply represents the start of the data region.  The size of the data region is stored in the size field.  The whole size of the specific entry is the size of a UInt32 plus the size of the data region.
 * @field size The size of the following data region.
 * @field data Represents the beginning of the data region.  The address of the data field is a pointer to the start of the data region.
 */
public typealias IODataQueueEntry = _IODataQueueEntry

/**
 * @typedef IODataQueueMemory
 * @abstract A struct mapping to the header region of a data queue.
 * @discussion This struct is variable sized.  The struct represents the data queue header information plus a pointer to the actual data queue itself.  The size of the struct is the combined size of the header fields (3 * sizeof(UInt32)) plus the actual size of the queue region.  This size is stored in the queueSize field.
 * @field queueSize The size of the queue region pointed to by the queue field.
 * @field head The location of the queue head.  This field is represented as a byte offset from the beginning of the queue memory region.
 * @field tail The location of the queue tail.  This field is represented as a byte offset from the beginning of the queue memory region.
 * @field queue Represents the beginning of the queue memory region.  The size of the region pointed to by queue is stored in the queueSize field.
 */
public struct _IODataQueueMemory {

    public init()

    public init(queueSize: UInt32, head: UInt32, tail: UInt32, queue: IODataQueueEntry)

    public var queueSize: UInt32

    public var head: UInt32

    public var tail: UInt32

    public var queue: IODataQueueEntry
}

/**
 * @typedef IODataQueueMemory
 * @abstract A struct mapping to the header region of a data queue.
 * @discussion This struct is variable sized.  The struct represents the data queue header information plus a pointer to the actual data queue itself.  The size of the struct is the combined size of the header fields (3 * sizeof(UInt32)) plus the actual size of the queue region.  This size is stored in the queueSize field.
 * @field queueSize The size of the queue region pointed to by the queue field.
 * @field head The location of the queue head.  This field is represented as a byte offset from the beginning of the queue memory region.
 * @field tail The location of the queue tail.  This field is represented as a byte offset from the beginning of the queue memory region.
 * @field queue Represents the beginning of the queue memory region.  The size of the region pointed to by queue is stored in the queueSize field.
 */
public typealias IODataQueueMemory = _IODataQueueMemory

/**
 * @typedef IODataQueueAppendix
 * @abstract A struct mapping to the appendix region of a data queue.
 * @discussion This struct is variable sized dependent on the version.  The struct represents the data queue appendix information.
 * @field version The version of the queue appendix.
 * @field msgh Mach message header containing the notification mach port associated with this queue.
 */
public struct _IODataQueueAppendix {

    public init()

    public init(version: UInt32, msgh: mach_msg_header_t)

    public var version: UInt32

    public var msgh: mach_msg_header_t
}

/**
 * @typedef IODataQueueAppendix
 * @abstract A struct mapping to the appendix region of a data queue.
 * @discussion This struct is variable sized dependent on the version.  The struct represents the data queue appendix information.
 * @field version The version of the queue appendix.
 * @field msgh Mach message header containing the notification mach port associated with this queue.
 */
public typealias IODataQueueAppendix = _IODataQueueAppendix

/**
 * @function IODataQueueDataAvailable
 * @abstract Used to determine if more data is available on the queue.
 * @param dataQueue The IODataQueueMemory region mapped from the kernel.
 * @result Returns true if data is available and false if not.
 */
public func IODataQueueDataAvailable(_ dataQueue: UnsafeMutablePointer<IODataQueueMemory>!) -> Bool

/**
 * @function IODataQueuePeek
 * @abstract Used to peek at the next entry on the queue.
 * @discussion This function can be used to look at the next entry which allows the entry to be received without having to copy it with IODataQueueDequeue.  In order to do this, call IODataQueuePeek to get the entry.  Then call IODataQueueDequeue with a NULL data pointer.  That will cause the head to be moved to the next entry, but no memory to be copied.
 * @param dataQueue The IODataQueueMemory region mapped from the kernel.
 * @result Returns a pointer to the next IODataQueueEntry if one is available.  Zero is returned if the queue is empty.
 */
public func IODataQueuePeek(_ dataQueue: UnsafeMutablePointer<IODataQueueMemory>!) -> UnsafeMutablePointer<IODataQueueEntry>!

/**
 * @function IODataQueueDequeue
 * @abstract Dequeues the next available entry on the queue and copies it into the given data pointer.
 * @discussion This function will dequeue the next available entry on the queue.  If a data pointer is provided, it will copy the data into the memory region if there is enough space available as specified in the dataSize parameter.  If no data pointer is provided, it will simply move the head value past the current entry.
 * @param dataQueue The IODataQueueMemory region mapped from the kernel.
 * @param data A pointer to the data memory region in which to copy the next entry data on the queue.  If this parameter is 0 (NULL), it will simply move to the next entry.
 * @param dataSize A pointer to the size of the data parameter.  On return, this contains the size of the actual entry data - even if the original size was not large enough.
 * @result Returns kIOReturnSuccess on success.  Other return values possible are: kIOReturnUnderrun - queue is empty, kIOReturnBadArgument - no dataQueue or no dataSize, kIOReturnNoSpace - dataSize is too small for entry.
 */
public func IODataQueueDequeue(_ dataQueue: UnsafeMutablePointer<IODataQueueMemory>!, _ data: UnsafeMutableRawPointer!, _ dataSize: UnsafeMutablePointer<UInt32>!) -> IOReturn

/**
 * @function IODataQueueWaitForAvailableData
 * @abstract Wait for an incoming dataAvailable message on the given notifyPort.
 * @discussion This method will simply wait for an incoming message on the given notifyPort.  Once it is received, the return from mach_msg() is returned.
 * @param dataQueue The IODataQueueMemory region mapped from the kernel.
 * @param notificationPort Mach port on which to listen for incoming messages.
 * @result Returns kIOReturnSuccess on success.  Returns kIOReturnBadArgument if either dataQueue is 0 (NULL) or notifyPort is MACH_PORT_NULL.  Returns the result of the mach_msg() listen call on the given port.
 */
public func IODataQueueWaitForAvailableData(_ dataQueue: UnsafeMutablePointer<IODataQueueMemory>!, _ notificationPort: mach_port_t) -> IOReturn

/**
 * @function IODataQueueAllocateNotificationPort
 * @abstract Allocates and returns a new mach port able to receive data available notifications from an IODataQueue.
 * @discussion This port is intended to be passed down into the kernel and into an IODataQueue to allow it to send the appropriate notification.  The returned mach port is allocated with a queue limit of one message.  This allows only one mach message to be queued up at a time.  The IODataQueue code is written with the restriction in mind and will only queue up a message if no messages alread have been sent.
 * @result Returns a newly allocated mach port on success.  On failure, it returns MACH_PORT_NULL.
 */
public func IODataQueueAllocateNotificationPort() -> mach_port_t

/**
 * @function IODataQueueEnqueue
 * @abstract Enqueues a new entry on the queue.
 * @discussion This method adds a new data entry of dataSize to the queue.  It sets the size parameter of the entry pointed to by the tail value and copies the memory pointed to by the data parameter in place in the queue.  Once that is done, it moves the tail to the next available location.  When attempting to add a new entry towards the end of the queue and there isn't enough space at the end, it wraps back to the beginning.<br>  If the queue is empty when a new entry is added, the port specified in IODataQueueSetNotificationPort will be used to send a message to the client process that data is now available. <br> <b>Please note that using this method without mapped memory create from an IOSharedDataQueue will result in undefined behavior. </b>
 * @param dataQueue The IODataQueueMemory region mapped from the kernel created from an IOSharedDataQueue.
 * @param data Pointer to the data to be added to the queue.
 * @param dataSize Size of the data pointed to by data.
 * @result Returns kIOReturnSuccess on success.  Other return values possible are: kIOReturnOverrun - queue is full.
 */
@available(macOS 10.5, *)
public func IODataQueueEnqueue(_ dataQueue: UnsafeMutablePointer<IODataQueueMemory>!, _ data: UnsafeMutableRawPointer!, _ dataSize: UInt32) -> IOReturn

/**
 * @function IODataQueueSetNotificationPort
 * @abstract Creates a simple mach message targeting the mach port specified in port.
 * @discussion This message is sent when data is added to an empty queue.  It is to notify another user process that new data has become available.  <b>Please note that using this method without mapped memory create from an IOSharedDataQueue will result in undefined behavior. </b>
 * @param dataQueue The IODataQueueMemory region mapped from the kernel created from an IOSharedDataQueue.
 * @param notifyPort The mach port to target with the notification message.
 * @result Returns kIOReturnSuccess on success.  Returns kIOReturnBadArgument if either dataQueue is 0 (NULL).
 */
@available(macOS 10.5, *)
public func IODataQueueSetNotificationPort(_ dataQueue: UnsafeMutablePointer<IODataQueueMemory>!, _ notifyPort: mach_port_t) -> IOReturn

public var kIOBundleInfoDictionaryVersionKey: String { get }

public var kIOBundleExecutableKey: String { get }

public var kIOBundleIdentifierKey: String { get }

public var kIOBundleVersionKey: String { get }

public var kIOBundleDevelopmentRegionKey: String { get }

public var kIOBundleNameKey: String { get }

public struct IOCFPlugInInterfaceStruct {

    public init()

    public init(_reserved: UnsafeMutableRawPointer!, QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!, AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!, version: UInt16, revision: UInt16, Probe: (@convention(c) (UnsafeMutableRawPointer?, CFDictionary?, io_service_t, UnsafeMutablePointer<Int32>?) -> IOReturn)!, Start: (@convention(c) (UnsafeMutableRawPointer?, CFDictionary?, io_service_t) -> IOReturn)!, Stop: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!)

    public var _reserved: UnsafeMutableRawPointer!

    public var QueryInterface: (@convention(c) (UnsafeMutableRawPointer?, REFIID, UnsafeMutablePointer<LPVOID?>?) -> HRESULT)!

    public var AddRef: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var Release: (@convention(c) (UnsafeMutableRawPointer?) -> ULONG)!

    public var version: UInt16

    public var revision: UInt16

    public var Probe: (@convention(c) (UnsafeMutableRawPointer?, CFDictionary?, io_service_t, UnsafeMutablePointer<Int32>?) -> IOReturn)!

    public var Start: (@convention(c) (UnsafeMutableRawPointer?, CFDictionary?, io_service_t) -> IOReturn)!

    public var Stop: (@convention(c) (UnsafeMutableRawPointer?) -> IOReturn)!
}

public typealias IOCFPlugInInterface = IOCFPlugInInterfaceStruct

public func IOCreatePlugInInterfaceForService(_ service: io_service_t, _ pluginType: CFUUID!, _ interfaceType: CFUUID!, _ theInterface: UnsafeMutablePointer<UnsafeMutablePointer<UnsafeMutablePointer<IOCFPlugInInterface>?>?>!, _ theScore: UnsafeMutablePointer<Int32>!) -> kern_return_t

public func IODestroyPlugInInterface(_ interface: UnsafeMutablePointer<UnsafeMutablePointer<IOCFPlugInInterface>?>!) -> kern_return_t

public var kIOCFSerializeToBinary: Int { get }

public func IOCFSerialize(_ object: CFTypeRef!, _ options: CFOptionFlags) -> CFData!

public func IOURLCreatePropertyFromResource(_ alloc: CFAllocator!, _ url: CFURL!, _ property: CFString!, _ errorCode: UnsafeMutablePointer<Int32>!) -> Unmanaged<CFTypeRef>!

public func IOURLCreateDataAndPropertiesFromResource(_ alloc: CFAllocator!, _ url: CFURL!, _ resourceData: UnsafeMutablePointer<Unmanaged<CFData>?>!, _ properties: UnsafeMutablePointer<Unmanaged<CFDictionary>?>!, _ desiredProperties: CFArray!, _ errorCode: UnsafeMutablePointer<Int32>!) -> Bool

public func IOURLWriteDataAndPropertiesToResource(_ url: CFURL!, _ dataToWrite: CFData!, _ propertiesToWrite: CFDictionary!, _ errorCode: UnsafeMutablePointer<Int32>!) -> Bool

public var kIOURLFileExists: String { get }

public var kIOURLFileDirectoryContents: String { get }

public var kIOURLFileLength: String { get }

public var kIOURLFileLastModificationTime: String { get }

public var kIOURLFilePOSIXMode: String { get }

public var kIOURLFileOwnerID: String { get }

public struct IOURLError : Hashable, Equatable, RawRepresentable {

    public init(_ rawValue: Int32)

    public init(rawValue: Int32)

    public var rawValue: Int32
}

public var kIOURLUnknownError: IOURLError { get }

public var kIOURLUnknownSchemeError: IOURLError { get }

public var kIOURLResourceNotFoundError: IOURLError { get }

public var kIOURLResourceAccessViolationError: IOURLError { get }

public var kIOURLRemoteHostUnavailableError: IOURLError { get }

public var kIOURLImproperArgumentsError: IOURLError { get }

public var kIOURLUnknownPropertyKeyError: IOURLError { get }

public var kIOURLPropertyKeyUnavailableError: IOURLError { get }

public var kIOURLTimeoutError: IOURLError { get }

public var kIOCatalogAddDrivers: Int { get }

public var kIOCatalogAddDriversNoMatch: Int { get }

public var kIOCatalogRemoveDrivers: Int { get }

public var kIOCatalogRemoveDriversNoMatch: Int { get }

public var kIOCatalogStartMatching__Removed: Int { get }

public var kIOCatalogRemoveKernelLinker__Removed: Int { get }

public var kIOCatalogKextdActive: Int { get }

public var kIOCatalogKextdFinishedLaunching: Int { get }

public var kIOCatalogResetDrivers: Int { get }

public var kIOCatalogResetDriversNoMatch: Int { get }

public var kIOCatalogGetContents: Int { get }

public var kIOCatalogGetModuleDemandList: Int { get }

public var kIOCatalogGetCacheMissList: Int { get }

public var kIOCatalogGetROMMkextList: Int { get }

public var kIOCatalogResetDefault: Int { get }

public var kIOCatalogModuleUnload: Int { get }

public var kIOCatalogModuleTerminate: Int { get }

public var kIOCatalogServiceTerminate: Int { get }

public func IOCFUnserialize(_ buffer: UnsafePointer<CChar>!, _ allocator: CFAllocator!, _ options: CFOptionFlags, _ errorString: UnsafeMutablePointer<Unmanaged<CFString>?>!) -> CFTypeRef!

public func IOCFUnserializeBinary(_ buffer: UnsafePointer<CChar>!, _ bufferSize: Int, _ allocator: CFAllocator!, _ options: CFOptionFlags, _ errorString: UnsafeMutablePointer<Unmanaged<CFString>?>!) -> CFTypeRef!

public func IOCFUnserializeWithSize(_ buffer: UnsafePointer<CChar>!, _ bufferSize: Int, _ allocator: CFAllocator!, _ options: CFOptionFlags, _ errorString: UnsafeMutablePointer<Unmanaged<CFString>?>!) -> CFTypeRef!

/**
 * @header IOMessage.h
 *
 * Defines message type constants for several IOKit messaging API's.
 *
 */
public typealias IOMessage = UInt32

public typealias OSObjectRef = UInt64

public var kIORPCVersion190615: Int { get }

public var kIORPCVersion190615Reply: Int { get }

public var kIORPCMessageRemote: Int { get }

public var kIORPCMessageLocalHost: Int { get }

public var kIORPCMessageKernel: Int { get }

public var kIORPCMessageOneway: Int { get }

public var kIORPCMessageObjectRefs: Int { get }

public var kIORPCMessageOnqueue: Int { get }

public var kIORPCMessageError: Int { get }

public var kIORPCMessageSimpleReply: Int { get }

public var kIORPCMessageIDKernel: UInt { get }

public struct IORPCMessageMach {

    public init()

    public init(msgh: mach_msg_header_t, msgh_body: mach_msg_body_t, objects: ())

    public var msgh: mach_msg_header_t

    public var msgh_body: mach_msg_body_t

    public var objects: ()
}

public struct IORPCMessage {

    public init()

    public init(msgid: UInt64, flags: UInt64, objectRefs: UInt64, objects: ())

    public var msgid: UInt64

    public var flags: UInt64

    public var objectRefs: UInt64

    public var objects: ()
}

public func IORPCMessageFromMach(_ msg: UnsafeMutablePointer<IORPCMessageMach>!, _ reply: Bool) -> UnsafeMutablePointer<IORPCMessage>!

public struct IORPCMessageErrorReturnContent {

    public init()

    public init(hdr: IORPCMessage, result: kern_return_t, pad: UInt32)

    public var hdr: IORPCMessage

    public var result: kern_return_t

    public var pad: UInt32
}

public struct IORPCMessageErrorReturn {

    public init()

    public init(mach: IORPCMessageMach, content: IORPCMessageErrorReturnContent)

    public var mach: IORPCMessageMach

    public var content: IORPCMessageErrorReturnContent
}

public struct IORPC {

    public init()

    public init(message: UnsafeMutablePointer<IORPCMessageMach>!, reply: UnsafeMutablePointer<IORPCMessageMach>!, sendSize: UInt32, replySize: UInt32)

    public var message: UnsafeMutablePointer<IORPCMessageMach>!

    public var reply: UnsafeMutablePointer<IORPCMessageMach>!

    public var sendSize: UInt32

    public var replySize: UInt32
}

public var kOSClassCanRemote: Int { get }

public struct OSClassDescription {

    public init()

    public init(descriptionSize: UInt32, name: (CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar), superName: (CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar), methodOptionsSize: UInt32, methodOptionsOffset: UInt32, metaMethodOptionsSize: UInt32, metaMethodOptionsOffset: UInt32, queueNamesSize: UInt32, queueNamesOffset: UInt32, methodNamesSize: UInt32, methodNamesOffset: UInt32, metaMethodNamesSize: UInt32, metaMethodNamesOffset: UInt32, flags: UInt64, resv1: (UInt64, UInt64, UInt64, UInt64, UInt64, UInt64, UInt64, UInt64), methodOptions: (), metaMethodOptions: (), dispatchNames: (), methodNames: (), metaMethodNames: ())

    public var descriptionSize: UInt32

    public var name: (CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar)

    public var superName: (CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar, CChar)

    public var methodOptionsSize: UInt32

    public var methodOptionsOffset: UInt32

    public var metaMethodOptionsSize: UInt32

    public var metaMethodOptionsOffset: UInt32

    public var queueNamesSize: UInt32

    public var queueNamesOffset: UInt32

    public var methodNamesSize: UInt32

    public var methodNamesOffset: UInt32

    public var metaMethodNamesSize: UInt32

    public var metaMethodNamesOffset: UInt32

    public var flags: UInt64

    public var resv1: (UInt64, UInt64, UInt64, UInt64, UInt64, UInt64, UInt64, UInt64)

    public var methodOptions: ()

    public var metaMethodOptions: ()

    public var dispatchNames: ()

    public var methodNames: ()

    public var metaMethodNames: ()
}

public var kIOUserServerClassKey: String { get }

public var kIOUserServerNameKey: String { get }

public var kIOUserServerTagKey: String { get }

/// Operation aborted
public var kIOReturnAborted: IOReturn { get }

/// Invalid argument
public var kIOReturnBadArgument: IOReturn { get }

/// Media error
public var kIOReturnBadMedia: IOReturn { get }

/// Sent/received messages had different msg_id
public var kIOReturnBadMessageID: IOReturn { get }

/// Device busy
public var kIOReturnBusy: IOReturn { get }

/// Can't acquire lock
public var kIOReturnCannotLock: IOReturn { get }

/// Can't wire down physical memory
public var kIOReturnCannotWire: IOReturn { get }

/// DMA failure
public var kIOReturnDMAError: IOReturn { get }

/// The device is not working properly
public var kIOReturnDeviceError: IOReturn { get }

/// General error
public var kIOReturnError: IOReturn { get }

/// Exclusive access and device already open
public var kIOReturnExclusiveAccess: IOReturn { get }

/// General I/O error
public var kIOReturnIOError: IOReturn { get }

/// Error during IPC
public var kIOReturnIPCError: IOReturn { get }

/// Internal error
public var kIOReturnInternalError: IOReturn { get }

/// Should never be seen
public var kIOReturnInvalid: IOReturn { get }

/// Isochronous I/O request for distant future
public var kIOReturnIsoTooNew: IOReturn { get }

/// Isochronous I/O request for distant past
public var kIOReturnIsoTooOld: IOReturn { get }

/// Device read locked
public var kIOReturnLockedRead: IOReturn { get }

/// Device write locked
public var kIOReturnLockedWrite: IOReturn { get }

/// Oversized msg received on interrupt port
public var kIOReturnMessageTooLarge: IOReturn { get }

/// Bus bandwidth would be exceeded
public var kIOReturnNoBandwidth: IOReturn { get }

/// No DMA channels left
public var kIOReturnNoChannels: IOReturn { get }

/// A completion routine is required
public var kIOReturnNoCompletion: IOReturn { get }

/// No such device
public var kIOReturnNoDevice: IOReturn { get }

/// No DMA frames enqueued
public var kIOReturnNoFrames: IOReturn { get }

/// No interrupt attached
public var kIOReturnNoInterrupt: IOReturn { get }

/// Media not present
public var kIOReturnNoMedia: IOReturn { get }

/// Can't allocate memory
public var kIOReturnNoMemory: IOReturn { get }

/// No power to device
public var kIOReturnNoPower: IOReturn { get }

/// Resource shortage
public var kIOReturnNoResources: IOReturn { get }

/// No space for data
public var kIOReturnNoSpace: IOReturn { get }

/// Alignment error
public var kIOReturnNotAligned: IOReturn { get }

/// Device not attached
public var kIOReturnNotAttached: IOReturn { get }

/// Data was not found
public var kIOReturnNotFound: IOReturn { get }

/// Device not open
public var kIOReturnNotOpen: IOReturn { get }

/// Not permitted
public var kIOReturnNotPermitted: IOReturn { get }

/// Privilege violation
public var kIOReturnNotPrivileged: IOReturn { get }

/// Read not supported
public var kIOReturnNotReadable: IOReturn { get }

/// Not ready
public var kIOReturnNotReady: IOReturn { get }

/// Device not responding
public var kIOReturnNotResponding: IOReturn { get }

/// Write not supported
public var kIOReturnNotWritable: IOReturn { get }

/// Device offline
public var kIOReturnOffline: IOReturn { get }

/// Data overrun
public var kIOReturnOverrun: IOReturn { get }

/// Port already exists
public var kIOReturnPortExists: IOReturn { get }

/// RLD failure
public var kIOReturnRLDError: IOReturn { get }

/// Device(s) still open
public var kIOReturnStillOpen: IOReturn { get }

/// I/O timeout
public var kIOReturnTimeout: IOReturn { get }

/// Data underrun
public var kIOReturnUnderrun: IOReturn { get }

/// media not formatted
public var kIOReturnUnformattedMedia: IOReturn { get }

/// Unsupported function
public var kIOReturnUnsupported: IOReturn { get }

/// No such mode
public var kIOReturnUnsupportedMode: IOReturn { get }

/// Misc. VM failure
public var kIOReturnVMError: IOReturn { get }

/// General error
public let kIOReturnError: IOReturn { get }

/// Can't allocate memory
public let kIOReturnNoMemory: IOReturn { get }

/// Resource shortage
public let kIOReturnNoResources: IOReturn { get }

/// Error during IPC
public let kIOReturnIPCError: IOReturn { get }

/// No such device
public let kIOReturnNoDevice: IOReturn { get }

/// Privilege violation
public let kIOReturnNotPrivileged: IOReturn { get }

/// Invalid argument
public let kIOReturnBadArgument: IOReturn { get }

/// Device read locked
public let kIOReturnLockedRead: IOReturn { get }

/// Device write locked
public let kIOReturnLockedWrite: IOReturn { get }

/// Exclusive access and device already open
public let kIOReturnExclusiveAccess: IOReturn { get }

/// Sent/received messages had different msg_id
public let kIOReturnBadMessageID: IOReturn { get }

/// Unsupported function
public let kIOReturnUnsupported: IOReturn { get }

/// Misc. VM failure
public let kIOReturnVMError: IOReturn { get }

/// Internal error
public let kIOReturnInternalError: IOReturn { get }

/// General I/O error
public let kIOReturnIOError: IOReturn { get }

/// Can't acquire lock
public let kIOReturnCannotLock: IOReturn { get }

/// Device not open
public let kIOReturnNotOpen: IOReturn { get }

/// Read not supported
public let kIOReturnNotReadable: IOReturn { get }

/// Write not supported
public let kIOReturnNotWritable: IOReturn { get }

/// Alignment error
public let kIOReturnNotAligned: IOReturn { get }

/// Media error
public let kIOReturnBadMedia: IOReturn { get }

/// Device(s) still open
public let kIOReturnStillOpen: IOReturn { get }

/// RLD failure
public let kIOReturnRLDError: IOReturn { get }

/// DMA failure
public let kIOReturnDMAError: IOReturn { get }

/// Device busy
public let kIOReturnBusy: IOReturn { get }

/// I/O timeout
public let kIOReturnTimeout: IOReturn { get }

/// Device offline
public let kIOReturnOffline: IOReturn { get }

/// Not ready
public let kIOReturnNotReady: IOReturn { get }

/// Device not attached
public let kIOReturnNotAttached: IOReturn { get }

/// No DMA channels left
public let kIOReturnNoChannels: IOReturn { get }

/// No space for data
public let kIOReturnNoSpace: IOReturn { get }

/// Port already exists
public let kIOReturnPortExists: IOReturn { get }

/// Can't wire down physical memory
public let kIOReturnCannotWire: IOReturn { get }

/// No interrupt attached
public let kIOReturnNoInterrupt: IOReturn { get }

/// No DMA frames enqueued
public let kIOReturnNoFrames: IOReturn { get }

/// Oversized msg received on interrupt port
public let kIOReturnMessageTooLarge: IOReturn { get }

/// Not permitted
public let kIOReturnNotPermitted: IOReturn { get }

/// No power to device
public let kIOReturnNoPower: IOReturn { get }

/// Media not present
public let kIOReturnNoMedia: IOReturn { get }

/// media not formatted
public let kIOReturnUnformattedMedia: IOReturn { get }

/// No such mode
public let kIOReturnUnsupportedMode: IOReturn { get }

/// Data underrun
public let kIOReturnUnderrun: IOReturn { get }

/// Data overrun
public let kIOReturnOverrun: IOReturn { get }

/// The device is not working properly
public let kIOReturnDeviceError: IOReturn { get }

/// A completion routine is required
public let kIOReturnNoCompletion: IOReturn { get }

/// Operation aborted
public let kIOReturnAborted: IOReturn { get }

/// Bus bandwidth would be exceeded
public let kIOReturnNoBandwidth: IOReturn { get }

/// Device not responding
public let kIOReturnNotResponding: IOReturn { get }

/// Isochronous I/O request for distant past
public let kIOReturnIsoTooOld: IOReturn { get }

/// Isochronous I/O request for distant future
public let kIOReturnIsoTooNew: IOReturn { get }

/// Data was not found
public let kIOReturnNotFound: IOReturn { get }

/// Should never be seen
public let kIOReturnInvalid: IOReturn { get }

