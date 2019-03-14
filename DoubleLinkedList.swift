//
//  DoubleLinkedList.swift
//  
//
//  Created by Mohamed Shaat on 3/10/19.
//

import UIKit
import Foundation

public class Node<Value> {
    var value: Value
    var next: Node?
    var previous: Node?
    
    init(value:Value) {
     self.value = value
    }
    
}

extension Node :CustomStringConvertible {
    
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value)----->\(next)"
    }
}

public struct DoubleLinkedList<Value> {
  
    var head: Node<Value>?
    var tail: Node<Value>?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    init(head:Node<Value>,tail:Node<Value>) {
        self.head = head
        self.tail = tail
    }
    
    public mutating func push(value: Value) {
       let newHead = Node(value: value)
        newHead.next = head
        head?.previous = newHead
        head = newHead
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(value:Value) {
        let newTaile = Node(value: value)
        tail?.next = newTaile
        newTaile.previous = tail
        tail = newTaile
    }
    
    public mutating func pop() ->Value? {
        defer {
            head = head?.next
            head?.previous = nil
            if isEmpty {
                tail = nil
            }}
        return head?.value
    }
    
  public mutating func sortedInsert(head: Node<Int>?, data: Int) -> Node<Int>? {
        let newNode = Node(value:data)
        if var head = head {
            var current = head
            
            while (current.value <= data && current.next != nil) {
                current = current.next!
            }
            
            if current.previous == nil {
                head = newNode
                head.next = current
                current.previous = newNode
            } else if (current.value > data) {
                newNode.previous = current.previous
                current.previous?.next = newNode
                current.previous = newNode
                
            } else {
                current.next = newNode;
                newNode.previous = current;
            }
        } else {
            return newNode;
        }
        
        return head
    }
    
}

extension DoubleLinkedList: CustomStringConvertible{
    
    public var description:String {
        guard let head = head else {
            return "EMPTY LIST"
        }
        return  "\(head)"
    }
}

let node1 = Node(value: 1)
let node2 = Node(value: 2)
node1.next = node2
node2.previous = node1
let node3 = Node(value: 3)
node2.next = node3
node3.previous = node2
let node4 = Node(value: 4)
node3.next = node4
node4.previous = node3
var linkedList = DoubleLinkedList(head: node1, tail:node4)
print(linkedList)
//print(linkedList)
