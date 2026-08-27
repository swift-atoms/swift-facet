import Axis
import Direction
import Facet
import Testing

@Suite
struct `Facet - Construction` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Facet - Construction`.Unit {
    @Test
    func `stores axis and direction`() {
        let facet = Facet<3>(axis: .secondary, direction: .negative)
        #expect(facet.axis == Axis<3>.secondary)
        #expect(facet.direction == .negative)
    }
}

@Suite
struct `Facet - Opposite` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Facet - Opposite`.Unit {
    @Test
    func `opposite flips direction and keeps axis`() {
        let facet = Facet<3>(axis: .tertiary, direction: .positive)
        let opposite = facet.opposite
        #expect(opposite.axis == facet.axis)
        #expect(opposite.direction == .negative)
    }
}

extension `Facet - Opposite`.`Edge Case` {
    @Test(arguments: [Direction.positive, Direction.negative])
    func `opposite is involution`(direction: Direction) {
        let facet = Facet<2>(axis: .primary, direction: direction)
        #expect(facet.opposite.opposite == facet)
    }
}

@Suite
struct `Facet - Conformances` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Facet - Conformances`.Unit {
    @Test
    func `Equatable distinguishes axis and direction`() {
        #expect(
            Facet<2>(axis: .primary, direction: .positive)
                == Facet<2>(axis: .primary, direction: .positive)
        )
        #expect(
            Facet<2>(axis: .primary, direction: .positive)
                != Facet<2>(axis: .primary, direction: .negative)
        )
        #expect(
            Facet<2>(axis: .primary, direction: .positive)
                != Facet<2>(axis: .secondary, direction: .positive)
        )
    }
}

extension `Facet - Conformances`.Integration {
    @Test
    func `Hashable distinguishes all four 2D facets`() {
        let set: Set<Facet<2>> = [
            Facet(axis: .primary, direction: .positive),
            Facet(axis: .primary, direction: .negative),
            Facet(axis: .secondary, direction: .positive),
            Facet(axis: .secondary, direction: .negative),
            Facet(axis: .primary, direction: .positive),
        ]
        #expect(set.count == 4)
    }
}

@Suite
struct `Facet - Comparison` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Facet - Comparison`.Unit {
    @Test
    func `orders axis-major then positive-before-negative`() {

        #expect(
            Facet<2>(axis: .primary, direction: .positive)
                < Facet<2>(axis: .primary, direction: .negative)
        )
        #expect(
            Facet<2>(axis: .primary, direction: .negative)
                < Facet<2>(axis: .secondary, direction: .positive)
        )
        #expect(
            Facet<2>(axis: .secondary, direction: .positive)
                < Facet<2>(axis: .secondary, direction: .negative)
        )
    }
}

extension `Facet - Comparison`.Integration {
    @Test
    func `sorted equals allCases order`() {
        let all = Array(Facet<2>.allCases)
        #expect(all.sorted() == all)
    }
}
