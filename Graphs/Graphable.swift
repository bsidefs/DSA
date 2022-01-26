//
//  Graphable.swift
//  dsa
//
//  Created by Brian Tamsing on 11/20/21.
//

import Foundation

protocol Graphable: CustomStringConvertible {
    associatedtype Element: Hashable
    
    func createVertex(data: Element) -> Vertex<Element>
    func addEdge(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
    func edges(from source: Vertex<Element>) -> [Edge<Element>]?
}