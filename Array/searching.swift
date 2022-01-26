//
//  Searching.swift
//  dsa
//
//  Created by Brian Tamsing on 10/16/21.
//

import Foundation

func binarySearch<T: Comparable>(_ arr: [T], target: T) -> Int? {
    var low = 0
    var high = arr.count
    
    while low < high {
        let midpoint = low + (high - low) / 2
        
        if arr[midpoint] == target {
            return midpoint
        } else if arr[midpoint] < target {
            low = midpoint + 1
        } else {
            high = midpoint
        }
    }
    
    return nil
}

func countOccurences<T: Comparable>(of key: T, in arr: [T]) -> Int {
    var leftBoundary: Int {
        var low = 0
        var high = arr.count
        
        while low < high {
            let midpoint = low + (high - low) / 2
            if arr[midpoint] < key {
                low = midpoint + 1
            } else {
                high = midpoint
            }
        }
        
        return low
    }
    
    var rightBoundary: Int {
        var low = 0
        var high = arr.count
        
        while low < high {
            let midpoint = low + (high - low) / 2
            if arr[midpoint] > key {
                high = midpoint
            } else {
                low = midpoint + 1
            }
        }
        
        return low
    }
    
    return rightBoundary - leftBoundary
}

func kthLargest(k: Int, in arr: [Int]) -> Int {
    var a = arr
    var k = a.count - k
    
    func kthSelect(k: Int, in arr: inout [Int], low: Int, high: Int) -> Int {
        if low < high {
            let partitionIndex = kthPartition(&arr, low: low, high: high)
            
            if k == partitionIndex { 
                return arr[partitionIndex]
            } else if k < partitionIndex {
                return kthSelect(k: k, in: &arr, low: low, high: partitionIndex - 1)
            } else {
                return kthSelect(k: k, in: &arr, low: partitionIndex + 1, high: high)
            }
        } else {
            return arr[low]
        }
    }
    
    func kthPartition(_ arr: inout [Int], low: Int, high: Int) -> Int {
        let randomizedPivotIndex = Int.random(in: low...high)
        arr.swapAt(randomizedPivotIndex, high)
        
        let pivot = arr[high]
        
        var i = low
        for j in low..<high {
            if arr[j] <= pivot {
                arr.swapAt(i, j)
                i += 1
            }
        }
        
        arr.swapAt(i, high)
        return i
    }
    
    return kthSelect(k: k, in: &a, low: 0, high: arr.count - 1)
}