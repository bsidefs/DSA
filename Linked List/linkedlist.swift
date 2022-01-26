//
//  LinkedList.swift
//  dsa
//
//  Created by Brian Tamsing on 10/18/21.
//

import Foundation

class LinkedListNode<T> {
    var val: T
    var next: LinkedListNode?
    weak var prev: LinkedListNode?
    
    init(val: T) {
        self.val = val
    }
    
    deinit {
        print("deinitializing node holding val: \(val)")
    }
}

class LinkedList<T> {
    typealias Node = LinkedListNode<T>
    
    // MARK: - Properties
    private var head: Node?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: Node? {
        return head
    }
    
    var last: Node? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        
        return node
    }
    
    var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        
        return count
    }
    
    
    func append(_ val: T) {
        let newNode = Node(val: val)
        
        if let lastNode = last {
            lastNode.next = newNode
            newNode.prev = lastNode
        } else {
            head = newNode
        }
    }
    
    func node(atIndex index: Int) -> Node? {
        guard index >= 0 else { return nil }
        
        if index == 0 {
            return head
        } else {
            var node = head?.next
            for _ in 1..<index {
                node = node?.next
                if node == nil {
                    break
                }
            }
            return node
        }
    }
    
    subscript(index: Int) -> Node? {
        return node(atIndex: index)
    }
    
    func insert(_ node: Node, atIndex index: Int) {
        let newNode = node
        
        if index == 0 {
            newNode.next = head
            head?.prev = newNode
            head = newNode
        } else {
            let prev = self[index - 1]
            let next = prev?.next
            
            prev?.next = newNode
            newNode.prev = prev
            newNode.next = next
            next?.prev = newNode
        }
    }
    
    func deleteAll() {
        head = nil
    }
    
    func delete(node: Node) {
        let prev = node.prev
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        
        next?.prev = prev
        
        node.prev = nil
        node.next = nil
    }
    
    func delete(at index: Int) {
        let node = self[index]
        delete(node: node!)
    }
    
    func reverse() {
        var node = head
        
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.prev)
            head = currentNode
        }
    }
}