//
//  TrieNode.m
//  dsa-objc
//
//  Created by Brian Tamsing on 2/1/22.
//

#import "TrieNode.h"

@implementation TrieNode

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        _val = ' ';
        _parent = nil;
        _children = [NSMutableDictionary new];
        _isTerminating = NO;
    }
    
    return self;
}

- (instancetype)initWithVal:(unichar)val parent:(TrieNode *)parent {
    if (self = [super init]) {
        _val = val;
        _parent = parent;
        _children = [NSMutableDictionary new];
        _isTerminating = NO;
    }
    
    return self;
}

#pragma mark - Methods

- (void)addChild:(unichar)child {
    NSString *val = [NSString stringWithFormat:@"%C", child];
    
    if (!self.children[val]) {
        self.children[val] = [[TrieNode alloc] initWithVal:child parent:self];
    }
}

@end