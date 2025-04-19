// swift-tools-version:5.9
import PackageDescription

let package = Package(
  name: "swiftfido2",
  platforms: [.macOS(.v13)],
  products: [
    // your library
    .library(
      name: "swiftfido2",
      targets: ["swiftfido2"]
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

    // 2) the new executable target
    .executableTarget(
      name: "cliSwiftFido2",
      dependencies: [
        .target(name: "swiftfido2")
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
