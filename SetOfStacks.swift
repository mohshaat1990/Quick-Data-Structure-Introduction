//
//  SetOfStacks.swift
//  
//
//  Created by Mohamed Shaat on 7/20/19.
//

import Foundation

public class Stack<T> {
    private var array = [T]()
    
    public var isEmpty : Bool{
        return array.isEmpty
    }
    
    public var count : Int {
        return array.count
    }
    
    public  func push(element : T) {
        array.append(element)
    }
    
    public  func pop() -> T? {
        return array.popLast()
    }
    
    public var top : T? {
        return array.last
    }
}

public class SetStacks<T> {
    var maxSize = 0
    var stacks = [Stack<T>]()
    var stacksTopIndecies = [Int]()
    init(maxSize: Int) {
        self.maxSize = maxSize
    }
}
extension SetStacks {
    public  func push(element: T) {
        if var stack = stacks.last,!stack.isEmpty, stacksTopIndecies.last ?? 0  < maxSize {
            stack.push(element:element)
            stacksTopIndecies[stacksTopIndecies.count - 1] += 1
        } else {
            var stack = Stack<T>()
            stack.push(element:element)
            stacks.append(stack)
            stacksTopIndecies.append(1)
        }
    }
}
extension SetStacks {
    public  func pop(index: Int)-> T? {
        guard index < stacks.count else {
            return nil
        }
        var stack = stacks[index]
        let lastItem = stack.top
        stack.pop()
        if stack.isEmpty {
            stacks.remove(at: index)
            stacksTopIndecies.removeLast()
        } else {
            stacks[index] = stack
            stacksTopIndecies[stacksTopIndecies.count-1] -= 1
        }
        return lastItem
    }
}

var elements = [Int]()
for i in 0..<20 {
    elements.append(i)
}

var stacks = SetStacks<Int>(maxSize: 10)
for i in 0..<elements.count {
    
    stacks.push(element:elements[i])
    
}

print(stacks.pop(index:0))
print(stacks.pop(index:0))
print(stacks.pop(index:1))
print(stacks.pop(index:1))
