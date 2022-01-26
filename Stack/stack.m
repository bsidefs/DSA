//
//  Stack.m
//  dsa
//
//  Created by Brian Tamsing on 1/25/22.
//

#import "Stack.h"

@interface Stack ()

@property (strong, nonatomic) NSMutableArray<id> *arr;

@end

@implementation Stack

- (instancetype)init {
    if (self = [super init]) {
        _arr = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSUInteger)count {
    return [self.arr count];
}

- (BOOL)isEmpty {
    return [self.arr count] == 0;
}

- (void)push:(id)val {
    [self.arr addObject:val];
}

- (id)pop {
    id val = [self.arr lastObject];
    [self.arr removeLastObject];
    
    return val;
}

- (id)peek {
    return [self.arr lastObject];
}

@end