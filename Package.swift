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
            ]
        ),

        .target(
            name: "Facet Equation",
            dependencies: [
                .target(name: "Facet"),
                .product(name: "Equation Protocol", package: "swift-equation"),
            ]
        ),
        .target(
            name: "Facet Hash",
            dependencies: [
                .target(name: "Facet"),
                .product(name: "Hash Protocol", package: "swift-hash"),
            ]
        ),
        .target(
            name: "Facet Comparison",
            dependencies: [
                .target(name: "Facet"),
                .product(name: "Comparison Protocol", package: "swift-comparison"),
            ]
        ),

        .target(
            name: "Facet Enumerable",
            dependencies: [
                .target(name: "Facet"),
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Direction", package: "swift-direction"),
                .product(name: "Finite", package: "swift-finite"),
                .product(name: "Finite Enumerable", package: "swift-finite"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(
                    name: "Ordinal Standard Library Integration",
                    package: "swift-ordinal"
                ),
            ]
        ),

        .target(
            name: "Facet Test Support",
            dependencies: [
                .target(name: "Facet"),
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
                .target(name: "Facet"),
                .target(name: "Facet Comparison"),
                .target(name: "Facet Equation"),
                .target(name: "Facet Enumerable"),
                .target(name: "Facet Hash"),
                .target(name: "Facet Test Support"),
                .product(name: "Finite Enumerable", package: "swift-finite"),
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
