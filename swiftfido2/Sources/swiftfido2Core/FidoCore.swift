//
//  FidoCore.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import Foundation
import IOKit

public final class FidoCore: Sendable {

	public init() {}

	public func initializeDevice(_ context: UninitializedFidoContext) async throws
		-> FidoDeviceContext
	{
		let nonce = NonceGenerator.randomBytes(count: CTAPHIDSpec.nonceLength)

		let initFrame = CTAPHIDFramer.buildInitialFrame(
			channelId: CTAPHIDSpec.broadcastChannelId,
			nonce: nonce,
			reportSize: context.device.outputReportSize
		)

		let report = initFrame.asHIDReport()
		try context.transport.sendReport(report)

		let rawReport = try await context.transport.readAsync(timeoutMs: 1000)

		let payload = try CTAPHIDInitPayload(rawReport: rawReport)

		try payload.assertValidNonce(nonce)

		return FidoDeviceContext(from: context, channelId: payload.channelId)
	}
}
