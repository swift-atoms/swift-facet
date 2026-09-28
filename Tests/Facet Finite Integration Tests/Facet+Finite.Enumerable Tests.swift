import Axis
import Cardinal
import Direction
import Finite
import Ordinal
import Index
import Tagged
import Facet
import Testing

@Suite("Facet × Finite.Enumerable")
struct Facet_Enumerable_Tests {
    @Test
    func `count is 2N`() {
        #expect(Facet<1>.count == Cardinal(UInt(2)))
        #expect(Facet<2>.count == Cardinal(UInt(4)))
        #expect(Facet<3>.count == Cardinal(UInt(6)))
        #expect(Facet<4>.count == Cardinal(UInt(8)))
    }

    @Test
    func `ordinal is axis-major then direction`() {
        #expect(Facet<3>(axis: .primary, direction: .positive).ordinal == Ordinal(UInt(0)))
        #expect(Facet<3>(axis: .primary, direction: .negative).ordinal == Ordinal(UInt(1)))
        #expect(Facet<3>(axis: .secondary, direction: .positive).ordinal == Ordinal(UInt(2)))
        #expect(Facet<3>(axis: .secondary, direction: .negative).ordinal == Ordinal(UInt(3)))
        #expect(Facet<3>(axis: .tertiary, direction: .positive).ordinal == Ordinal(UInt(4)))
        #expect(Facet<3>(axis: .tertiary, direction: .negative).ordinal == Ordinal(UInt(5)))
    }

    @Test
    func `allCases has 2N elements in ordinal order`() {
        let all = Array(Facet<2>.allCases)
        #expect(all.count == 4)
        #expect(all[0] == Facet(axis: .primary, direction: .positive))
        #expect(all[1] == Facet(axis: .primary, direction: .negative))
        #expect(all[2] == Facet(axis: .secondary, direction: .positive))
        #expect(all[3] == Facet(axis: .secondary, direction: .negative))
    }

    @Test
    func `allCases round-trips through ordinal`() {
        for facet in Facet<4>.allCases {
            let reconstructed = Facet<4>(_unchecked: (), ordinal: facet.ordinal)
            #expect(reconstructed == facet)
        }
    }
}
