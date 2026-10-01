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
        .package(url: "https://github.com/swift-atoms/swift-tagged.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-index.git", branch: "main"),

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
            url: "https://github.com/swift-atoms/swift-finite.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ordinal.git",
            branch: "main"
        ),
    ],
    targets: [
        .testTarget(
            name: "Facet Finite Integration Tests",
            dependencies: [
                .target(name: "Facet"),
                .target(name: "Facet Test Support"),
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Direction", package: "swift-direction"),
                .product(name: "Finite", package: "swift-finite"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Index", package: "swift-index"),
                .product(name: "Tagged", package: "swift-tagged"),
            ],
            path: "Tests/Facet Finite Integration Tests"
        ),
        .target(
            name: "Facet",
            dependencies: [
                .product(name: "Index", package: "swift-index"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Direction", package: "swift-direction"),
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
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableExperimentalFeature("Lifetimes"),
        .treatAllWarnings(as: .error),
    ]
}
