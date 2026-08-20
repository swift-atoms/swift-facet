// Facet+Comparison.Protocol.swift
// Conformance of Facet to Comparison.Protocol — unconditional.
//
// The comparison witnesses live in the root (Facet.swift). `Comparison.Protocol`
// aliases `Swift.Comparable`, so this declaration supplies both conformances.

public import Comparison_Primitives
public import Facet_Primitive

extension Facet: Comparison.`Protocol` {}
