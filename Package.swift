// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-facet-primitives",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        // MARK: - Namespace
        .library(
            name: "Facet Primitive",
            targets: ["Facet Primitive"]
        ),

        // MARK: - Sub-namespace targets
        .library(
            name: "Facet Equation Primitives",
            targets: ["Facet Equation Primitives"]
        ),
        .library(
            name: "Facet Hash Primitives",
            targets: ["Facet Hash Primitives"]
        ),
        .library(
            name: "Facet Comparison Primitives",
            targets: ["Facet Comparison Primitives"]
        ),
        .library(
            name: "Facet Enumerable Primitives",
            targets: ["Facet Enumerable Primitives"]
        ),

        // MARK: - Umbrella
        .library(
            name: "Facet Primitives",
            targets: ["Facet Primitives"]
        ),

        // MARK: - Test Support
        .library(
            name: "Facet Primitives Test Support",
            targets: ["Facet Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-axis-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-direction-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-equation-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-hash-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-comparison-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-finite-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-ordinal-primitives.git",
            branch: "main"
        ),
    ],
    targets: [
        // MARK: - Namespace
        // Facet's fields are Axis<N> and Direction, so the root depends on the two atom
        // roots — the [MOD-017] cross-namespace-root exception. Both roots are zero-dep.
        .target(
            name: "Facet Primitive",
            dependencies: [
                .product(name: "Axis Primitive", package: "swift-axis-primitives"),
                .product(name: "Direction Primitive", package: "swift-direction-primitives"),
            ]
        ),

        // MARK: - Sub-namespace targets (per [MOD-031])
        // Institute Equatable/Hashable/Comparable twins:
        .target(
            name: "Facet Equation Primitives",
            dependencies: [
                "Facet Primitive",
                .product(name: "Equation Primitives", package: "swift-equation-primitives"),
            ]
        ),
        .target(
            name: "Facet Hash Primitives",
            dependencies: [
                "Facet Primitive",
                .product(name: "Hash Primitives", package: "swift-hash-primitives"),
            ]
        ),
        .target(
            name: "Facet Comparison Primitives",
            dependencies: [
                "Facet Primitive",
                .product(name: "Comparison Primitives", package: "swift-comparison-primitives"),
            ]
        ),
        // Finite.Enumerable conformance (2N inhabitants enumeration):
        .target(
            name: "Facet Enumerable Primitives",
            dependencies: [
                "Facet Primitive",
                .product(name: "Axis Primitive", package: "swift-axis-primitives"),
                .product(name: "Direction Primitive", package: "swift-direction-primitives"),
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
                .product(name: "Ordinal Primitives", package: "swift-ordinal-primitives"),
            ]
        ),

        // MARK: - Umbrella
        .target(
            name: "Facet Primitives",
            dependencies: [
                "Facet Primitive",
                "Facet Equation Primitives",
                "Facet Hash Primitives",
                "Facet Comparison Primitives",
                "Facet Enumerable Primitives",
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Facet Primitives Test Support",
            dependencies: [
                "Facet Primitives",
                .product(
                    name: "Ordinal Primitives Test Support",
                    package: "swift-ordinal-primitives"
                ),
            ],
            path: "Tests/Support"
        ),

        // MARK: - Tests
        .testTarget(
            name: "Facet Primitives Tests",
            dependencies: [
                "Facet Primitives",
                "Facet Primitives Test Support",
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
