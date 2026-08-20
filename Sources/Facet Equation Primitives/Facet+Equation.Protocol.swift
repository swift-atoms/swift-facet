// Facet+Equation.Protocol.swift
// Conformance of Facet to Equation.Protocol — unconditional.
//
// The equality witness (axis-major rank) lives in the root (Facet.swift).
// `Equation.Protocol` aliases `Swift.Equatable`.

public import Equation_Primitives
public import Facet_Primitive

extension Facet: Equation.`Protocol` {}
