// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CUCMonitor",
    products: [
        .library(
            name: "CUCMonitor",
            targets: ["CUCMonitor"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/paulofierro/Logger", from: "0.0.1")
    ],
    targets: [
        .target(
            name: "CUCMonitor",
            dependencies: [
                .product(name: "Logger", package: "Logger")
            ]
        ),
        .testTarget(
            name: "CUCMonitorTests",
            dependencies: ["CUCMonitor"],
            resources: []
        )
    ]
)
