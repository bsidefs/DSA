//
//  sorting.m
//  dsa-objc
//
//  Created by Brian Tamsing on 1/26/22.
//

#import "sorting.h"

NSArray<NSNumber *> *insertionSort(NSArray<NSNumber *> *arr) {
    NSMutableArray<NSNumber *> *res = [arr mutableCopy];
    
    for (int i = 1; i < res.count; i++) {
        int currentIndex = i;
        while (currentIndex > 0 && res[currentIndex].intValue < res[currentIndex - 1].intValue) {
            [res swapAt:currentIndex j:currentIndex - 1];
            currentIndex--;
        }
    }
    
    return res;
}

NSArray<NSNumber *> *mergeSort(NSArray<NSNumber *> *arr) {
    if (arr.count < 2) {
        return arr;
    }
    
    NSUInteger midpoint = arr.count / 2;
    
    NSArray *left = mergeSort([arr subarrayWithRange:NSMakeRange(0, midpoint)]);
    NSArray *right = mergeSort([arr subarrayWithRange:NSMakeRange(midpoint, (arr.count - midpoint))]);
    
    return merge(left, right);
}

NSArray<NSNumber *> *merge(NSArray<NSNumber *> *left, NSArray<NSNumber *> *right) {
    int i = 0, j = 0;
    
    NSMutableArray<NSNumber *> *res = [[NSMutableArray alloc] initWithCapacity:left.count + right.count];
    
    while (i < left.count && j < right.count) {
        if (left[i].intValue < right[j].intValue) {
            [res addObject:left[i]];
            i++;
        } else if (right[j].intValue < left[i].intValue) {
            [res addObject:right[j]];
            j++;
        } else {
            [res addObject:left[i]];
            [res addObject:right[j]];
            
            i++;
            j++;
        }
    }
    
    while (i < left.count) {
        [res addObject:left[i]];
        i++;
    }
    
    while (j < right.count) {
        [res addObject:right[j]];
        j++;
    }
    
    return res;
}

void quicksort(NSMutableArray<NSNumber *> *arr, NSInteger low, NSInteger high) {
    if (low < high) {
        NSInteger partitionIndex = partition(arr, low, high);
        quicksort(arr, low, partitionIndex - 1);
        quicksort(arr, partitionIndex + 1, high);
    }
}

NSInteger partition(NSMutableArray<NSNumber *> *arr, NSInteger low, NSInteger high) {
    NSInteger r = arc4random_uniform((high - low + 1)) + low;
    [arr swapAt:r j:high];
    
    NSNumber *pivot = arr[high];
    
    NSInteger i = low;
    for (NSInteger j = low; j < high; j++) {
        if (arr[j].intValue <= pivot.intValue) {
            [arr swapAt:i j:j];
            i++;
        }
    }
    
    [arr swapAt:i j:high];
    
    return i;
}