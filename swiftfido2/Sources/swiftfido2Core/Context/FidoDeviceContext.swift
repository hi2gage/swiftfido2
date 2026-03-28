//
//  FidoDeviceContext.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

public struct FidoDeviceContext {
	let device: FidoDeviceHandle
	let transport: HIDTransport
	let buffer: Buffer

	init(device: FidoDeviceHandle, transport: HIDTransport, buffer: Buffer) {
		self.device = device
		self.transport = transport
		self.buffer = buffer
	}

	init(from context: UninitializedFidoContext, channelId: UInt32) {
		device = FidoDeviceHandle(from: context.device, channelId: channelId)
		transport = context.transport
		buffer = context.buffer
	}
}

class Buffer {
	let buffer: UnsafeMutablePointer<UInt8>
	let bufferLength: Int
	let pipeFds: (read: Int32, write: Int32)

	init(bufferLength: Int, pipeFds: (read: Int32, write: Int32)) {
		self.bufferLength = bufferLength
		self.buffer = .allocate(capacity: bufferLength)
		self.pipeFds = pipeFds
	}
}
