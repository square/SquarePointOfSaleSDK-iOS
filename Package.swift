// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SquarePointOfSaleSDK",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "SquarePointOfSaleSDK",
            targets: ["SquarePointOfSaleSDK"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SquarePointOfSaleSDK",
            dependencies: [],
            path: "Sources",
            publicHeadersPath: "Public"
        ),
        .testTarget(
            name: "SquarePontOfSaleSDK-Unit-Tests-Swift",
            dependencies: ["SquarePointOfSaleSDK"],
            path: "Tests"
        )
    ]
)
