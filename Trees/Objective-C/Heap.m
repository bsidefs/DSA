//
//  Heap.m
//  dsa-objc
//
//  Created by Brian Tamsing on 2/2/22.
//

#import "Heap.h"
#import "../../Array/Objective-C//NSMutableArray+NSMutableArray_Utilities.h"

#pragma mark - Extension

@interface Heap ()

@property (copy, nonatomic) NSMutableArray<NSNumber *> *nodes;
@property (copy, nonatomic) BOOL (^orderCriteria)(NSNumber *, NSNumber *);

@end

#pragma mark - Impl

@implementation Heap

- (void)setNodes:(NSMutableArray<NSNumber *> *)nodes {
    _nodes = [nodes mutableCopy];
}

- (instancetype)initWithNodes:(NSMutableArray<NSNumber *> *)nodes sortedBy:(BOOL (^)(NSNumber * _Nonnull, NSNumber * _Nonnull))orderCriteria {
    if (self = [super init]) {
        _nodes = nodes;
        _orderCriteria = orderCriteria;
        [self build];
    }
    
    return self;
}

- (instancetype)initSortedBy:(BOOL (^)(NSNumber * _Nonnull, NSNumber * _Nonnull))orderCriteria {
    if (self = [super init]) {
        _nodes = [NSMutableArray new];
        _orderCriteria = orderCriteria;
    }
    
    return self;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return self.nodes[idx];
}

- (void)build {
    for (NSInteger i = (self.nodes.count / 2 - 1); i >= 0; i--) {
        [self heapifyAt:i until:self.nodes.count];
    }
}

- (void)heapifyAt:(NSInteger)idx until:(NSInteger)endIdx {
    NSInteger left = (2 * idx) + 1;
    NSInteger right = (2 * idx) + 2;
    
    NSInteger replacement = idx;
    if (left < endIdx && self.orderCriteria(self.nodes[left], self.nodes[replacement])) {
        replacement = left;
    }
    
    if (right < endIdx && self.orderCriteria(self.nodes[right], self.nodes[replacement])) {
        replacement = right;
    }
    
    if (replacement != idx) {
        [self.nodes swapAt:idx j:replacement];
        [self heapifyAt:replacement until:endIdx];
    }
}

- (void)heapifyUpwardsAt:(NSInteger)idx {
    NSInteger parent = (idx - 1) / 2;
    
    NSInteger replacement = idx;
    if (idx > 0 && self.orderCriteria(self.nodes[replacement], self.nodes[parent])) {
        replacement = parent;
    }
    
    if (replacement != idx) {
        [self.nodes swapAt:idx j:replacement];
        [self heapifyUpwardsAt:replacement];
    }
}

- (void)insert:(nonnull NSNumber *)node {
    [self.nodes addObject:node];
    [self heapifyUpwardsAt:self.nodes.count - 1];
}

- (nullable NSNumber *)removeAt:(NSInteger)idx {
    if (idx < 0 || idx >= self.nodes.count) { return nil; }
    
    NSUInteger lastValidIdx = self.nodes.count - 1;
    if (idx != lastValidIdx) {
        [self.nodes swapAt:idx j:lastValidIdx];
        [self heapifyAt:idx until:lastValidIdx];
        [self heapifyUpwardsAt:idx];
    }
    
    NSNumber *val = self.nodes.lastObject;
    [self.nodes removeLastObject];
    
    return val;
}

- (nullable NSNumber *)extract {
    if (self.nodes.count == 0) { return nil; }
    
    NSNumber *val = self.nodes.firstObject;
    [self.nodes swapAt:0 j:self.nodes.count - 1];
    [self.nodes removeLastObject];
    [self heapifyAt:0 until:self.nodes.count];
    
    return val;
}

@end