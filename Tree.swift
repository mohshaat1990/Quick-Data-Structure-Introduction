//
//  Tree.swift
//  
//
//  Created by Mohamed Shaat on 3/10/19.
//


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


one.depthFirstPreorderTraversal(treeNode: one)

one.BreadethFirstInOrderTraversal(treeNode: one)
