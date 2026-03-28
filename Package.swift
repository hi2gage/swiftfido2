// swift-tools-version:6.0
import PackageDescription

let package = Package(
	name: "SwiftFido2",
	platforms: [.macOS(.v10_15)],
	products: [
		.library(
			name: "SwiftFido2",
			targets: ["SwiftFido2"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/valpackett/SwiftCBOR.git", from: "0.6.0")
	],
	targets: [
		.target(
			name: "SwiftFido2",
			dependencies: ["SwiftCBOR"],
			path: "Sources/SwiftFido2"
		),

		.testTarget(
			name: "SwiftFido2Tests",
			dependencies: ["SwiftFido2", "SwiftCBOR"]
		),
	]
)
