import Facet
import Finite
import Testing

@Suite
struct `Facet construction preserves an axis and a direction` {
    @Suite struct `Facets retain both supplied components` {}
    @Suite struct `No facet construction boundary cases are defined` {}
    @Suite struct `No facet construction integration cases are defined` {}
}

extension `Facet construction preserves an axis and a direction`.`Facets retain both supplied components` {
    @Test
    func `Facet construction stores both the axis and direction`() {
        let facet = Facet<3>(axis: .secondary, direction: .negative)
        #expect(facet.axis == Axis<3>.secondary)
        #expect(facet.direction == .negative)
    }
}

@Suite
struct `Facet opposition flips direction while preserving its axis` {
    @Suite struct `Opposite facets retain their axis and reverse their direction` {}
    @Suite struct `Applying facet opposition twice restores the original facet` {}
    @Suite struct `No facet opposition integration cases are defined` {}
}

extension `Facet opposition flips direction while preserving its axis`.`Opposite facets retain their axis and reverse their direction` {
    @Test
    func `opposite flips direction and keeps axis`() {
        let facet = Facet<3>(axis: .tertiary, direction: .positive)
        let opposite = facet.opposite
        #expect(opposite.axis == facet.axis)
        #expect(opposite.direction == .negative)
    }
}

extension `Facet opposition flips direction while preserving its axis`.`Applying facet opposition twice restores the original facet` {
    @Test(arguments: [Direction.positive, Direction.negative])
    func `opposite is involution`(direction: Direction) {
        let facet = Facet<2>(axis: .primary, direction: direction)
        #expect(facet.opposite.opposite == facet)
    }
}

@Suite
struct `Facet equality and hashing distinguish axis direction pairs` {
    @Suite struct `Facet equality compares both axis and direction` {}
    @Suite struct `No facet equality and hashing boundary cases are defined` {}
    @Suite struct `Facet hashing retains all distinct two dimensional facets` {}
}

extension `Facet equality and hashing distinguish axis direction pairs`.`Facet equality compares both axis and direction` {
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

extension `Facet equality and hashing distinguish axis direction pairs`.`Facet hashing retains all distinct two dimensional facets` {
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
struct `Facet ordering compares axes before directions` {
    @Suite struct `Facet comparison orders axes first and positive before negative` {}
    @Suite struct `No facet ordering boundary cases are defined` {}
    @Suite struct `Facet sorting agrees with finite enumeration order` {}
}

extension `Facet ordering compares axes before directions`.`Facet comparison orders axes first and positive before negative` {
    @Test
    func `Facet ordering compares axes before positive and negative directions`() {

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

extension `Facet ordering compares axes before directions`.`Facet sorting agrees with finite enumeration order` {
    @Test
    func `sorted equals allCases order`() {
        let all = Array(Facet<2>.allCases)
        #expect(all.sorted() == all)
    }
}
