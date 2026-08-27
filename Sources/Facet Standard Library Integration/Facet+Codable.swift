public import Facet

#if !hasFeature(Embedded)
    extension Facet: Codable {}
#endif
