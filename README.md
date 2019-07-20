# Data Structure Quick Introduction

- ## Introduction

- ## Array

- ## Dictionary

- ## Stack 

- ## Queue

-  ## Single Linked List

- ## Double Linked List

- ## Tree

- ## Binary tree 

- ## Binary Search Tree

- ## Heap

# Introduction

- Data structure consists of a Base Storage method ex (an array) and one or more algorithms that are used to access or modify data.
 
- The data structure is a particular way of organizing and storing data in a computer so that it can be accessed and modified efficiently. The data structure is a collection of data values, the relationships among them, and the functions or operations that can be applied to the data

- Abstract Data Types(ADT) is a mathematical model for data types, where a data type is defined by its behavior (semantics) from the point of view of a user of the data, specifically in terms of possible values, possible operations on data of this type, and the behavior of these operations. This contrasts with data structures, which are concrete representations of data, and are the point of view of an implementer, not a user. For example, integers are an ADT, defined as the values …, −2, −1, 0, 1, 2, …, and by the operations of addition, subtraction, multiplication, and division, together with greater than, less than, etc., which behave according to familiar mathematics (with care for integer division), independently of how the integers are represented by the computer. Ex (List, stack)

# Array

- An array is a container object that holds a fixed number of values of a single type. The length of an array is established when the array is created. After creation, its length is fixed. 
- Swift defines arrays using protcols . Each of these protcols layers more Capability on the array for example an Arrray is a sequence which means that you can iterate throught it at least once 
- Array is also RandomAccessCollection which makes guarantees about efficiency. for example the count proberty is guarantees about efficiency.
- Array are explicitly ordered.
```swift
let people = ["dema","yousef"]
```
- you can retrieve the value of an element in the array by writing the following
- the first factor is where you choose to insert the new element inside the array. the most efficient scenario for adding an element to an array is to append it to the end of the array
```swift
 people[0] // dema
 people[1] // yousef
```
- Array  Random acess handle element retrieval in constant O(1) time other data Structures Such as linked lists and trees don't have Constant time access
- there may come atime that you need to insert an element in aparticular location such as in the very middle of th array in such a senario, this is an O(n) operation
- the worst case when you try to insert an emelent in the head of the array .
- inserting new elements from anywhere from the end of the array will force elements to shuffle backwards to make new room for the new element.

# Dictionary

- A Dictionary is  generic collection that holds key value pairs. 
```swift
var scores: [String: Int] = ["Eric":9, "Mark": 12, "Wayn" :12];
```
- you can add anew entery to the dictionary with the following syntax: 
```swift
  scores ["Andrew"] = 0 
```
this creates anew key value pair in the dictionary : 
["Eric":9, "Mark": 12,"Andrew": 0,"Wayn": 12];
- inserting into a dictionary  is always O(1) time and look up operations are also done in O(1) time which siginficantly faster than the O(n) lookup time for aparticular element in the array

# Stack

- the stack is simple Data Structure You can only push to add a new element to the top of the stack, pop to remove the element from the top, and peek at the top element without popping it off.

- A stack gives you a LIFO or last-in-first-out order

- should I use a Linked List in implement Stack?
- Linked lists have several advantages over arrays. Elements can be inserted into linked lists indefinitely, while an array will eventually either fill up or need to be resized, an expensive operation that may not even be possible if memory is fragmented. Similarly, an array from which many elements are removed may become wastefully empty or need to be made smaller.

- On the other hand, arrays allow random access, while linked lists allow only sequential access to elements. Singly-linked lists, in fact, can only be traversed in one direction. This makes linked lists unsuitable for applications where it's useful to look up an element by its index quickly, such as heapsort. Sequential access on arrays is also faster than on linked lists on many machines due to the locality of reference and data caches. Linked lists receive almost no benefit from the cache.

- Another disadvantage of linked lists is the extra storage needed for references, which often makes them impractical for lists of small data items such as characters or boolean values. It can also be slow, and with a naïve allocator, wasteful, to allocate memory separately for each new element, a problem generally solved using memory pools.

```swift
public struct Stack<T> {
    fileprivate var array = [T]()
    
    public var isEmpty : Bool{
        return array.isEmpty
    }
    
    public var count : Int {
        return array.count
    }
    
    public mutating func push(element : T) {
     array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }

    public var top : T? {
        return array.last
    }
}

var stack = Stack(array:[1,2,3,4,5])
```
### Descripe how you could use asingle array to implement three stacks

```swift
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

```

### How would you design a stack which, in addition to push and pop, has a function min which returns the minimum element? Push, pop and min should all operate in 0(1) time.

```swift
import Foundation

public struct Stack<T:Comparable> {
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

```

# Queue

- A Queue is a linear structure that follows a particular order in which the operations are performed. The order is First In First Out (FIFO). A good example of a queue is any queue of consumers for a resource where the consumer that came first is served first. The difference between stacks and queues is in removing. In a stack we remove the item the most recently added; in a queue, we remove the item the least recently added.

```swift
public struct Queue<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public var front: T? {
        return array.first
    }
}
```
# Linked List 

- Linked lists have several advantages over arrays. Elements can be inserted into linked lists indefinitely, while an array will eventually either fill up or need to be resized, an expensive operation that may not even be possible if memory is fragmented. Similarly, an array from which many elements are removed may become wastefully empty or need to be made smaller.

- On the other hand, arrays allow random access, while linked lists allow only sequential access to elements. Singly-linked lists, in fact, can only be traversed in one direction. This makes linked lists unsuitable for applications where it's useful to look up an element by its index quickly, such as heapsort. Sequential access on arrays is also faster than on linked lists on many machines due to the locality of reference and data caches. Linked lists receive almost no benefit from the cache.

- Another disadvantage of linked lists is the extra storage needed for references, which often makes them impractical for lists of small data items such as characters or boolean values. It can also be slow, and with a naïve allocator, wasteful, to allocate memory separately for each new element, a problem generally solved using memory pools. 

![screen shot 2019-03-02 at 11 15 57 pm](https://user-images.githubusercontent.com/11280137/53687767-37368800-3d41-11e9-999a-c8d3da4de5ff.png)

```swift
// create Node
public class Node<Value> {

    var value:Value
    var next:Node?
    
    init(value:Value) {
        self.value = value
    }
}
```
- node have Two Responsibilities (1) Hold A value (2) Hold reference to the Next Node and the Nil Value Represent the end of the list.

![screen shot 2019-03-02 at 11 31 54 pm](https://user-images.githubusercontent.com/11280137/53687890-6b12ad00-3d43-11e9-9f7e-80f93e3553ca.png)

- you can print the value of node and reference to the next node by implementing CustomStringConvertible.

```swift
extension Node :CustomStringConvertible {
    
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value)----->\(next)"
    }
}
```

###  Now you can Implement The Class Of Linked List 

```swift
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
 ```
###  Finding aparticular node in the List. 
 
```swift

public func node(at index:Int)->Node<Value>? {
var currentIndex = 0
var currentNode = head
while (currentNode != nil && currentIndex < index) {
currentNode = currentNode?.next
currentIndex = currentIndex + 1
}
return currentNode;
}

```
###  insert New node after specific node

```swift
public mutating func insert(value:Value,after node:Node<Value>){
guard  tail !== node else {
append(value:value)
return
}
let newNode = Node(value:value)
newNode.next = node.next
node.next = newNode
}
```
###  get previous node Before index 

```swift
public func previousNode(at index:Int)->Node<Value>? {
var currentIndex = 0
var currentNode = head
while (currentNode != nil && currentIndex < index - 1) {
currentNode = currentNode?.next
currentIndex = currentIndex + 1
}
return currentNode;
}
```

###  insert node at specific index 

```swift
public mutating func push(value:Value) {
let newHead = Node(value: value)
newHead.next = head
head = newHead
if tail == nil {
tail = head
}

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
```

### pop from linked list 

```swift
public mutating func pop() ->Value? {
defer {
head = head?.next
if isEmpty {
tail = nil
}}
return head?.value
}
```

### remove node at index 

```swift
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

}
```
### revers Linked List 

```swift
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
```
### print Linked List In Reverse

```swift
public mutating func printLinkedListInReverse(head:Node<Value>?) {

if let head = head ,let next =  head.next  {
printLinkedListInReverse(head:next)
print("---->\(head.value)" , terminator:"")
} else if let head = head {
print("\(head.value)---->" , terminator:"")
}
}
```
### Delete duplicate-value nodes from a sorted linked list
```swift
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
```
### Compare two linked lists

```swift
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
```
### remove Duplicate LinkedList

```swift
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
```
### find index from end Linked List

```swift
mutating func findindexfromend(index: Int)-> Value? {
var offset  = 0
var next = head 
var current = head 
while(next != nil) {
if (offset >= index) {
current = current?.next 
}
offset = offset + 1
next = next?.next
}
return current?.value
}
```

# Double Link List 

a doubly linked list is a linked data structure that consists of a set of sequentially linked records called nodes. Each node contains three fields: two link fields (references to the previous and to the next node in the sequence of nodes) and one data field. The beginning and ending nodes' previous and next links, respectively, point to some kind of terminator, typically a sentinel node or null, to facilitate traversal of the list. If there is only one sentinel node, then the list is circularly linked via the sentinel node. It can be conceptualized as two singly linked lists formed from the same data items, but in opposite sequential orders.

![Screen Shot 2019-03-10 at 3 24 01 PM](https://user-images.githubusercontent.com/11280137/54085619-a6ffd080-4348-11e9-929e-b6fd6ad86d5d.png)

## Why Double Link List  ??

- You have ready access\insert on both ends.
- it can work as a Queue and a Stack at the same time.
- Node deletion requires no additional pointers.
- You can apply Hill-Climb traversal since you already have access on both ends.
- If you are storing Numerical values, and your list is sorted, you can keep a pointer/variable for median, then Search operation can be highly optimal using Statistical approach.

```swift

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
```
### Insert In Sorted Double Linked List

```swift
func sortedInsert(head: Node<Int>?, data: Int) -> Node<Int>? {
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
```
### Add Two linked List two Integers lists
5 --->5 --->1
(5 --->5)
Result (0 --->1 --->2)
```swift
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
```
- # Tree

- the tree is a data structure of profound importance . Trees are well-known as a non-linear data structure. They don’t store data in a linear way. They organize data hierarchically. It Solved alot of problems such as :

- representing hierarchical relationships.
- managing stored data.
- facilitating fast lookup operations.

![Screen Shot 2019-03-10 at 9 52 06 PM](https://user-images.githubusercontent.com/11280137/54090628-da5d5200-437e-11e9-95a5-427fb5c5b95e.png)

- ## Important Terms

-  Root : The node at the top of the tree is called root. There is only one root per tree and one path from the root node to any node.
- Parent :  Any node except the root node has one edge upward to a node called parent.
- Child :  The node below a given node connected by its edge downward is called its child node.
- Leaf : The node which does not have any child node is called the leaf node.
- Subtree :  Subtree represents the descendants of a node.


![Screen Shot 2019-03-10 at 10 07 59 PM](https://user-images.githubusercontent.com/11280137/54090834-04177880-4381-11e9-90e9-20096615c3ae.png)

```swift
public class TreeNode <T> {

public var value: T
public var children: [TreeNode] = []

public init(_ value: T) {
self.value = value
}

public func add(_ child: TreeNode) {
children.append(child)
}

}

let beverages = TreeNode("Beverages")
let hot = TreeNode("Hot")
let cold = TreeNode("Cold")
beverages.add(hot)
beverages.add(cold)
```
# Tree Traversal 

- A Tree is typically traversed in two ways: 
- 1- Breadth First Traversal (Or Level Order Traversal) 
- 2- Depth First Traversals (Inorder Traversal (Left-Root-Right) , Preorder Traversal (Root-Left-Right),Postorder Traversal (Left-Right-Root))

![Screen Shot 2019-03-11 at 10 42 53 PM](https://user-images.githubusercontent.com/11280137/54156475-0516db80-444f-11e9-92ac-f037f4f45c99.png)

```swift
extension TreeNode {

func depthFirstPreorderTraversal(treeNode: TreeNode <T>) {
print(treeNode.value)
for chidtraverse in treeNode.children {
depthFirstPreorderTraversal(treeNode:chidtraverse)
}
}

func BreadethFirstInOrderTraversal(treeNode: TreeNode) {
print(treeNode.value)
printChildrens(children:treeNode.children)
for chid in treeNode.children {
printChildrens(children:chid.children)
}
}

func printChildrens(children: [TreeNode <T>]) {
for chidtraverse in children {
print(chidtraverse.value)
}
}
}
let one = TreeNode("1")
let two = TreeNode("2")
let three = TreeNode("3")

let four = TreeNode("4")
let five = TreeNode("5")

one.add(two)
one.add(three)

two.add(four)
two.add(five)


one.depthFirstPreorderTraversal(treeNode: one) // 1 2 4 5 3

one.BreadethFirstInOrderTraversal(treeNode: one) // 1 2 3 4 5

```
# Binary tree 

- A binary tree at abasic tree where each node has at most two chilrdern, often referred to as the left and right Children 

  ![Screen Shot 2019-03-12 at 9 11 29 PM](https://user-images.githubusercontent.com/11280137/54228738-761bc900-450b-11e9-907b-fd27f80d7e37.png)

```swift
public class BinaryNode <Element> {

public var value: Element
public var leftChild: BinaryNode?
public var rightChild: BinaryNode?

public init(_ value: Element) {
self.value = value
}
}

let zero = BinaryNode(0)
let one  = BinaryNode(1)
let five  = BinaryNode(5)
let seven  = BinaryNode(7)
let eight  = BinaryNode(8)
let nine = BinaryNode(9)

seven.leftChild = one
seven.rightChild = nine
one.leftChild  = zero
one.rightChild = five
nine.rightChild = eight
```
![Screen Shot 2019-03-12 at 9 22 45 PM](https://user-images.githubusercontent.com/11280137/54229510-17efe580-450d-11e9-8bb3-f89630b447cb.png)

## Binary tree ( In Order Traversal )

- if the the current node has a left child , recursievely visit this child first
- then visit the node it self.
- if the current node has aright child, recursively visit this child

```swift
extension BinaryNode {
public func traverseInOrder(binaryNode: BinaryNode<Element>?) {
if binaryNode == nil {
return
}
traverseInOrder(binaryNode:binaryNode?.leftChild)
if let value = binaryNode?.value {
print(value)
}
traverseInOrder(binaryNode:binaryNode?.rightChild)
}
}
```
## Binary tree ( PreOrder Traversal )

Pre-order traversal always visits the current node first, then
recursively visits the left and right child:

```swift
extension BinaryNode {
public func traversePreOrder(binaryNode: BinaryNode<Element>?) {

if binaryNode == nil {
return
}
if let value = binaryNode?.value {
print(value)
}
traversePreOrder(binaryNode:binaryNode?.leftChild)
traversePreOrder(binaryNode:binaryNode?.rightChild)
}
}
```

## Binary tree ( PostOrder Traversal )

Post-order traversal only visits the current node after the left and
right child have been visited recursively:

```swift
extension BinaryNode {
public func traversePostOrder(binaryNode: BinaryNode<Element>?) {

if binaryNode == nil {
return
}
traversePostOrder(binaryNode:binaryNode?.leftChild)
traversePostOrder(binaryNode:binaryNode?.rightChild)
if let value = binaryNode?.value {
print(value)
}
}
}
```

## Binary Search Tree

- A binary search tree (or BST) is a data structure that facilitates fast
lookup, addition, and removal operations. Each operation has an
average time complexity of O(log n), which is considerably faster than
linear data structures such as arrays and linked lists.
The value of a left child must be less than the value of its parent.
The value of a right child must be greater than or equal to the
value of its parent.

## Insert Node Binary Search Tree

```swift
public class BinaryNode <Element: Comparable> {

public var value: Element
public var leftChild: BinaryNode?
public var rightChild: BinaryNode?

public init(_ value: Element) {
self.value = value
}

}

extension BinaryNode {
public func insertingNode(root: BinaryNode<Element>?, value: Element )-> BinaryNode<Element> {

guard let root = root else {
let node = BinaryNode(value)
return node
}

if value < root.value {
root.leftChild = insertingNode(root: root.leftChild, value: value)
} else {
root.rightChild = insertingNode(root: root.rightChild, value: value)
}
return root
}
}
seven.insertingNode(root: seven, value: 2)
```
## Binary Search Tree Search for Item 

- Start off by setting current to the root node.
- While current is not nil, check the current node’s value.
- If the value is equal to what you’re trying to find, return true.
- Otherwise, decide whether you’re going to check the left or the
right child.

```swift
extension BinaryNodeSearchTree {
public func contains(root: BinaryNodeSearchTree <Element>?, _ value: Element )-> Bool {

var current = root
while let node = current {
if node.value == value {
return true
}
if value < node.value {
current = node.leftChild
} else {
current = node.rightChild
}
}
return false
}
}
```
## Binary Search Tree Removing an Item 

### Case 1: Remove Leaf node

![Screen Shot 2019-03-15 at 1 07 07 AM](https://user-images.githubusercontent.com/11280137/54397322-be2f1d00-46be-11e9-85dc-c16f015c4ada.png)
- Simply detaching the leaf node is enough. For non-leaf nodes however, there are extra steps to be taken.

### Case 2: Nodes with one child

![Screen Shot 2019-03-15 at 1 11 05 AM](https://user-images.githubusercontent.com/11280137/54397480-49101780-46bf-11e9-869c-0a42d763b2e3.png)

When removing nodes with one child, you’ll need to reconnect that
one child with the rest of the tree.

 ### Case 3: Nodes with two children
 
 ![Screen Shot 2019-03-15 at 1 13 36 AM](https://user-images.githubusercontent.com/11280137/54397577-a4daa080-46bf-11e9-8562-0c2ced08e658.png)


-  Y ou have two child nodes (12 and 37) to reconnect, but the parent
node only has space for one child. To solve this problem, you’ll
implement a clever workaround by performing a swap.

![Screen Shot 2019-03-15 at 1 15 32 AM](https://user-images.githubusercontent.com/11280137/54397647-d7849900-46bf-11e9-9dab-ca584a446ee9.png)

-  When removing a node with two children, replace the node you
removed with smallest node in its right subtree. Based on the rules of
the BST, this is the leftmost node of the right subtree: 

![Screen Shot 2019-03-15 at 1 17 03 AM](https://user-images.githubusercontent.com/11280137/54397698-0dc21880-46c0-11e9-8aaf-0ead70595c01.png)

![Screen Shot 2019-03-15 at 1 17 38 AM](https://user-images.githubusercontent.com/11280137/54397723-229eac00-46c0-11e9-9740-5357722dda8a.png)

- # Heap (Reference RayWenderlish )

- The Heap is a really neat data structure which allows for the prioritization of minimum or maximum values. 
- It is somewhat similar to a Tree in how it’s structured with layers and nodes however it can be easily stored in an Array because it is linear in nature.
- Heap can be either a max heap or a min heap.
- In a max heap, the root node is the largest element and all the child nodes must be smaller than the parent. Min-heap works just the opposite way.
- Children of a node at N would be positioned at 2n+1 and 2n+2 in a max heap.
- in Heap has the fewest possible number of levels to contain all its nodes. Before a new level can be added, all the existing levels must be full.

![Screen Shot 2019-03-23 at 12 31 06 AM](https://user-images.githubusercontent.com/11280137/54856396-05429100-4d03-11e9-97b8-5e8b0ba0ee85.png)
![Screen Shot 2019-03-23 at 12 32 20 AM](https://user-images.githubusercontent.com/11280137/54856437-2d31f480-4d03-11e9-83c0-604fca0e54e8.png)

- Every node in the heap is assigned an index. We start by assigning 0 to the root node, and then we iterate down through the levels, counting each node from left to right :

![Screen Shot 2019-03-23 at 12 49 45 AM](https://user-images.githubusercontent.com/11280137/54856952-91ee4e80-4d05-11e9-99a0-66dd3f5f1ae1.png)

-  If we then used those indices to make an array, with each element stored in its indexed position, it would look like this:

![Screen Shot 2019-03-23 at 12 50 35 AM](https://user-images.githubusercontent.com/11280137/54857038-f6a9a900-4d05-11e9-93a5-f9ded328df80.png)

- Given the node at index i, its left child node can be found at index 2i + 1 and its right child node can be found at index 2i + 2.

![Screen Shot 2019-03-23 at 12 55 05 AM](https://user-images.githubusercontent.com/11280137/54857136-720b5a80-4d06-11e9-83f9-5f4250b61acf.png)


- ## Heapify 
- Removing an element requires a rearrange of the heap data structure. This is termed as heapifying.
- For example, if you delete the root node of the heap. For that, we need to swap it with the lowest node with the root node and then check the heap property recursively throughout.

![Screen Shot 2019-03-23 at 1 07 31 AM](https://user-images.githubusercontent.com/11280137/54857473-18a42b00-4d08-11e9-90f9-ee957d5451a1.png)
![Screen Shot 2019-03-23 at 1 08 40 AM](https://user-images.githubusercontent.com/11280137/54857491-3bceda80-4d08-11e9-89c7-ad29b614238c.png)

```swift
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
```
