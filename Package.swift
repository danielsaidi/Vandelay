// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Vandelay",
    platforms: [
        .iOS(.v9),
        .tvOS(.v13),
        .watchOS(.v6),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "Vandelay",
            targets: ["Vandelay"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "8.0.0")),
        .package(url: "https://github.com/danielsaidi/Mockery.git", .upToNextMajor(from: "0.6.0"))
    ],
    targets: [
        .target(
            name: "Vandelay",
            dependencies: []),
        .testTarget(
            name: "VandelayTests",
            dependencies: ["Vandelay", "Quick", "Nimble", "Mockery"])
    ]
)
