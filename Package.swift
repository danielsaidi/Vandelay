// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Vandelay",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "Vandelay",
            targets: ["Vandelay"])
    ],
    dependencies: [
        .package(url: "git@github.com:Quick/Quick.git", .upToNextMinor(from: "2.2.0")),
        .package(url: "git@github.com:Quick/Nimble.git", .exact("8.0.2"))
    ],
    targets: [
        .target(
            name: "Vandelay",
            dependencies: []),
        .testTarget(
            name: "VandelayTests",
            dependencies: ["Vandelay", "Quick", "Nimble"])
    ]
)
