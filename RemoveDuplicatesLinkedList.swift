//
//  RemoveDuplicatesLinkedList.swift
//  
//
//  Created by Mohamed Shaat on 7/12/19.
//

import Foundation



public class Node <Value> {
    var value : Value
    var next: Node?
    init(value: Value, next: Node?) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        if let next = next {
            return "\(value) --->\(next)"
        }
        return "\(value)"
    }
}

public struct LinkedList<Value: Equatable> {
    var head: Node<Value>?
    var tail: Node<Value>?
    
    init(head: Node<Value>,tail: Node<Value>) {
        self.head = head
        self.tail = tail
    }
    
    public mutating func push(value: Value) {
        let newHead = Node(value: value, next: head)
        head = newHead
        if tail == nil {
            tail = head
        }
    }

    public mutating func append(value: Value) {
        let node = Node(value: value, next: nil)
        if head == nil {
            head = node
            tail = node
        } else {
        tail?.next = node
        tail = node
        }
    }
    
    mutating func removeDuplicates() {
        var current = head
        var previous = head
        var next = head
        while current != nil {
            next = next?.next
            if next == nil {
                current = current?.next
                next = current
                previous = current
                continue
            }
            if current?.value == next?.value {
                previous?.next = next?.next
            }
            if previous?.next == nil {
                tail = previous
            }
            previous = next
        }
    }
}

let node7 = Node(value: 7, next: nil)
let node6 = Node(value: 6, next: node7)
let node5 = Node(value: 5, next: node6)
let node4 = Node(value: 4, next: node5)
let node3 = Node(value: 3, next: node4)
let node2 = Node(value: 2, next: node3)
let node1 = Node(value: 1, next: node2)
var linkedList = LinkedList(head: node1, tail: node7)
print(linkedList.tail)
linkedList.push(value: 1)

linkedList.append(value:6)
linkedList.removeDuplicates()
print(linkedList.head)
