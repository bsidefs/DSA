//
//  BinaryTree.swift
//  dsa
//
//  Created by Brian Tamsing on 10/29/21.
//

import Foundation

class BinaryTree<T> {
    var val: T
    
    weak var parent: BinaryTree<T>?
    var left: BinaryTree<T>?
    var right: BinaryTree<T>?
    
    init(val: T) {
        self.val = val
    }
    
    var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
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
}

extension BinaryTree: CustomStringConvertible {
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

// MARK: - (INDIRECT/RECURSIVE) ENUM VERSION

indirect enum BinaryTree<T> {
    case node(BinaryTree<T>, T, BinaryTree<T>)
    case empty
    
    var count: Int {
        switch self {
            case let .node(left, _, right):
                return left.count + 1 + right.count
            case .empty:
                return 0
        }
    }
    
    func inOrderWalk(process: (T) -> Void) {
        if case let .node(left, val, right) = self {
            left.inOrderWalk(process: process)
            process(val)
            right.inOrderWalk(process: process)
        }
    }
    
    func preOrderWalk(process: (T) -> Void) {
        if case let .node(left, val, right) = self {
            process(val)
            left.preOrderWalk(process: process)
            right.preOrderWalk(process: process)
        }
    }
    
    func postOrderWalk(process: (T) -> Void) {
        if case let .node(left, val, right) = self {
            left.postOrderWalk(process: process)
            right.postOrderWalk(process: process)
            process(val)
        }
    }
}

extension BinaryTree: CustomStringConvertible {
  public var description: String {
    switch self {
        case let .node(left, val, right):
          return "val: \(val), left = [\(left.description)], right = [\(right.description)]"
        case .empty:
          return ""
    }
  }
}