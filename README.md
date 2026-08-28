# Facet Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

The oriented faces of an N-dimensional orthotope — `Facet<N>` pairs an `Axis<N>` with a `Direction` to name one signed face (`+X`, `-X`, …), the composition `Axis × Direction`.

---

## Quick Start

`Facet<N>` is the codimension-1 face of an `N`-dimensional box: it fixes a sign on exactly one axis. In 3D those are the six faces of a cube — `+X`, `-X`, `+Y`, `-Y`, `+Z`, `-Z` — so a `Facet<N>` has exactly `2N` inhabitants. Each facet carries its `axis` and `direction`, and `opposite` flips the direction while keeping the axis.

```swift
import Facet

let right = Facet<3>(axis: .primary, direction: .positive)   // +X face
let left = right.opposite                                    // -X face

left.axis == right.axis       // true  — opposite keeps the axis
left.direction == .negative   // true  — and flips the direction
```

Because `Facet<N>` conforms to `Finite.Enumerable`, its `2N` inhabitants enumerate in a fixed axis-major order — positive before negative within each axis — and each maps to a stable `ordinal` in `0..<2N`.

```swift
import Facet

Facet<3>.count                   // 6  (three axes × two directions)

for face in Facet<2>.allCases {
    print(face.ordinal)          // 0, 1, 2, 3
}
```

The all-axes-sign sibling `Orthant<N>`, which fixes a sign on *every* axis (giving `2ᴺ` corners), lives in `swift-orthant`.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-atoms/swift-facet.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Facet", package: "swift-facet"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

The root `Facet Primitive` depends only on the two atom roots `Axis Primitive` and `Direction Primitive` (both zero-dependency); each conformance lives in its own sub-target, so consumers pay only for what they import.

| Product | Target | Purpose |
|---------|--------|---------|
| `Facet Primitive` | `Sources/Facet Primitive/` | The `Facet<N>` namespace: the `axis × direction` value, `opposite`, and the equality / hashing / ordering witnesses (axis-major rank). |
| `Facet Equation Primitives` | `Sources/Facet Equation Primitives/` | `Equation.Protocol` (the institute `Equatable` twin) conformance. |
| `Facet Hash Primitives` | `Sources/Facet Hash Primitives/` | `Hash.Protocol` (the institute `Hashable` twin) conformance. |
| `Facet Comparison Primitives` | `Sources/Facet Comparison Primitives/` | `Comparison.Protocol` (the institute `Comparable` twin) conformance. |
| `Facet Enumerable Primitives` | `Sources/Facet Enumerable Primitives/` | `Finite.Enumerable` conformance: `count`, `ordinal`, and `allCases` over the `2N` facets. |
| `Facet Primitives` | `Sources/Facet Primitives/` | Umbrella re-exporting the root and all four conformance sub-targets. |
| `Facet Test Support` | `Tests/Support/` | Re-exports the umbrella for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
