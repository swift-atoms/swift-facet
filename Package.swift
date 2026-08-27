// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-facet",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Facet",
            targets: ["Facet"]
        ),
        .library(
            name: "Facet Standard Library Integration",
            targets: ["Facet Standard Library Integration"]
        ),
        .library(
            name: "Facet Apple Foundation Integration",
            targets: ["Facet Apple Foundation Integration"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-axis.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-direction.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Facet",
            dependencies: [
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Direction", package: "swift-direction"),
            ]
        ),
        .target(
            name: "Facet Standard Library Integration",
            dependencies: ["Facet"]
        ),
        .target(
            name: "Facet Apple Foundation Integration",
            dependencies: [
                "Facet",
                "Facet Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Facet Tests",
            dependencies: ["Facet"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
