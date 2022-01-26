//
//  Tree.swift
//  dsa
//
//  Created by Brian Tamsing on 10/28/21.
//

import Foundation

class TreeNode<T> {
    var val: T
    
    weak var parent: TreeNode<T>?
    var children = [TreeNode<T>]()
    
    init(val: T) {
        self.val = val
    }
    
    func addChild(_ node: TreeNode<T>) {
        children.append(node)
        node.parent = self
    }
}

extension TreeNode where T: Equatable {
    func search(_ val: T) -> TreeNode<T>? {
        if val == self.val {
            return self
        }
        
        for child in children {
            if let node = child.search(val) {
                return node
            }
        }
        
        return nil
    }
}