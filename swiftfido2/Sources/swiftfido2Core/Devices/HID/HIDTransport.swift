//
//  File.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/19/25.
//

@preconcurrency import Foundation

final class HIDTransport: Sendable {
	let device: IOHIDDevice
	let reportLen: Int

	//    let buffer: UnsafeMutablePointer<UInt8>
	let bufferLength: Int

	let pipeFds: (read: Int32, write: Int32)

	init(
		device: IOHIDDevice,
		reportLen: Int,
		bufferLength: Int,
		pipeFds: (read: Int32, write: Int32)
	) {
		self.device = device
		self.reportLen = reportLen
		//        self.buffer = .allocate(capacity: bufferLength)
		self.bufferLength = bufferLength
		self.pipeFds = pipeFds
	}

	//    deinit {
	//        buffer.deallocate()
	//        close(pipeFds.read)
	//        close(pipeFds.write)
	//    }

	enum HIDError: Error {
		case timeout
		case ioError(errno: Int32)
		case invalidLength(expected: Int, actual: Int)
	}

	func sendReport(_ report: HIDReport) throws {
		let result = report.data.withUnsafeBytes { buf -> IOReturn in
			IOHIDDeviceSetReport(
				device,
				report.reportType,
				report.reportID,
				buf.bindMemory(to: UInt8.self).baseAddress!,
				buf.count
			)
		}
		guard result == kIOReturnSuccess else {
			throw CTAPHIDError.txError(result)
		}
	}

	func sendReportPackets(_ report: HIDPackageReport) throws {
		try sendReportPackets(
			report.packets,
			reportID: report.reportID,
			reportType: report.reportType
		)
	}

	private func sendReportPackets(
		_ frames: [Data],
		reportID: CFIndex = 0,
		reportType: IOHIDReportType = kIOHIDReportTypeOutput
	) throws {
		for (i, frame) in frames.enumerated() {
			let rpt = HIDReport(
				reportID: reportID,
				reportType: reportType,
				data: frame
			)
			try sendReport(rpt)
			print("📨 Sent packet \(i)")
		}
	}

	func readAsync(timeoutMs: Int) async throws -> Data {
		return try await withCheckedThrowingContinuation { cont in
			// offload to a background thread so we don't block the actor
			Task.detached {
				do {
					let data = try self.readBlocking(timeoutMs: timeoutMs)
					cont.resume(returning: data)
				} catch {
					cont.resume(throwing: error)
				}
			}
		}
	}

	private func readBlocking(timeoutMs: Int) throws -> Data {
		// 1) pump your run‑loop so the IO callback can fire
		Self.scheduleIOLoop(device: device, ms: 100)

		// 2) wait via poll()
		var pfd = pollfd(fd: pipeFds.read, events: Int16(POLLIN), revents: 0)
		let r = poll(&pfd, 1, Int32(timeoutMs))
		if r < 0 {
			throw HIDError.ioError(errno: errno)
		}
		if r == 0 {
			throw HIDError.timeout
		}

		// 3) now actually read whatever’s pending
		var buf = [UInt8](repeating: 0, count: reportLen)
		let n = read(pipeFds.read, &buf, reportLen)
		if n < 0 {
			throw HIDError.ioError(errno: errno)
		}

		// 4) return exactly what you got
		return Data(buf.prefix(n))
	}

	static func scheduleIOLoop(device: IOHIDDevice, ms: Int) {
		let loopID = CFRunLoopMode.defaultMode.rawValue
		// Schedule the device with the current run loop
		IOHIDDeviceScheduleWithRunLoop(device, CFRunLoopGetCurrent(), loopID)

		let timeout: Double = (ms == -1) ? 5.0 : Double(ms) / 1000.0

		// Run the current run loop for the specified timeout
		CFRunLoopRunInMode(CFRunLoopMode.defaultMode, timeout, true)

		// Unschedule the device from the current run loop
		IOHIDDeviceUnscheduleFromRunLoop(device, CFRunLoopGetCurrent(), loopID)
	}
}
