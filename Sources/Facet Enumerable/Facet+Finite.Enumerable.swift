import Axis
import Direction
import Facet
import Finite
import Ordinal

extension Facet: Finite.Enumerable {

    @inlinable
    public static var count: Cardinal { Cardinal(integerLiteral: UInt(2 * N)) }

    @inlinable
    public var ordinal: Ordinal {
        let directionBit = direction == .positive ? 0 : 1
        return Ordinal(UInt8(2 * axis.underlying + directionBit))
    }

    @inlinable
    public init(_unchecked: Void, ordinal: Ordinal) {
        let value = Int(bitPattern: ordinal)
        let direction: Direction = (value % 2 == 0) ? .positive : .negative
        self.init(axis: Axis(_unchecked: (), value / 2), direction: direction)
    }
}
