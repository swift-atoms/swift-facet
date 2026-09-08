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

        .library(name: "Facet Foundation Integration", targets: ["Facet Foundation Integration"]),
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
            ],
            path: "Sources/Facet"
        ),
        
        .target(
            name: "Facet Foundation Integration",
            dependencies: [
                .target(name: "Facet"),
            ],
            path: "Sources/Facet Foundation Integration"
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
                .target(name: "Facet Foundation Integration"),
            ],
            path: "Tests/Facet Tests"
        ),
        .testTarget(
            name: "Consolidated Facet Comparison Tests",
            dependencies: [

                .target(name: "Facet"),
                .product(name: "Comparison", package: "swift-comparison"),
            ],
            path: "Tests/Consolidated swift-facet-comparison"
        ),
        .testTarget(
            name: "Consolidated Facet Equation Tests",
            dependencies: [

                .target(name: "Facet"),
                .product(name: "Equation", package: "swift-equation"),
            ],
            path: "Tests/Consolidated swift-facet-equation"
        ),
        .testTarget(
            name: "Consolidated Facet Hash Tests",
            dependencies: [

                .target(name: "Facet"),
                .product(name: "Hash", package: "swift-hash"),
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Direction", package: "swift-direction"),
            ],
            path: "Tests/Consolidated swift-facet-hash"
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
