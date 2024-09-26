// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Layout",
    platforms: [
        .iOS(.v18),
    ],
    products: [
        .library(
            name: "Layout",
            targets: ["Layout"]),
    ],
    targets: [
        .target(
            name: "Layout"),
        .testTarget(
            name: "LayoutTests",
            dependencies: ["Layout"]
        ),
    ]
)
