//
//  Heap.swift
//  
//
//  Created by Mohamed Shaat on 3/23/19.
//

import UIKit

struct Heap <Element> {
    /* The Heap has two properties: an array of Element types, and a priority function.
     The function takes two Elements and returns true if the first has a higher priority than the second. */
    
    var elements:[Element]
    let priorityFunction : (Element, Element) -> Bool
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    func peek() -> Element? {
        return elements.first
    }
    
    func isRoot(_ index: Int) -> Bool {
        return (index == 0)
    }
    
    func leftChildIndex(of index: Int) -> Int {
        return (2 * index) + 1
    }
    
    func rightChildIndex(of index: Int) -> Int {
        return (2 * index) + 2
    }
    
    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return priorityFunction(elements[firstIndex], elements[secondIndex])
    }
    /*
     The first assumes that a parent node has a valid index in the array, checks if the child node has a valid index in the array,
     and then compares the priorities of the nodes at those indices, and returns a valid index for whichever node has the highest priority.
     */
    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int {
        guard childIndex < count && isHigherPriority(at: childIndex, than: parentIndex)
            else { return parentIndex }
        return childIndex
    }
    
    /*
     assumes that the parent node index is valid, and compares the index to both of its left and right children – if they exist. Whichever of the three has the highest priority is the index returned.
     */
    
    func highestPriorityIndex(for parent: Int) -> Int {
        return highestPriorityIndex(of: highestPriorityIndex(of: parent, and: leftChildIndex(of: parent)), and: rightChildIndex(of: parent))
    }
    
    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        guard firstIndex != secondIndex
            else { return }
        elements.swapAt(firstIndex, secondIndex)
    }
    
    mutating func enqueue(_ element: Element) {
        elements.append(element)
        siftUp(elementAtIndex: count - 1)
    }
    
    mutating func siftUp(elementAtIndex index: Int) {
        let parent = parentIndex(of: index) // 1
        guard !isRoot(index), // 2
            isHigherPriority(at: index, than: parent) // 3
            else { return }
        swapElement(at: index, with: parent) // 4
        siftUp(elementAtIndex: parent) // 5
    }
    
    mutating func dequeue() -> Element? {
        guard !isEmpty // 1
            else { return nil }
        swapElement(at: 0, with: count - 1) // 2
        let element = elements.removeLast() // 3
        if !isEmpty { // 4
            siftDown(elementAtIndex: 0) // 5
        }
        return element // 6
    }
    
    mutating func siftDown(elementAtIndex index: Int) {
        let childIndex = highestPriorityIndex(for: index) // 1
        if index == childIndex { // 2
            return
        }
        swapElement(at: index, with: childIndex) // 3
        siftDown(elementAtIndex: childIndex)
    }
    
}

var heap = Heap(elements: [3, 2, 8, 5, 0], priorityFunction: >)

