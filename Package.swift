// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWCurrency",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "WWCurrency", targets: ["WWCurrency"]),
    ],
    targets: [
        .target(name: "WWCurrency", resources: [.copy("JSON"), .copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
