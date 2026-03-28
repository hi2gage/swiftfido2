import Foundation
import Testing

@testable import swiftfido2Core

@Suite("CTAPHIDCborFrame")
struct CTAPHIDCborFrameTests {

	@Test("small payload fits in a single packet")
	func singlePacket() {
		let frame = CTAPHIDCborFrame(
			channelId: 0x1234_5678,
			command: 0x10,  // CBOR
			payload: Data([0x04])  // getInfo
		)

		let packets = frame.packets
		#expect(packets.count == 1)
		#expect(packets[0].count == 64)

		// Channel ID in big-endian
		#expect(packets[0][0] == 0x12)
		#expect(packets[0][1] == 0x34)
		#expect(packets[0][2] == 0x56)
		#expect(packets[0][3] == 0x78)

		// Command with high bit set
		#expect(packets[0][4] == 0x90)  // 0x80 | 0x10

		// Payload length = 1
		#expect(packets[0][5] == 0x00)
		#expect(packets[0][6] == 0x01)

		// Payload
		#expect(packets[0][7] == 0x04)
	}

	@Test("large payload splits into continuation packets")
	func multiplePackets() {
		// 64 - 7 = 57 bytes in first packet, then 64 - 5 = 59 bytes per continuation
		// 120 bytes total: first packet takes 57, second takes 59, needs 2 packets for remaining 4
		let payload = Data(repeating: 0xAB, count: 120)
		let frame = CTAPHIDCborFrame(
			channelId: 0xAABB_CCDD,
			command: 0x10,
			payload: payload
		)

		let packets = frame.packets
		#expect(packets.count == 3)  // 57 + 59 + 4

		// First packet: init frame
		#expect(packets[0][4] == 0x90)  // command with high bit
		#expect(packets[0][5] == 0x00)
		#expect(packets[0][6] == 120)  // payload length

		// Second packet: continuation, seq 0
		#expect(packets[1][4] == 0x00)  // seq 0

		// Third packet: continuation, seq 1
		#expect(packets[2][4] == 0x01)  // seq 1

		// All packets are 64 bytes (padded)
		for packet in packets {
			#expect(packet.count == 64)
		}
	}

	@Test("empty payload produces single packet")
	func emptyPayload() {
		let frame = CTAPHIDCborFrame(
			channelId: 0x0000_0001,
			command: 0x10,
			payload: Data()
		)

		let packets = frame.packets
		#expect(packets.count == 1)
		#expect(packets[0].count == 64)
		#expect(packets[0][5] == 0x00)  // length hi
		#expect(packets[0][6] == 0x00)  // length lo
	}
}
