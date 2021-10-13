#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Oct  4 18:34:10 2021

@author: dclabby
"""



class Node(object):
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

class BinaryTree(object):
    def __init__(self, root):
        self.root = Node(root)

    def search(self, find_val):
        """Return True if the value
        is in the tree, return
        False otherwise."""
        return self.preorder_search(self.root, find_val)

    def print_tree(self):
        """Print out all tree nodes
        as they are visited in
        a pre-order traversal."""  
        traversal = self.preorder_print(self.root, "")      
        return traversal[:-1]

    def preorder_search(self, start, find_val):
        """Helper method - use this to create a 
        recursive search solution."""
        if start == None:
            return False
        elif start.value == find_val:
            return True
        # print(start.value)
        return self.preorder_search(start.left, find_val)
        return self.preorder_search(start.right, find_val)
        

    def preorder_print(self, start, traversal):
        """Helper method - use this to create a 
        recursive print solution."""
        if start == None:
            return traversal
        traversal += str(start.value) + "-"
        traversal = self.preorder_print(start.left, traversal)
        traversal = self.preorder_print(start.right, traversal)
        return traversal

testBinTree = False
if testBinTree:
    # Set up tree
    tree = BinaryTree(1)
    tree.root.left = Node(2)
    tree.root.right = Node(3)
    tree.root.left.left = Node(4)
    tree.root.left.right = Node(5)
    
    # Test search
    # Should be True
    print (tree.search(4))
    # Should be False
    print (tree.search(6))
    
    # Test print_tree
    # Should be 1-2-4-5-3
    print (tree.print_tree())

class BST(object):
    def __init__(self, root):
        self.root = Node(root)
    
    # def insert(self, new_val):
    #     self.insert_helper(self.root, new_val)

    # def insert_helper(self, current, new_val):
    #     if current.value < new_val:
    #         if current.right:
    #             self.insert_helper(current.right, new_val)
    #         else:
    #             current.right = Node(new_val)
    #     else:
    #         if current.left:
    #             self.insert_helper(current.left, new_val)
    #         else:
    #             current.left = Node(new_val)

    # def search(self, find_val):
    #     return self.search_helper(self.root, find_val)

    # def search_helper(self, current, find_val):
    #     if current:
    #         if current.value == find_val:
    #             return True
    #         elif current.value < find_val:
    #             return self.search_helper(current.right, find_val)
    #         else:
    #             return self.search_helper(current.left, find_val)
    #     return False
    
    def insert(self, new_val):
        self.binary_insert(self.root, new_val)

    def search(self, find_val):
        return self.binary_search(self.root, find_val)
    
    def binary_search(self, start, find_val):
        if start == None:
            return False
        elif start.value == find_val:
            return True
        elif start.left:
            if find_val > start.left.value:
                return self.binary_search(start.right, find_val)
            else:                
                return self.binary_search(start.left, find_val)
        else:
            return False
    
    def binary_insert(self, start, new_val):        
        if start.left == None and start.right == None:
            start.left = Node(new_val)
            return
        elif start.left != None and start.right == None:
            start.right = Node(new_val)
            if start.left.value > start.right.value:
                start.left, start.right = start.right, start.left
            return
        elif start.left == None and start.right != None:
            start.left = Node(new_val)
            if start.left.value > start.right.value:
                start.left, start.right = start.right, start.left
            return
        else:
            if new_val > start.left.value:
                self.binary_insert(start.right, new_val)
            else:
                self.binary_insert(start.left, new_val)
            return
    
# Set up tree
tree = BST(4)

# Insert elements
tree.insert(2)
tree.insert(1)
tree.insert(3)
tree.insert(5)
tree.insert(-1)
tree.insert(10)

"""
        4
       / \
      1  2
     /  / \ 
   -1  3  5
         /
       10
"""

# Check search
# Should be True
print (tree.search(5))
print (tree.search(-1))
print (tree.search(10))
# Should be False
print (tree.search(6))
print (tree.search(-2))
print (tree.search(11))