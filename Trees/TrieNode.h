//
//  TrieNode.h
//  dsa-objc
//
//  Created by Brian Tamsing on 2/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrieNode : NSObject

#pragma mark - Properties

@property (assign, nonatomic) unichar val;

@property (weak, nonatomic) TrieNode *parent;
@property (strong, nonatomic) NSMutableDictionary<NSString *, TrieNode *> *children;

@property (assign, nonatomic) BOOL isTerminating;

#pragma mark - Init/Methods

- (instancetype)initWithVal:(unichar)val parent:(TrieNode *)parent;
- (void)addChild:(unichar)child;

@end

NS_ASSUME_NONNULL_END