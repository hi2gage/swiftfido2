//
//  UninitializedFidoContext.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

public struct UninitializedFidoContext {
	let device: UninitializedFidoDevice
	let transport: HIDTransport
	let buffer: Buffer

	init(device: UninitializedFidoDevice, transport: HIDTransport, buffer: Buffer) {
		self.device = device
		self.transport = transport
		self.buffer = buffer
	}
}
