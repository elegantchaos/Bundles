// swift-tools-version:5.2

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 06/04/2020.
//  All code (c) 2020 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import PackageDescription

let package = Package(
    name: "Bundles",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v10),
        .tvOS(.v10),
    ],
    products: [
        .library(
            name: "Bundles",
            targets: ["Bundles"]),
    ],
    dependencies: [
        .package(url: "https://github.com/elegantchaos/Coercion.git", from: "1.0.4"),
        .package(url: "https://github.com/elegantchaos/Images.git", from: "1.0.0"),
        .package(url: "https://github.com/elegantchaos/Files.git", from: "1.1.3"),
        .package(url: "https://github.com/elegantchaos/SemanticVersion.git", from: "1.1.0"),
        .package(url: "https://github.com/elegantchaos/XCTestExtensions.git", from: "1.1.2")
    ],
    targets: [
        .target(
            name: "Bundles",
            dependencies: ["Coercion", "Files", "Images", "SemanticVersion"]),
        .testTarget(
            name: "BundlesTests",
            dependencies: ["Bundles", "XCTestExtensions"]),
    ]
)
