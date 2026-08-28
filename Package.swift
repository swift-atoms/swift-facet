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
            name: "Facet Primitive",
            targets: ["Facet Primitive"]
        ),

        .library(
            name: "Facet Equation",
            targets: ["Facet Equation"]
        ),
        .library(
            name: "Facet Hash",
            targets: ["Facet Hash"]
        ),
        .library(
            name: "Facet Comparison",
            targets: ["Facet Comparison"]
        ),
        .library(
            name: "Facet Enumerable",
            targets: ["Facet Enumerable"]
        ),

        .library(
            name: "Facet",
            targets: ["Facet"]
        ),

        .library(
            name: "Facet Test Support",
            targets: ["Facet Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-axis.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-direction.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-equation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-hash.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-comparison.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-finite.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ordinal.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Facet Primitive",
            dependencies: [
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Direction", package: "swift-direction"),
            ]
        ),

        .target(
            name: "Facet Equation",
            dependencies: [
                "Facet Primitive",
                .product(name: "Equation", package: "swift-equation"),
            ]
        ),
        .target(
            name: "Facet Hash",
            dependencies: [
                "Facet Primitive",
                .product(name: "Hash", package: "swift-hash"),
            ]
        ),
        .target(
            name: "Facet Comparison",
            dependencies: [
                "Facet Primitive",
                .product(name: "Comparison", package: "swift-comparison"),
            ]
        ),

        .target(
            name: "Facet Enumerable",
            dependencies: [
                "Facet Primitive",
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Direction", package: "swift-direction"),
                .product(name: "Finite", package: "swift-finite"),
                .product(name: "Ordinal", package: "swift-ordinal"),
            ]
        ),

        .target(
            name: "Facet",
            dependencies: [
                "Facet Primitive",
                "Facet Equation",
                "Facet Hash",
                "Facet Comparison",
                "Facet Enumerable",
            ]
        ),

        .target(
            name: "Facet Test Support",
            dependencies: [
                "Facet",
                .product(
                    name: "Ordinal Test Support",
                    package: "swift-ordinal"
                ),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Facet Tests",
            dependencies: [
                "Facet",
                "Facet Test Support",
            ]
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
