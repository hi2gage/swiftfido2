//
//  XCTMemoryChecker.swift
//  swiftfido2
//
//  Created by Gage Halverson on 4/25/25.
//

import XCTest

final class XCTMemoryChecker: XCTestCase, @unchecked Sendable {
	var some: LeakyClass!

	lazy var tracker = Memory(self)

	func setUpCustom() async {
		await tracker(\.some, LeakyClass())
	}

	override func tearDown() {
		some = nil
	}

	func testExample() async throws {
		await setUpCustom()

		some.doSomething()

		trackForMemoryLeak(instance: some)
		some = nil

	}
}

extension XCTestCase {
	func trackForMemoryLeak<T: AnyObject>(
		instance: T,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		let weakBox = WeakBox(instance)
		addTeardownBlock {
			XCTAssertNil(
				weakBox.value,
				"💥 Potential memory leak: \(String(describing: weakBox.value))",
				file: file,
				line: line
			)
		}

	}
}

final class WeakBox<T: AnyObject>: @unchecked Sendable {
	weak var value: T?

	init(_ value: T) {
		self.value = value
	}
}

final class Memory<Root: XCTestCase & Sendable>: @unchecked Sendable {
	private weak var root: Root?
	private var checks: [LeakCheck] = []

	init(_ root: Root) {
		self.root = root
	}

	@MainActor
	@discardableResult
	func callAsFunction<T: AnyObject>(
		_ keyPath: ReferenceWritableKeyPath<Root, T?>,
		_ instance: @autoclosure () -> T,
		file: StaticString = #file,
		line: UInt = #line
	) -> T {
		guard let root else {
			fatalError("Memory tracker root is nil")
		}

		let object = instance()
		let weakBox = WeakBox(object)

		root.addTeardownBlock { [weak root, file, line] in
			root?[keyPath: keyPath] = nil
			if weakBox.value != nil {
				XCTFail("💥 Object leaked!", file: file, line: line)
			}
		}

		root[keyPath: keyPath] = object
		return object
	}

	private func assertNoLeaks(file: StaticString = #file, line: UInt = #line) {
		for check in checks {
			if check.isLeaking {
				XCTFail(
					"💥 Potential memory leak detected",
					file: check.file,
					line: check.line
				)
			}
		}
	}

	private struct LeakCheck: @unchecked Sendable {
		private weak var weakRef: AnyObject?
		let file: StaticString
		let line: UInt

		init(weakRef: AnyObject? = nil, file: StaticString, line: UInt) {
			self.weakRef = weakRef
			self.file = file
			self.line = line
		}

		var isLeaking: Bool { weakRef != nil }
	}
}
