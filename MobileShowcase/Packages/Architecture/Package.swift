// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Architecture",
    platforms: [
        .iOS(.v18),
    ],
    products: [
        .library(
            name: "Architecture",
            targets: ["Architecture"]),
    ],
    targets: [
        .target(
            name: "Architecture"),
        .testTarget(
            name: "ArchitectureTests",
            dependencies: ["Architecture"]
        ),
    ]
)
