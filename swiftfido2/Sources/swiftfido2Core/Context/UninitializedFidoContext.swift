//
//  UninitializedFidoContext.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

package struct UninitializedFidoContext {
	let device: UninitializedFidoDevice
	let transport: HIDTransport

	init(device: UninitializedFidoDevice, transport: HIDTransport) {
		self.device = device
		self.transport = transport
	}
}
