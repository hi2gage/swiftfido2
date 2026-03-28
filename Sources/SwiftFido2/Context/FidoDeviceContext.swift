//
//  FidoDeviceContext.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

public struct FidoDeviceContext {
	let device: FidoDeviceHandle
	let transport: HIDTransport

	public var channelId: UInt32 { device.channelId }

	init(device: FidoDeviceHandle, transport: HIDTransport) {
		self.device = device
		self.transport = transport
	}

	init(from context: UninitializedFidoContext, channelId: UInt32) {
		device = FidoDeviceHandle(from: context.device, channelId: channelId)
		transport = context.transport
	}

	public func close() {
		transport.close()
	}
}
