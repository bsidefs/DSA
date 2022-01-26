//
//  Vertex.swift
//  dsa
//
//  Created by Brian Tamsing on 11/19/21.
//

import Foundation

public class Vertex<T: Hashable> {
    public var data: T
    
    public var pathFromStart: [Vertex<T>] = []
    public var pathLengthFromStart: Double = .infinity
    
    init(data: T) {
        self.data = data
    }
    
    public func clearPathData() {
        pathFromStart = []
        pathLengthFromStart = .infinity
    }
}

extension Vertex: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(data) // essential components
    }
    
    public static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        return lhs.data == rhs.data
    }
}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(data)"
    }
}