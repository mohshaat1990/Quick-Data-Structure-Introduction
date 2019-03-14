public class Node<Value> {

    var value:Value
    var next:Node?
    
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

public struct LinkedList<Value>{
    
    var head:Node<Value>?
    var tail:Node<Value>?
    
    public var isEmpty: Bool {
     return head == nil
    }
    
    init(head:Node<Value>,tail:Node<Value>) {
       self.head = head
       self.tail = tail
    }
    
    public mutating func push(value:Value) {
     let newHead = Node(value: value)
        newHead.next = head
        head = newHead
        if tail == nil {
         tail = head
        }
        
    }
    
    public mutating func append(value:Value) {
        let newTaile = Node(value: value)
        tail?.next = newTaile
        tail = newTaile
    }
    
    public func previousNode(at index:Int)->Node<Value>? {
       var currentIndex = 0
       var currentNode = head
        while (currentNode != nil && currentIndex < index - 1) {
          currentNode = currentNode?.next
          currentIndex = currentIndex + 1
        }
        return currentNode;
    }
    
    public func node(at index:Int)->Node<Value>? {
        var currentIndex = 0
        var currentNode = head
        while (currentNode != nil && currentIndex < index) {
            currentNode = currentNode?.next
            currentIndex = currentIndex + 1
        }
        return currentNode;
    }
    
    public mutating func insert(value:Value,after node:Node<Value>){
        guard  tail !== node else {
          append(value:value)
          return
        }
        let newNode = Node(value:value)
        newNode.next = node.next
        node.next = newNode
    }
    
    public mutating func insert(value:Value ,at index:Int){
        guard index != 0 else {
            push(value:value)
            return
        }
        let node = self.previousNode(at:index)
        let insertedNode = Node(value:value)
        insertedNode.next = node?.next
        node?.next = insertedNode
    }
    
    public mutating func pop() ->Value? {
       defer {
          head = head?.next
        if isEmpty {
         tail = nil
          }}
        return head?.value
    }
    
    public mutating func remove(at index: Int) {
        guard index != 0 else {
            self.pop()
            return
        }
        
        let previousNode = self.previousNode(at: index)
        let currentNode = self.node(at: index)
        guard tail !== currentNode else {
            previousNode?.next = currentNode?.next
          tail = previousNode
          return
        }
       
        previousNode?.next = currentNode?.next
        
    }
    
    public mutating func reverseLinkedList() {
        var current = head
        var prev:Node<Value>?
        var next:Node<Value>?
        tail = head
        while(current != nil) {
            next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        head = prev
    }
    
    public mutating func deleteDuplicatesLinkedList (head:Node<Int>?) {
        if head == nil || head?.next == nil {
            return
        } else {
            var current = head
            while  current?.next != nil {
                if let current = current, let next = current.next , current.value == next.value {
                    current.next = current.next?.next
                } else {
                    current = current?.next
                }
            }
        }
    }
    
    public mutating func equal (head1:Node<Int>?,head2:Node<Int>?)-> Bool {
        if head1 == nil && head2 == nil {
            return true
        } else if head1?.value ==  head2?.value {
            let result = equal(head1: head1?.next, head2: head2?.next)
            return result
        } else {
            return false
        }
    }
  
}

extension LinkedList: CustomStringConvertible{
    
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
let node3 = Node(value: 3)
node2.next = node3
let node4 = Node(value: 4)
node3.next = node4
var linkedList = LinkedList(head: node1, tail:node4)
linkedList.push(value: 5)
linkedList.append(value: 6)
print(linkedList)
linkedList.insert(value: 6, after: node4)
linkedList.insert(value: 0, at: 1)
print(linkedList)
linkedList.remove(at: 7)
print(linkedList)
linkedList.reverseLinkedList()
print(linkedList)
