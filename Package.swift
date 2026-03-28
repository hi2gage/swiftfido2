// swift-tools-version:6.0
import PackageDescription

let package = Package(
	name: "swiftfido2",
	platforms: [.macOS(.v13)],
	products: [
		.library(
			name: "swiftfido2",
			targets: ["swiftfido2"]
		)
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

		.testTarget(
			name: "swiftfido2Tests",
			dependencies: ["swiftfido2", "swiftfido2Core"]
		),
	]
)
