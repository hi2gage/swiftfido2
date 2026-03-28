// swift-tools-version:6.0
import PackageDescription

let package = Package(
	name: "swiftfido2",
	platforms: [.macOS(.v15)],
	products: [
		// your library
		.library(
			name: "swiftfido2",
			targets: ["swiftfido2"]
		),
		// your library
		.library(
			name: "swiftfido2Core",
			targets: ["swiftfido2Core"]
		),
		// your CLI
		.executable(
			name: "cliSwiftFido2",
			targets: ["cliSwiftFido2"]
		),
	],
	dependencies: [
		.package(path: "../SwiftCBOR")
	],
	targets: [
		// 1) the library target
		.target(
			name: "swiftfido2",
			dependencies: ["SwiftCBOR"],
			path: "swiftfido2/Sources/swiftfido2"
		),

		// 1) the library target
		.target(
			name: "swiftfido2Core",
			dependencies: ["SwiftCBOR"],
			path: "swiftfido2/Sources/swiftfido2Core"
		),

		// 2) the new executable target
		.executableTarget(
			name: "cliSwiftFido2",
			dependencies: [
				.target(name: "swiftfido2"),
				.target(name: "swiftfido2Core"),
			],
			path: "cliSwiftFido2/Sources/cliSwiftFido2"
		),

		// 3) your tests
		.testTarget(
			name: "swiftfido2Tests",
			dependencies: ["swiftfido2"]
		),
	]
)
