//
//  NSMutableArray+NSMutableArray_Utilities.m
//  dsa-objc
//
//  Created by Brian Tamsing on 1/26/22.
//

#import "NSMutableArray+NSMutableArray_Utilities.h"

@implementation NSMutableArray (NSMutableArray_Utilities)

- (void)swapAt:(NSUInteger)i j:(NSUInteger)j {
    id temp = self[i];
    self[i] = self[j];
    self[j] = temp;
}

@end