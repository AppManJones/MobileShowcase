// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ArchitecturalDemo",
    platforms: [
        .iOS(.v18),
    ],
    products: [
        .library(
            name: "ArchitecturalDemo",
            targets: ["ArchitecturalDemo"]),
    ],
    targets: [
        .target(
            name: "ArchitecturalDemo"),
        .testTarget(
            name: "ArchitecturalDemoTests",
            dependencies: ["ArchitecturalDemo"]
        ),
    ]
)
