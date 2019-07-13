import UIKit

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
    init () {
    }
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
    
    mutating func deleteNode(nodeValue: Value) {
        if head?.value == nodeValue {
            head?.next = head?.next?.next
            return
        }
        var current = self.head
        while (current != nil) {
            if current?.next?.value == nodeValue {
                current?.next = current?.next?.next
            }
            current = current?.next
        }
    }
}

func addTwoLists (linkedList1 : LinkedList<Int>, linkedList2 : LinkedList<Int>) -> LinkedList<Int>{
    var current1 = linkedList1.head
    var current2 = linkedList2.head
    var sumLinkedList = LinkedList<Int>()
    var carry = 0
    while (current1 != nil || current2 != nil) {
        var total = carry
        if let current = current1 {
            total = total + current.value
        }
        if let current = current2 {
            total = total + current.value
        }
        if total >= 10 {
            total = total - 10
            carry = 1
        } else {
            carry = 0
        }
        current1 = current1?.next
        current2 = current2?.next
        print(total)
        sumLinkedList.append(value: total)
    }
    return sumLinkedList
}

let node11 = Node(value: 1, next: nil)
let node22 = Node(value: 5, next: node11)
let node33 = Node(value: 5, next: node22)
let node44 = Node(value: 5, next: nil)
let node55 = Node(value: 5, next: node44)
//let node66 = Node(value: 3, next: node55)

var linkedList1 = LinkedList(head: node33, tail: node11)
var linkedList2 = LinkedList(head: node55, tail: node44)
print(linkedList1.head)
print(linkedList2.head)
print(addTwoLists(linkedList1: linkedList1, linkedList2: linkedList2))
