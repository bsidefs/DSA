//
//  Trie.swift
//  dsa
//
//  Created by Brian Tamsing on 1/16/22.
//

import Foundation

class TrieNode<T: Hashable> {
    var val             : T?
    
    weak var parent     : TrieNode?
    var children        : [T: TrieNode] = [:]
    
    var isTerminating   = false
    
    init(val: T? = nil, parent: TrieNode? = nil) {
        self.val = val
        self.parent = parent
    }
    
    func add(child: T) {
        guard children[child] == nil else { return }
        
        children[child] = TrieNode(val: child, parent: self)
    }
}

class Trie {
    typealias Node = TrieNode<Character>
    
    var root: Node
    
    init(root: Node) {
        self.root = Node()
    }
    
    func insert(word: String) {
        guard !word.isEmpty else { return }
        
        var currentNode = root
        let chars = Array(word.lowercased())
        
        var i = 0
        while i < chars.count {
            let c = chars[i]
            
            if let child = currentNode.children[c] {
                currentNode = child
            } else {
                currentNode.add(child: c)
                currentNode = currentNode.children[c]!
            }
            
            i += 1
        }
        
        currentNode.isTerminating = true
    }
    
    func search(word: String) -> Bool {
        guard !word.isEmpty else { return false }
        
        var currentNode = root
        let chars = Array(word.lowercased())
        
        var i = 0
        while i < chars.count, let child = currentNode.children[chars[i]] {
            i += 1 // then move on up
            currentNode = child
        }
        
        return i == chars.count && currentNode.isTerminating ? true : false
    }
}