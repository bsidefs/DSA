//
//  Trie.m
//  dsa-objc
//
//  Created by Brian Tamsing on 2/1/22.
//

#import "Trie.h"

@implementation Trie

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        _root = [TrieNode new];
    }
    
    return self;
}

#pragma mark - Methods

- (void)insert:(NSString *)word {
    if (word.length == 0) { return; }
    
    TrieNode *currentNode = self.root;
    word = [word lowercaseString];
    
    int i = 0;
    while (i < word.length) {
        unichar c = [word characterAtIndex:i];
        NSString *val = [NSString stringWithFormat:@"%C", c];
        
        if (currentNode.children[val]) {
            currentNode = currentNode.children[val];
        } else {
            [currentNode addChild:c];
            currentNode = currentNode.children[val];
        }
        
        i++;
    }
    
    currentNode.isTerminating = YES;
}

- (BOOL)search:(NSString *)word {
    if (word.length == 0) { return false; }
    
    TrieNode *currentNode = self.root;
    word = [word lowercaseString];
    
    int i = 0;
    while (i < word.length && currentNode.children[[NSString stringWithFormat:@"%C", [word characterAtIndex:i]]]) {
        currentNode = currentNode.children[[NSString stringWithFormat:@"%C", [word characterAtIndex:i]]];
        i++;
    }
    
    return i == word.length && currentNode.isTerminating ? true : false;
}

@end