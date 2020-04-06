// swift-tools-version:5.0

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 06/04/2020.
//  All code (c) 2020 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import PackageDescription

let package = Package(
    name: "Bundles",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
    ],
    products: [
        .library(
            name: "Bundles",
            targets: ["Bundles"]),
    ],
    dependencies: [
        .package(url: "https://github.com/elegantchaos/CollectionExtensions", from: "1.0.2"),
        .package(url: "https://github.com/elegantchaos/Images", from: "1.0.0"),
        .package(url: "https://github.com/elegantchaos/Files", from: "1.0.4"),
        .package(url: "https://github.com/elegantchaos/SemanticVersion", from: "1.1.0"),
    ],
    targets: [
        .target(
            name: "Bundles",
            dependencies: ["CollectionExtensions", "Files", "Images", "SemanticVersion"]),
        .testTarget(
            name: "BundlesTests",
            dependencies: ["Bundles"]),
    ]
)
