//
//  TripleStack.swift
//  
//
//  Created by Mohamed Shaat on 7/17/19.
//


import Foundation

struct TripleStack<Element> {
    
    private var numberOfStacks: Int = 3
    private var stackSize: Int = 0
    private var stack:[Element]
    private var topIndexies = [Int](repeating: 0, count: 3)
    
    init(stackSize: Int, initialValue: Element) {
        stack = [Element](repeating:initialValue, count: stackSize * numberOfStacks)
        self.stackSize = stackSize
        for i in 0...numberOfStacks-1  {
            topIndexies[i] = i * stackSize
        }
    }
    
    mutating func isEmpty(stackNumber: Int)-> Bool {
        let startIndex = (stackNumber - 1) * stackSize
        guard topIndexies[stackNumber-1] == startIndex  else {
            return false
        }
        return true
    }
    
    mutating func isFull(stackNumber: Int)-> Bool {
        let endIndex = (stackNumber - 1) * stackSize + stackSize
        guard topIndexies[stackNumber-1] == endIndex  else {
            return false
        }
        return true
    }
    
    mutating func push(item: Element,stackNumber: Int) {
        let endIndex = (stackNumber - 1) * stackSize + stackSize
        guard topIndexies[stackNumber - 1] < endIndex else {
            print("cannot push to stack")
            return
        }
        topIndexies[stackNumber - 1] += 1
        stack [topIndexies[stackNumber - 1]] = item
    }
    
    mutating func pop(stackNumber: Int) -> Element? {
        let startIndex = (stackNumber - 1) * stackSize
        guard topIndexies[stackNumber - 1] > startIndex else {
            print("cannot pop to stack")
            return nil
        }
        let value = stack [topIndexies[stackNumber - 1]]
        topIndexies[stackNumber - 1] -= 1
        return value
    }
    
}

var tripleStack = TripleStack<String>(stackSize: 2, initialValue: "0")
tripleStack.push(item: "1.1", stackNumber: 1)
tripleStack.push(item: "1.2", stackNumber: 1)

tripleStack.push(item: "2.1", stackNumber: 2)
tripleStack.push(item: "3.1", stackNumber: 3)
print("pop from 1: \(tripleStack.pop(stackNumber: 1))")
print("pop from 1: \(tripleStack.pop(stackNumber: 1))")
print("pop from 1: \(tripleStack.pop(stackNumber: 1))")
