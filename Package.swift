// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Bundles",
    products: [
        .library(
            name: "Bundles",
            targets: ["Bundles"]),
    ],
    dependencies: [
         .package(url: "https://github.com/elegantchaos/CollectionExtensions", from: "1.0.1"),
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
