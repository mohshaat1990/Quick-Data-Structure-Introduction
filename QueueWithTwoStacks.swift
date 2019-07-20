//
//  QueueWithTwoStacks.swift
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

class MyQueue<T> {
    private var stack = Stack<T>()
    private var placeHoldersStack = Stack<T>()
    func enqueue(item: T) {
        while stack.top != nil {
            placeHoldersStack.push(element:stack.top!)
            stack.pop()
        }
        stack.push(element:item )
        while placeHoldersStack.top != nil {
            stack.push(element:placeHoldersStack.top!)
            placeHoldersStack.pop()
        }
    }
    func dequeue() -> T? {
        let top = stack.top
        stack.pop()
        return top
    }
}
var queue = MyQueue<Int>()

for i in 0..<5 {
    queue.enqueue(item: i)
}
for i in 0..<5 {
    print(queue.dequeue())
}
