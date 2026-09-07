import Facet
import Facet_Test_Support
import Finite
import Testing

@Suite
struct `Finite facets enumerate both directions for each axis` {
    @Suite struct `Facet counts and ordinals preserve axis major direction ordering` {}
    @Suite struct `No facet enumeration boundary cases are defined` {}
    @Suite struct `No facet enumeration integration cases are defined` {}
}

extension `Finite facets enumerate both directions for each axis`.`Facet counts and ordinals preserve axis major direction ordering` {
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
struct `Facet case collections enumerate axis direction pairs in ordinal order` {
    @Suite struct `Facet case collections contain two directions per axis` {}
    @Suite struct `No facet case collection boundary cases are defined` {}
    @Suite struct `Facet enumeration round trips each ordinal` {}
}

extension `Facet case collections enumerate axis direction pairs in ordinal order`.`Facet case collections contain two directions per axis` {
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

extension `Facet case collections enumerate axis direction pairs in ordinal order`.`Facet enumeration round trips each ordinal` {
    @Test
    func `allCases round-trips through ordinal`() {
        for facet in Facet<4>.allCases {
            let reconstructed = Facet<4>(_unchecked: (), ordinal: facet.ordinal)
            #expect(reconstructed == facet)
        }
    }
}
