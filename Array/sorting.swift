//
//  Sorting.swift
//  dsa
//
//  Created by Brian Tamsing on 10/16/21.
//

import Foundation

func insertionSort(_ arr: [Int]) -> [Int] {
    var sorted = arr
    
    for i in 1..<arr.count {
        var currentIndex = i
        while currentIndex > 0  && arr[currentIndex] < arr[currentIndex - 1] {
            sorted.swapAt(currentIndex, currentIndex - 1)
            currentIndex -= 1
        }
    }
    
    return sorted
}

func mergesort(arr: [Int]) -> [Int] {
    if arr.count < 2 {
        return arr
    }
    
    let midpoint = arr.count / 2
    
    let left = mergesort(arr: Array(arr[..<midpoint]))
    let right = mergesort(arr: Array(arr[midpoint...]))
    
    return merge(left, right)
}

func merge(_ left: [Int], _ right: [Int]) -> [Int] {
    var i = 0, j = 0
    
    var arr = [Int]()
    arr.reserveCapacity(left.count + right.count)
    
    while i < left.count && j < right.count {
        if left[i] < right[j] {
            arr.append(left[i])
            i += 1
        } else if left[i] > right[j] {
            arr.append(right[j])
            j += 1
        } else {
            arr.append(left[i])
            arr.append(right[j])
            
            i += 1
            j += 1
        }
    }
    
    while i < left.count {
        arr.append(left[i])
        i += 1
    }
    
    while j < right.count {
        arr.append(right[j])
        j += 1
    }
        
    return arr
}

func quicksort<T: Comparable>(_ arr: inout [T], low: Int, high: Int) {
    if low < high {
        let partitionIndex = partition(&arr, low: low, high: high)
        quicksort(&arr, low: low, high: partitionIndex - 1)
        quicksort(&arr, low: partitionIndex + 1, high: high)
    }
}

func partition<T: Comparable>(_ arr: inout [T], low: Int, high: Int) -> Int {
    let randomizedPartitionIndex = Int.random(in: low...high)
    arr.swapAt(randomizedPartitionIndex, high)
    
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