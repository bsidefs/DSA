//
//  BinarySearchTree.swift
//  dsa
//
//  Created by Brian Tamsing on 11/2/21.
//

import Foundation

class BinarySearchTree<T: Comparable> {
    typealias BST = BinarySearchTree<T>
    
    var val             : T
    
    weak var parent     : BST?
    var left            : BST?
    var right           : BST?
    
    init(val: T) {
        self.val = val
    }
    
    convenience init(arr: [T]) {
        precondition(arr.count > 0)
        
        self.init(val: arr.first!)
        for child in arr.dropFirst() {
            insert(child)
        }
    }
    
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return left == nil && right == nil
        // or return !hasAnyChild
    }
    
    var isLeftChild: Bool {
        return parent?.left === self
    }
    
    var isRightChild: Bool {
        return parent?.right === self
    }
    
    var hasLeftChild: Bool {
        return left != nil
    }
    
    var hasRightChild: Bool {
        return right != nil
    }
    
    var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    func insert(_ val: T) {
        if val < self.val {
            if let left = left {
                left.insert(val)
            } else {
                left = BST(val: val)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(val)
            } else {
                right = BST(val: val)
                right?.parent = self
            }
        }
    }
    
    func search(for val: T) -> BST? {
        if val < self.val {
            return left?.search(for: val)
        } else if val > self.val {
            return right?.search(for: val)
        } else {
            return self
        }
    }
    
    func inOrderTraversal(process: (T) -> Void) {
        left?.inOrderTraversal(process: process)
        process(val)
        right?.inOrderTraversal(process: process)
    }
    
    func preOrderTraversal(process: (T) -> Void) {
        process(val)
        left?.preOrderTraversal(process: process)
        right?.preOrderTraversal(process: process)
    }
    
    func postOrderTraversal(process: (T) -> Void) {
        left?.postOrderTraversal(process: process)
        right?.postOrderTraversal(process: process)
        process(val)
    }
    
    func reconnectParent(to node: BST?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
    
    func minimum() -> BST {
        var node = self
        while let left = node.left {
            node = left
        }
        return node
    }
    
    func maximum() -> BST {
        var node = self
        while let right = node.right {
            node = right
        }
        return node
    }
    
    func remove() -> BST? {
        let replacement: BST?
        
        if let right = right {
            replacement = right.minimum()
        } else if let left = left {
            replacement = left.maximum()
        } else {
            replacement = nil
        }
        
        replacement?.remove()

        replacement?.right = right
        replacement?.left = left
        
        right?.parent = replacement
        left?.parent = replacement
        
        reconnectParent(to: replacement)

        parent = nil
        left = nil
        right = nil

        return replacement
    }
    
    func height() -> Int {
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }

    func depth() -> Int {
        if isRoot {
            return 0
        } else {
            return 1 + (parent?.depth() ?? 0)
        }
    }
    
    func predecessor() -> BST? {
        if let left = left {
            return left.maximum()
        } else {
            var node = self
            while let parent = node.parent {
                if parent.val < val {
                    return parent
                }
                node = parent
            }
        }
        return nil
    }
    
    func successor() -> BST? {
        if let right = right {
            return right.minimum()
        } else {
            var node = self
            while let parent = node.parent {
                if parent.val > val {
                    return parent
                }
                node = parent
            }
        }
        return nil
    }
}

extension BinarySearchTree: CustomStringConvertible {
  public var description: String {
    var s = ""
      
    if let left = left {
      s += "(\(left.description)) <- "
    }
      
    s += "\(val)"
      
    if let right = right {
      s += " -> (\(right.description))"
    }
      
    return s
  }
}