//
//  Stack.swift
//  dsa
//
//  Created by Brian Tamsing on 10/16/21.
//

import Foundation

struct Stack<Element> {
    private var array = [Element]()
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    mutating func push(_ element: Element) {
        array.append(element)
    }
    
    mutating func pop() -> Element? {
        return array.popLast()
    }
    
    func peek() -> Element? {
        return array.last
    }
}