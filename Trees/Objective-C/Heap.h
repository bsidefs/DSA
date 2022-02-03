//
//  Heap.h
//  dsa-objc
//
//  Created by Brian Tamsing on 2/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Heap : NSObject

- (instancetype)initWithNodes:(NSMutableArray<NSNumber *> *)nodes sortedBy:(BOOL (^)(NSNumber *, NSNumber *))orderCriteria;
- (instancetype)initSortedBy:(BOOL (^)(NSNumber *, NSNumber *))orderCriteria;

- (id)objectAtIndexedSubscript:(NSUInteger)idx;

- (void)build;
- (void)heapifyAt:(NSInteger)idx until:(NSInteger)endIdx;
- (void)heapifyUpwardsAt:(NSInteger)idx;
- (void)insert:(nonnull NSNumber *)node;
- (nullable NSNumber *)removeAt:(NSInteger)idx;
- (nullable NSNumber *)extract;

@end

NS_ASSUME_NONNULL_END