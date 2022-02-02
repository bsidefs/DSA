//
//  Trie.h
//  dsa-objc
//
//  Created by Brian Tamsing on 2/1/22.
//

#import <Foundation/Foundation.h>
#import "TrieNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface Trie : NSObject

#pragma mark - Properties

@property (strong, nonatomic) TrieNode *root;

#pragma mark - Init/Methods

- (void)insert:(NSString *)word;
- (BOOL)search:(NSString *)word;

@end

NS_ASSUME_NONNULL_END