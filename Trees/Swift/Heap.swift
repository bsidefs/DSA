//
//  Heap.swift
//  dsa
//
//  Created by Brian Tamsing on 12/12/21.
//

import Foundation

struct Heap<T: Comparable> {
    var nodes = [T]()
    var orderCriteria: (T, T) -> Bool
    
    init(sortedBy orderCriteria: @escaping (T, T) -> Bool) {
        self.orderCriteria = orderCriteria
    }
    
    init(nodes: [T], sortedBy orderCriteria: @escaping (T, T) -> Bool) {
        self.nodes = nodes
        self.orderCriteria = orderCriteria
        build()
    }
    
    mutating func build() {
        for i in stride(from: (nodes.count/2 - 1), through: 0, by: -1) {
            heapify(atIndex: i)
        }
    }
    
    mutating func heapify(atIndex index: Int, until endIndex: Int) {
        let left = leftChildIndex(ofIndex: index)
        let right = rightChildIndex(ofIndex: index)
        
        var replacement = index
        if left < endIndex && orderCriteria(nodes[left], nodes[replacement]) {
            replacement = left
        }
        
        if right < endIndex && orderCriteria(nodes[right], nodes[replacement]) {
            replacement = right
        }
        
        if replacement != index {
            nodes.swapAt(index, replacement)
            heapify(atIndex: replacement, until: endIndex)
        }
    }
    
    mutating func heapify(atIndex index: Int) {
        heapify(atIndex: index, until: nodes.count)
    }
    
    mutating func heapifyUpwards(atIndex index: Int) {
        let parentIndex = parentIndex(ofIndex: index)
        
        var replacement = index
        if index > 0 && orderCriteria(nodes[replacement], nodes[parentIndex]) {
            replacement = parentIndex
        }
        
        if replacement != index {
            nodes.swapAt(index, replacement)
            heapifyUpwards(atIndex: replacement)
        }
    }
    
    mutating func insert(value: T) {
        nodes.append(value)
        heapifyUpwards(atIndex: nodes.count - 1)
    }
    
    mutating func insert<S: Sequence>(sequence: S) where S.Iterator.Element == T {
        for value in sequence {
            insert(value: value)
        }
    }
    
    mutating func remove(at index: Int) -> T? {
        guard index >= 0 && index < nodes.count else { return nil }
        
        let lastValidIndex = nodes.count - 1
        if index != lastValidIndex {
            nodes.swapAt(index, lastValidIndex)
            heapify(atIndex: index, until: lastValidIndex)
            heapifyUpwards(atIndex: index)
        }
        
        return nodes.removeLast()
    }
    
    mutating func extract() -> T? {
        guard !nodes.isEmpty else { return nil }
        
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            let value = nodes.first
            
            nodes[0] = nodes.removeLast()
            heapify(atIndex: 0)
            
            return value
        }
    }
    
    func index(of node: T) -> Int? {
        return nodes.firstIndex(where: {
            $0 == node
        })
    }
    
    mutating func sort() -> [T] {
        for endpoint in stride(from: nodes.count - 1, through: 1, by: -1) {
            nodes.swapAt(0, endpoint)
            heapify(atIndex: 0, until: endpoint)
        }
        
        return nodes
    }
    
    var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    var count: Int {
        return nodes.count
    }
    
    func parentIndex(ofIndex i: Int) -> Int {
        return (i - 1) / 2
    }
    
    func leftChildIndex(ofIndex i: Int) -> Int {
        return (2 * i) + 1
    }
    
    func rightChildIndex(ofIndex i: Int) -> Int {
        return (2 * i) + 2
    }
}

func heapsort<T: Comparable>(_ arr: [T], sortedBy orderCriteria: @escaping (T, T) -> Bool) -> [T] {
    let reverseOfOrderCriteria = { (a: T, b: T) -> Bool in
        return !orderCriteria(a, b)
    }
    var heap = Heap(nodes: arr, sortedBy: reverseOfOrderCriteria)
    return heap.sort()
}