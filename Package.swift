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
		.package(url: "https://github.com/valpackett/SwiftCBOR.git", from: "0.6.0")
	],
	targets: [
		.target(
			name: "swiftfido2",
			dependencies: ["SwiftCBOR"],
			path: "swiftfido2/Sources/swiftfido2"
		),

		.testTarget(
			name: "swiftfido2Tests",
			dependencies: ["swiftfido2", "SwiftCBOR"]
		),
	]
)
