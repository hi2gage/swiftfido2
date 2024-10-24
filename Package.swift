// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swiftfido2",
    platforms: [.macOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
//        .library(
//            name: "swiftfido2",
//            targets: ["swiftfido2"]
//        ),
        .executable(name: "cliSwiftFido2", targets: ["swiftfido2"])
    ],
    targets: [
//        .binaryTarget(
//            name: "libfido2",
//            path: "./Frameworks/libfido2.xcframework"
//        ),
        .target(
            name: "swiftfido2",
            dependencies: [
//                "libfido2"
            ],
            path: "swiftfido2"
        ),
        .testTarget(
            name: "swiftfido2Tests",
            dependencies: ["swiftfido2"]
        ),
    ]
)
