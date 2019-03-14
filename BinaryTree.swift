
public class BinaryNode <Element> {
    
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init(_ value: Element) {
        self.value = value
    }
}

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
nine.leftChild = eight

seven.traverseInOrder(binaryNode: seven)
seven.traversePreOrder(binaryNode: seven)
