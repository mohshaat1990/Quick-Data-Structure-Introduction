//
//  StackWithMinimum.swift
//  
//
//  Created by Mohamed Shaat on 7/20/19.
//

import Foundation


public struct Stack<T: Comparable> {
    fileprivate var array = [T]()
    fileprivate var minArray = [T]()
    public var isEmpty : Bool{
        return array.isEmpty
    }
    
    public var count : Int {
        return array.count
    }
    
    public func min() -> T {
        return minArray.last!
    }
    
    public mutating func push(element : T) {
        array.append(element)
        if !minArray.isEmpty && element > min() {
            return
        }
        minArray.append(element)
    }
    
    public mutating func pop() -> T? {
        if let top = top, top == min() {
            minArray.popLast()
        }
        return array.popLast()
    }
    
    public var top : T? {
        return array.last
    }
}
extension Stack : ExpressibleByArrayLiteral {
    public init(arrayLiteral: T...) {
        for element in arrayLiteral {
            self.push(element:element )
        }
    }
}

var stack:Stack = [5,4,3,2,1,-1]
print(stack.min())
