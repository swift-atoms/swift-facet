# swift-facet

Use this package when you need to name one face of an `N`-dimensional box: a single axis together with the side of it you are on, such as the left or right edge of a rectangle or the top face of a cube. Start from `Facet<N>`. When every axis carries a sign at once, as for a corner region or quadrant, use swift-orthant instead.

## Laws

- `opposite` keeps the axis, flips the direction, and applying it twice returns the original facet.
- Facets are ordered axis-major, and on each axis `.positive` comes before `.negative`. Equality, hashing and comparison all use this ranking.
- There are `2 * N` facets. A facet's `ordinal` is its position in that ordering, so `allCases` lists facets in sorted order, and building a facet back from its `ordinal` gives the same facet.
