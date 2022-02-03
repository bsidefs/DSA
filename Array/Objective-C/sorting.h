//
//  sorting.h
//  dsa-objc
//
//  Created by Brian Tamsing on 1/26/22.
//

#ifndef sorting_h
#define sorting_h

#import <Foundation/Foundation.h>
#import "NSMutableArray+NSMutableArray_Utilities.h"

NSArray<NSNumber *> *insertionSort(NSArray<NSNumber *> *);

NSArray<NSNumber *> *mergeSort(NSArray<NSNumber *> *);
NSArray<NSNumber *> *merge(NSArray<NSNumber *> *, NSArray<NSNumber *> *);

void quicksort(NSMutableArray<NSNumber *> *, NSInteger, NSInteger);
NSInteger partition(NSMutableArray<NSNumber *> *, NSInteger, NSInteger);

#endif /* sorting_h */