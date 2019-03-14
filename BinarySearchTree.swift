//
//  InsertNodeInBinaryTree.swift
//
//
//  Created by Mohamed Shaat on 3/13/19.
//
public class BinaryNodeSearchTree <Element: Comparable> {
    
    public var value: Element
    public var leftChild: BinaryNodeSearchTree?
    public var rightChild: BinaryNodeSearchTree?
    
    public init(_ value: Element) {
        self.value = value
    }
    
}

extension BinaryNodeSearchTree {
    public func insertingNode(root: BinaryNodeSearchTree <Element>?, value: Element )-> BinaryNodeSearchTree <Element> {
        
        guard let root = root else {
            let node = BinaryNodeSearchTree(value)
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
