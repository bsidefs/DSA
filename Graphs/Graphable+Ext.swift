//
//  Graphable+Ext.swift
//  dsa
//
//  Created by Brian Tamsing on 11/29/21.
//

import Foundation

enum Visit<T: Hashable> {
    case source
    case edge(Edge<T>)
}

extension Graphable {
    func bfs(from source: Vertex<Element>, to destination: Vertex<Element>) -> [Edge<Element>]? {
        var queue = Queue<Vertex<Element>>()
        queue.enqueue(source)

        var visited: [Vertex<Element>: Visit<Element>] = [source: .source]
        
        while let vertex = queue.dequeue() {
            if vertex == destination {
                var route: [Edge<Element>] = []
                
                var currentVertex = destination
                while case .edge(let backtrack) = visited[currentVertex] {
                    route = [backtrack] + route
                    currentVertex = backtrack.source
                }
                
                return route
            }

            for neighborEdge in edges(from: vertex) ?? [] {
                let destination = neighborEdge.destination

                if visited[destination] == nil {
                    queue.enqueue(destination)
                    visited[destination] = .edge(neighborEdge)
                }
            }
        }

        return nil
    }
}