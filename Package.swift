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
        .library(name: "Facet", targets: ["Facet"]),
        .library(name: "Facet Standard Library Integration", targets: ["Facet Standard Library Integration"]),
        .library(name: "Facet Foundation Library Integration", targets: ["Facet Foundation Library Integration"]),
        .library(name: "Facet Test Support", targets: ["Facet Test Support"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-axis.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-cardinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-direction.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-equation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-hash.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-comparison.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-finite.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ordinal.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Facet",
            dependencies: [
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Direction", package: "swift-direction"),
                .product(name: "Equation", package: "swift-equation"),
                .product(name: "Hash", package: "swift-hash"),
                .product(name: "Comparison", package: "swift-comparison"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Finite", package: "swift-finite"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Ordinal Standard Library Integration", package: "swift-ordinal"),
            ],
            path: "Sources/Facet"
        ),
        .target(
            name: "Facet Standard Library Integration",
            dependencies: [
                .target(name: "Facet"),
            ],
            path: "Sources/Facet Standard Library Integration"
        ),
        .target(
            name: "Facet Foundation Library Integration",
            dependencies: [
                .target(name: "Facet"),
                .target(name: "Facet Standard Library Integration"),
            ],
            path: "Sources/Facet Foundation Library Integration"
        ),
        .target(
            name: "Facet Test Support",
            dependencies: [
                .target(name: "Facet"),
                .product(name: "Ordinal", package: "swift-ordinal"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Facet Tests",
            dependencies: [
                .target(name: "Facet"),
                .target(name: "Facet Test Support"),
                .product(name: "Finite", package: "swift-finite"),
                .target(name: "Facet Standard Library Integration"),
                .target(name: "Facet Foundation Library Integration"),
            ],
            path: "Tests/Facet Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
