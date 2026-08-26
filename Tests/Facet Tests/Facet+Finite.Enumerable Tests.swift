import Facet
import Facet_Test_Support
import Testing

@Suite
struct `Facet+Finite.Enumerable - Enumerable` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Facet+Finite.Enumerable - Enumerable`.Unit {
    @Test
    func `count is 2N`() {
        #expect(Facet<1>.count == 2)
        #expect(Facet<2>.count == 4)
        #expect(Facet<3>.count == 6)
        #expect(Facet<4>.count == 8)
    }

    @Test
    func `ordinal is axis-major then direction`() {
        #expect(Facet<3>(axis: .primary, direction: .positive).ordinal == 0)
        #expect(Facet<3>(axis: .primary, direction: .negative).ordinal == 1)
        #expect(Facet<3>(axis: .secondary, direction: .positive).ordinal == 2)
        #expect(Facet<3>(axis: .secondary, direction: .negative).ordinal == 3)
        #expect(Facet<3>(axis: .tertiary, direction: .positive).ordinal == 4)
        #expect(Facet<3>(axis: .tertiary, direction: .negative).ordinal == 5)
    }
}

@Suite
struct `Facet+Finite.Enumerable - AllCases` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Facet+Finite.Enumerable - AllCases`.Unit {
    @Test
    func `allCases has 2N elements in ordinal order`() {
        let all = Array(Facet<2>.allCases)
        #expect(all.count == 4)
        #expect(all[0] == Facet(axis: .primary, direction: .positive))
        #expect(all[1] == Facet(axis: .primary, direction: .negative))
        #expect(all[2] == Facet(axis: .secondary, direction: .positive))
        #expect(all[3] == Facet(axis: .secondary, direction: .negative))
    }
}

extension `Facet+Finite.Enumerable - AllCases`.Integration {
    @Test
    func `allCases round-trips through ordinal`() {
        for facet in Facet<4>.allCases {
            let reconstructed = Facet<4>(_unchecked: (), ordinal: facet.ordinal)
            #expect(reconstructed == facet)
        }
    }
}
