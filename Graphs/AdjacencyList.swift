//
//  AdjacencyList.swift
//  dsa
//
//  Created by Brian Tamsing on 11/20/21.
//

import Foundation

public class AdjacencyList<T: Hashable>: Graphable {
    public typealias Element = T
    
    public var adjacencyDict: [Vertex<T>: [Edge<T>]] = [:]
    
    public var description: String {
        var str = ""
        
        for (vertex, edges) in adjacencyDict {
            var edgeStr = ""
            for (index, edge) in edges.enumerated() {
                if index == edges.count - 1 {
                    edgeStr.append("\(edge.destination.data)")
                } else {
                    edgeStr.append("\(edge.destination.data), ")
                }
            }
            str.append("\(vertex.data) --> [\(edgeStr)]\n")
        }
        
        return str
    }
    
    public init() {}
    
    public func createVertex(data: Element) -> Vertex<Element> {
        let vertex = Vertex(data: data)
        
        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }
        
        return vertex
    }
    
    public func addEdge(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        switch type {
            case .directed:
                addDirectedEdge(from: source, to: destination, weight: weight)
            case .undirected:
                addUndirectedEdge(vertices: (source, destination), weight: weight)
        }
    }
    
    public func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? {
        guard let edges = edges(from: source) else {
            return nil
        }
        
        for edge in edges {
            if edge.destination == destination {
                return edge.weight
            }
        }
        
        return nil
    }
    
    public func edges(from source: Vertex<Element>) -> [Edge<Element>]? {
        return adjacencyDict[source]
    }
    
    private func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencyDict[source]?.append(edge)
    }
    
    private func addUndirectedEdge(vertices: (Vertex<Element>, Vertex<Element>), weight: Double?) {
        let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }

    public func dfs(from start: Vertex<T>, to end: Vertex<T>) -> Stack<Vertex<T>> {
        var stack = Stack<Vertex<T>>()
        stack.push(start)
        
        var visited = Set<Vertex<T>>()
        visited.insert(start)
        
    outer: while let vertex = stack.peek(), vertex != end {
        guard let neighborEdges = edges(from: vertex), !neighborEdges.isEmpty else {
            print("backtracking from \(vertex)...")
            
            stack.pop()
            continue
        }
        
        for edge in neighborEdges {
            if !visited.contains(edge.destination) {
                stack.push(edge.destination)
                print("DFS -->: \(stack)")
                visited.insert(edge.destination)
                continue outer
            }
        }
        
        print("backtracking from \(vertex)...")
        stack.pop()
    }
        
        return stack
    }
    
    public func dijkstrasAlgorithm(start: Vertex<T>) {
        var allVertices = Set<Vertex<T>>()
        for vertex in adjacencyDict.keys {
            allVertices.insert(vertex)
        }
        clearPathData()
        
        start.pathLengthFromStart = 0
        start.pathFromStart = [start]
        
        var currentVertex: Vertex? = start
        while let vertex = currentVertex {
            allVertices.remove(vertex)
            
            let nonVisitedNeighborEdges = adjacencyDict[vertex]?.filter { edge in
                return allVertices.contains(edge.destination)
            } ?? []
            
            for edge in nonVisitedNeighborEdges {
                let theoreticalNewWeight = vertex.pathLengthFromStart + edge.weight!
                
                if theoreticalNewWeight < edge.destination.pathLengthFromStart {
                    edge.destination.pathLengthFromStart = theoreticalNewWeight
                    edge.destination.pathFromStart = vertex.pathFromStart + [edge.destination]
                }
            }
            
            if allVertices.isEmpty {
                currentVertex = nil
                break
            }
            
            currentVertex = allVertices.min { a, b in
                a.pathLengthFromStart < b.pathLengthFromStart
            }
        }
    }
    
    private func clearPathData() {
        for vertex in adjacencyDict.keys {
            vertex.clearPathData()
        }
    }
}