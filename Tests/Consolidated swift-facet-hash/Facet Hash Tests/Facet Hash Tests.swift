import Axis
import Direction
import Facet
import Hash
import Testing

@Suite
struct `Facet Hash Tests` {

    @Test
    func `Facet retains its native Hashable behavior`() {
        let first = Facet<2>(axis: Axis<2>.primary, direction: Direction.positive)
        let second = Facet<2>(axis: Axis<2>.primary, direction: Direction.negative)
        let values: Set<Facet<2>> = [first]

        #expect(values.contains(first))
        #expect(!values.contains(second))
    }

    @Test
    func `Facet supplies Hash's domain-typed value`() {
        let facet = Facet<2>(axis: Axis<2>.secondary, direction: Direction.positive)
        let first: Hash.Value = hash(facet)
        let second: Hash.Value = hash(facet)

        #expect(first == second)
    }
}

private func hash<T: Hash.`Protocol`>(_ value: borrowing T) -> Hash.Value {
    value.hashValue
}
