# swift-facet

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
    .package(url: "https://github.com/swift-molecules/swift-facet.git", branch: "main")
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

The root `Facet Primitive` depends on `Axis` and `Direction`; each protocol conformance lives in its own sub-target, so consumers import only what they use.

| Product | Depends on | When to import |
|---------|--------|---------|
| `Facet Primitive` | `swift-axis`, `swift-direction` | The `Facet<N>` value, `opposite`, and equality / hashing / ordering witnesses (axis-major rank). |
| `Facet Equation` | `swift-equation` | `Equation.Protocol` conformance (the institute `Equatable` twin). |
| `Facet Hash` | `swift-hash` | `Hash.Protocol` conformance (the institute `Hashable` twin). |
| `Facet Comparison` | `swift-comparison` | `Comparison.Protocol` conformance (the institute `Comparable` twin). |
| `Facet Enumerable` | `swift-finite`, `swift-ordinal` | `Finite.Enumerable` conformance: `.count`, `.ordinal`, `.allCases` over the `2N` facets. |
| `Facet` | all of the above | Umbrella re-exporting every sub-target. |
| `Facet Test Support` | `Facet` | Test-only spine re-exporting upstream Test Support for ordinal literal comparisons. |

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
