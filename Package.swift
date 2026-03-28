// swift-tools-version:6.0
import PackageDescription

let package = Package(
	name: "swiftfido2",
	platforms: [.macOS(.v13)],
	products: [
		.library(
			name: "swiftfido2",
			targets: ["swiftfido2"]
		),
		.executable(
			name: "cliSwiftFido2",
			targets: ["cliSwiftFido2"]
		),
	],
	dependencies: [
		.package(path: "../SwiftCBOR")
	],
	targets: [
		.target(
			name: "swiftfido2",
			dependencies: ["swiftfido2Core"],
			path: "swiftfido2/Sources/swiftfido2"
		),

		.target(
			name: "swiftfido2Core",
			dependencies: ["SwiftCBOR"],
			path: "swiftfido2/Sources/swiftfido2Core"
		),

		.executableTarget(
			name: "cliSwiftFido2",
			dependencies: [
				.target(name: "swiftfido2")
			],
			path: "cliSwiftFido2/Sources/cliSwiftFido2"
		),

		.testTarget(
			name: "swiftfido2Tests",
			dependencies: ["swiftfido2"]
		),
	]
)
