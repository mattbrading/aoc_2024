// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "aoc_2024",
    dependencies: [
            .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0"),
        ],
    targets: [
        .executableTarget(
            name: "aoc_2024", dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .testTarget(
            name: "aoc_2024Tests",
            dependencies: ["aoc_2024"]
        ),
    ]
)
