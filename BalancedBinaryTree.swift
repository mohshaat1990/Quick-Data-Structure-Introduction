//
//  BalancedBinaryTree.swift
//  
//
//  Created by Mohamed Shaat on 8/11/19.
//

import Foundation

public class BinaryNode<Element: Comparable> {
    
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init (_ value: Element) {
        self.value = value
    }
    
}
extension BinaryNode {
    public func insertNode(root:BinaryNode<Element>?,value: Element) -> BinaryNode<Element> {
        
        guard let root = root else {
            let node = BinaryNode(value)
            return node
        }
        if value < root.value {
            root.leftChild = insertNode(root: root.leftChild ,value: value)
        } else {
            root.rightChild = insertNode(root: root.rightChild ,value: value)
        }
        return root
    }
}

extension BinaryNode {
    func isBalanced(root : BinaryNode<Element>?)-> Bool {
        if root == nil {
            return true
        }
        var lh =  height(root: root!.leftChild)
        var rh =  height(root: root!.rightChild)
        if (abs(lh - rh) <= 1) {
            return true
        } else {
            return false
        }
    }
    func height(root: BinaryNode<Element>?) -> Int {
        if root == nil {
            return 0
        }
        return 1 + max(height(root: root!.leftChild),height(root: root!.rightChild))
    }
}

let binaryNode1 = BinaryNode(1)
let binaryNode2 = BinaryNode(2)
let binaryNode3 = BinaryNode(3)
let binaryNode4 = BinaryNode(4)
let binaryNode5 = BinaryNode(5)
binaryNode1.leftChild = binaryNode2
binaryNode1.rightChild = binaryNode3
binaryNode2.leftChild = binaryNode4
//binaryNode4.leftChild = binaryNode5
print(binaryNode1.isBalanced(root:binaryNode1))
