// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Vandelay",
    products: [
        .library(
            name: "Vandelay",
            targets: ["Vandelay"])
    ],
    dependencies: [
        .package(url: "git@github.com:Quick/Quick.git", from: "2.1.0"),
        .package(url: "git@github.com:Quick/Nimble.git", from: "8.0.2")
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
