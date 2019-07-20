//
//  SortableStack.swift
//  
//
//  Created by Mohamed Shaat on 7/21/19.
//

import Foundation

public class SortableStack<T:Comparable> {
    var array = [T]()
    init(array:[T]) {
        self.array = array
    }
    
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
extension SortableStack {
    public  func sort() {
        var stackPlaceHolders = SortableStack<T>(array:[])
        while top != nil , let x = top {
            pop()
            while  stackPlaceHolders.top != nil , let y = stackPlaceHolders.top , y > x {
                stackPlaceHolders.pop()
                push(element:y)
            }
            stackPlaceHolders.push(element:x)
        }
        self.array = stackPlaceHolders.array
    }
}

var stack = SortableStack(array:[5,4,3,2,1])
stack.sort()
print("Stack\(stack.array)")
