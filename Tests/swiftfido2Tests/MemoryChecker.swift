import Testing

struct TestsSuite {
	@Test
	func testMemoryLeak() async throws {
		LeakChecker { checker in
			let some = checker.checkForMemoryLeak(LeakyClass())
			some.doSomething()
		}
	}

	@Test(.leakChecker)
	func testMemoryLeak2() async throws {
		let instance = trackLeak(LeakyClass())
		instance.doSomething()
	}
}

func trackLeak<T: AnyObject & Sendable>(
	_ instance: @autoclosure () -> T,
	fileID: String = #fileID,
	filePath: String = #filePath,
	line: Int = #line,
	column: Int = #column
) -> T {
	guard let checker = LeakCheckerTrait.current else {
		#expect(
			Bool(false),
			"trackLeak used outside of `.leakChecker` test trait",
			sourceLocation: .init(
				fileID: fileID,
				filePath: filePath,
				line: line,
				column: column
			)
		)

		return instance()
	}
	return checker.checkForMemoryLeak(
		fileID: fileID,
		filePath: filePath,
		line: line,
		column: column,
		instance()
	)
}

final class LeakyClass: @unchecked Sendable {
	private var closure: (() -> Void)?
	private var message: String

	init(message: String = "Leaking...") {
		self.message = message

		// Captures self strongly, forming a retain cycle
		self.closure = { [self] in
			log()
		}
	}

	func doSomething() {
		// This async task holds the closure reference, which holds self
		Task.detached { [self] in
			// Simulate async work
			try? await Task.sleep(nanoseconds: 100_000_000)
			self.closure?()
		}
	}

	private func log() {
		print("LeakyClass: \(message)")
	}
}

/// Checks for memory leaks when going out of scope
final class LeakChecker {
	typealias Checkable = AnyObject & Sendable

	func checkForMemoryLeak<T: Checkable>(
		fileID: String = #fileID,
		filePath: String = #filePath,
		line: Int = #line,
		column: Int = #column,
		_ instanceFactory: @autoclosure () -> T
	) -> T {
		let instance = instanceFactory()
		checks.append(
			LeakCheck(
				instance,
				sourceLocation: SourceLocation(
					fileID: fileID,
					filePath: filePath,
					line: line,
					column: column
				)
			)
		)
		return instance
	}

	private struct LeakCheck {
		let sourceLocation: SourceLocation
		private weak var weakReference: Checkable?
		var isLeaking: Bool { weakReference != nil }
		init(_ weakReference: Checkable, sourceLocation: SourceLocation) {
			self.weakReference = weakReference
			self.sourceLocation = sourceLocation
		}
	}

	private var checks = [LeakCheck]()

	typealias Scope = (LeakChecker) -> Void

	private let scope: Scope

	@discardableResult
	init(scope: @escaping Scope) {
		self.scope = scope
		scope(self)
	}

	deinit {
		for check in checks {
			#expect(
				check.isLeaking == false,
				"Potential Memory Leak detected",
				sourceLocation: check.sourceLocation
			)
		}
	}
}

struct LeakCheckerTrait: TestTrait, TestScoping {
	/// Holds the leak checker instance for the current test
	@TaskLocal
	static var current: LeakChecker?

	func provideScope(
		for test: Test,
		testCase: Test.Case?,
		performing function: @Sendable () async throws -> Void
	) async throws {
		let checker = LeakChecker()
		try await Self.$current.withValue(checker) {
			try await function()
			checker.checkLeaks()
		}
	}

	final class LeakChecker: @unchecked Sendable {
		typealias Checkable = AnyObject & Sendable

		func checkForMemoryLeak<T: Checkable>(
			fileID: String = #fileID,
			filePath: String = #filePath,
			line: Int = #line,
			column: Int = #column,
			_ instanceFactory: @autoclosure () -> T
		) -> T {
			let instance = instanceFactory()
			checks.append(
				.init(
					instance,
					sourceLocation: SourceLocation(
						fileID: fileID,
						filePath: filePath,
						line: line,
						column: column
					)
				)
			)
			return instance
		}

		private struct LeakCheck: Sendable {
			let sourceLocation: SourceLocation
			private weak var weakReference: Checkable?
			var isLeaking: Bool { weakReference != nil }
			init(_ weakReference: Checkable, sourceLocation: SourceLocation) {
				self.weakReference = weakReference
				self.sourceLocation = sourceLocation
			}
		}

		private var checks = [LeakCheck]()

		fileprivate func checkLeaks() {
			for check in checks {
				#expect(
					check.isLeaking == false,
					"Potential Memory Leak detected",
					sourceLocation: check.sourceLocation
				)
			}
		}

		fileprivate init() {}
	}
}

extension Trait where Self == LeakCheckerTrait {
	static var leakChecker: Self { Self() }
}
