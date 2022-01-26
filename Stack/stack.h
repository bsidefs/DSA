//
//  Stack.h
//  dsa
//
//  Created by Brian Tamsing on 1/25/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Stack<ObjectType> : NSObject

- (NSUInteger)count;
- (BOOL)isEmpty;

- (void)push:(ObjectType)val;
- (nullable ObjectType)pop;
- (nullable ObjectType)peek;

@end

NS_ASSUME_NONNULL_END