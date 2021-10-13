#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Sep 29 10:55:06 2021

@author: dclabby
"""

"""
python list time complexity: https://wiki.python.org/moin/TimeComplexity

example len(list) has O(1) ... why is it not O(n)? Because you can get the length from the last index

"""

""" 
Linked Lists 

Add three functions to the LinkedList.
"get_position" returns the element at a certain position.
The "insert" function will add an element to a particular spot in the list.
"delete" will delete the first element with that particular value.
Then, use "Test Run" and "Submit" to run the test cases
at the bottom.

"""

class Element(object):
    def __init__(self, value):
        self.value = value
        self.next = None
        
class LinkedList(object):
    def __init__(self, head=None):
        self.head = head
        
    def append(self, new_element):
        current = self.head
        if self.head:
            while current.next:
                current = current.next
            current.next = new_element
        else:
            self.head = new_element
            
    def get_position(self, position):
        """Get an element from a particular position.
        Assume the first position is "1".
        Return "None" if position is not in the list.
        
        Pseudo code:
            initialize the counter and set current element to the start
            while the counter is less than the target position and the end of the list has not been reached
            check if the counter reached the target position on the present iteration
                if so, return the current element
                if it did not reach the target element, increment the counter and move to the next element
            if we get to the final element of the list, check if it is at the target position
                if it is, return the element
                otherwise return None
            
        """
        
        counter = 1
        current = self.head
        while counter <= position and current.next:
            if counter == position:
                return current
            else:
                counter += 1
                current = current.next 
        if counter == position:
            return current 
        else:
            return None
    
    def insert(self, new_element, position):
        """Insert a new node at the given position.
        Assume the first position is "1".
        Inserting at position 3 means between
        the 2nd and 3rd elements.
        
        Pseudo code:
            first, check if the new element will be inserted at the start
                if so, set the new element's next attribute to the present start
                and update the start to the new element
            if the new element is to be inserted at any other position
                initialize a counter and current element
                iterate through each elements until we reach the element before the position index or we reach the end of the list
                if we're at the insertion point, set the new element's next to the current element's next
                and set the current element's next to the new element
        """
        
        if position == 1:
            new_element.next = self.head
            self.head = new_element
        else:
            counter = 1
            current = self.head
            
            while counter != position - 1 and current.next:
                current = current.next 
                counter += 1
            if counter == position - 1:
                new_element.next = current.next 
                current.next = new_element
    
    
    def delete(self, value):
        """Delete the first node with a given value.
        
        Pseudo code:
            initialize the current element at the start and set the previous element to None
            move to the next element and check if its value matches the target
            if it does, exit the loop, otherwise continue
            if the current value matches the target
                and the previous element is not None then set he previous element's next to the current element's next (i.e. skip over the current element)
                otherwise if the previous element is None then delete the first element 
                
                finally, if the next element if None then we're at the end of the list, 
                so delete the last element by setting the previous element's next to None
            """
        
        current = self.head
        prev = None
        
        while current.value != value and current.next:
            prev = current
            current = current.next 
        
        if current.value == value:
            if prev:
                prev.next = current.next
            else:
                self.head = current.next
            if current.next == None:
                prev.next = None
    
    """
    Methods for Stacks - maybe extend the LinkedList class to a Stack class with these methods added
    """
    def insert_first(self, new_element):
        """Insert new element as the head of the LinkedList
        
        Pseudo code:
            set new element's next to the head element
            update the head to be the new element
        """
        new_element.next = self.head
        self.head = new_element

    def delete_first(self):
        """Delete the first (head) element in the LinkedList as return it
        
        Pseudo code:
            if the head is empty return None, otherwise
            store the head in a temporary variable
            set the head to be the next element
        """
        if self.head:
            deletedElement = self.head
            self.head = self.head.next
            return deletedElement
        else:
            return None

runLinkedListTests = False
if runLinkedListTests:
    # Test cases for Linked Lists
    # Set up some Elements
    e1 = Element(1)
    e2 = Element(2)
    e3 = Element(3)
    e4 = Element(4)
    
    # Start setting up a LinkedList
    ll = LinkedList(e1)
    ll.append(e2)
    ll.append(e3)
    
    # Test get_position
    # Should print 3
    print(ll.head.next.next.value)
    # Should also print 3
    print(ll.get_position(3).value)
    
    # Test insert
    ll.insert(e4,3)
    # Should print 4 now
    print(ll.get_position(3).value)
    
    # Test delete
    ll.delete(4)
    # Should print 2 now
    print(ll.get_position(1).value)
    # Should print 4 now
    print(ll.get_position(2).value)
    # Should print 3 now
    print(ll.get_position(3).value)

"""Add a couple methods to our LinkedList class,
and use that to implement a Stack.
You have 4 functions below to fill in:
insert_first, delete_first, push, and pop.
Think about this while you're implementing:
why is it easier to add an "insert_first"
function than just use "append"?"""
class Stack(object):
    def __init__(self,top=None):
        self.ll = LinkedList(top)

    def push(self, new_element):
        "Push (add) a new element onto the top of the stack"
        self.ll.insert_first(new_element)

    def pop(self):
        "Pop (remove) the first element off the top of the stack and return it"
        return self.ll.delete_first()

runStackTests = False
if runStackTests:
    # Test cases
    # Set up some Elements
    e1 = Element(1)
    e2 = Element(2)
    e3 = Element(3)
    e4 = Element(4)
    
    # Start setting up a Stack
    stack = Stack(e1)
    
    # Test stack functionality
    stack.push(e2)
    stack.push(e3)
    print(stack.pop().value)
    print(stack.pop().value)
    print(stack.pop().value)
    print(stack.pop())
    stack.push(e4)
    print(stack.pop().value)

"""Make a Queue class using a list!
Hint: You can use any Python list method
you'd like! Try to write each one in as 
few lines as possible.
Make sure you pass the test cases too!"""

class Queue:
    def __init__(self, head=None):
        self.storage = [head]

    def enqueue(self, new_element):
        self.storage.append(new_element)

    def peek(self):
        return self.storage[0] 

    def dequeue(self):
        return self.storage.pop(0)
    
# Setup
q = Queue(1)
q.enqueue(2)
q.enqueue(3)

# Test peek
# Should be 1
print(q.peek())

# Test dequeue
# Should be 1
print (q.dequeue())

# Test enqueue
q.enqueue(4)
# Should be 2
print (q.dequeue())
# Should be 3
print (q.dequeue())
# Should be 4
print (q.dequeue())
q.enqueue(5)
# Should be 5
print (q.peek())