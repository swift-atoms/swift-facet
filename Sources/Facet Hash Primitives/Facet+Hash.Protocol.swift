// Facet+Hash.Protocol.swift
// Conformance of Facet to Hash.Protocol — unconditional.
//
// The `hash(into:)` and `==` witnesses live in the root (Facet.swift).

public import Facet_Primitive
public import Hash_Primitives

extension Facet: Hash.`Protocol` {}
