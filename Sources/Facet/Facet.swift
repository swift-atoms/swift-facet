import Axis
import Direction

public struct Facet<let N: Int>: Sendable {

    public let axis: Axis<N>

    public let direction: Direction

    @inlinable
    public init(axis: Axis<N>, direction: Direction) {
        self.axis = axis
        self.direction = direction
    }
}

extension Facet {

    @inlinable
    public var opposite: Facet {
        Facet(axis: axis, direction: direction.opposite)
    }
}

extension Facet {
    @usableFromInline
    var _rank: Int { 2 * axis.underlying + (direction == .positive ? 0 : 1) }

    @inlinable
    public static func == (lhs: Facet, rhs: Facet) -> Bool { lhs._rank == rhs._rank }

    @inlinable
    public static func < (lhs: Facet, rhs: Facet) -> Bool { lhs._rank < rhs._rank }

    @inlinable
    public static func <= (lhs: Facet, rhs: Facet) -> Bool { lhs._rank <= rhs._rank }

    @inlinable
    public static func > (lhs: Facet, rhs: Facet) -> Bool { lhs._rank > rhs._rank }

    @inlinable
    public static func >= (lhs: Facet, rhs: Facet) -> Bool { lhs._rank >= rhs._rank }

    @inlinable
    public func hash(into hasher: inout Hasher) { hasher.combine(_rank) }
}
