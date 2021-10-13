#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Sep 29 18:46:19 2021

@author: dclabby
"""

"""You're going to write a binary search function.
You should use an iterative approach - meaning
using loops.
Your function should take two inputs:
a Python list to search through, and the value
you're searching for.
Assume the list only has distinct elements,
meaning there are no repeated values, and 
elements are in a strictly increasing order.
Return the index of value, or -1 if the value
doesn't exist in the list."""

def binary_search(input_array, value):
    """
    Pseudo code:
        divide the list in two
        compare the test value to the last value in the first patition
        if the test value is greater than the last value in the first partition, repeat for second partition
        if the test value is less than the last value in the first partition, repeat for first partition
        if the test value is equal to the last value in the first partition, return the index
        
    """
    iValue = 0
    while len(input_array) >1:#>= 2:
        # print("Input array: " + str(input_array))
        # print("iValue: " + str(iValue))
        partitionIndex = len(input_array)//2
        left = input_array[:partitionIndex]
        right = input_array[partitionIndex:]
        if value == left[-1]:
            return iValue + partitionIndex - 1 
        elif value < left[-1]:
            input_array = left
        elif value > left[-1]:
            input_array = right
            iValue += partitionIndex
    
    if input_array[0] == value:
        return iValue
    else:
        return -1

testBinSearch = False
if testBinSearch:
    test_list = [1,3,9,11,15,19,29,32]
    test_val1 = 25
    test_val2 = 15
    test_val3 = 32
    print (binary_search(test_list, test_val1))
    print (binary_search(test_list, test_val2))
    print (binary_search(test_list, test_val3))

"""Implement a function recursively to get the desired
Fibonacci sequence value.
Your code should have the same input/output as the 
iterative code in the instructions."""

def get_fib(position):    
    """ 
        Explaination: the base cases are position = 0 or 1. In such cases the 
        function will return 0 or 1 (based on the value of position). The first
        and second numbers are determined from recursive calls to get_fib, with
        position decremented by 1 and 2 respectively.
    """
    if position <= 0:
        return 0
    elif position == 1:
        return 1
    
    first = get_fib(position - 2)
    second = get_fib(position - 1)
    return first + second
    
    # if position == 0 or position == 1:
    #     return position
    # return get_fib(position - 2) + get_fib(position -1)

testFib = False#True#
if testFib:
# Test cases
    print (get_fib(9))
    print (get_fib(11))
    print (get_fib(0))

"""
    Merge Sort 
"""
def mergeSort(arr):
    """ 
        Explaination: the base case is where the array has been reduced to a 
        single element. In this case the function returns this single element 
        array. Otherwise the array will be split in two parts, left & right.
        The mergeSort function is then recursively called. When the base case 
        is reached for each left & right, we will have two single element arrays
        to merge. They are merged and returned as a new array. The new array will
        be assigned either to the left or right variable in the calling function.
    """
    if len(arr) < 2:
        return arr
    else:
        iSplit = len(arr)//2
        left = arr[:iSplit]
        right = arr[iSplit:]
        
        left = mergeSort(left)
        right = mergeSort(right)
        
        # print("left: " + str(left))
        # print("right: " + str(right))
        
        iLeft = 0
        iRight = 0
        
        # newArr = []
        iA = 0
        while iLeft < len(left) and iRight < len(right):
            if left[iLeft] <= right[iRight]:
                # newArr.append(left[iLeft])
                arr[iA] = left[iLeft]
                iLeft += 1
            else:
                # newArr.append(right[iRight])
                arr[iA] = right[iRight]
                iRight += 1
            iA += 1
        
        # # This doesn't work since it would add elements to the array
        # if iLeft < len(left):
        #     arr += left[iLeft:]        
        # if iRight < len(right):
        #     arr += right[iRight:]
        
        while iLeft < len(left):
            # newArr.append(left[iLeft])
            arr[iA] = left[iLeft]
            iA += 1
            iLeft += 1
            
        while iRight < len(right):
            # newArr.append(right[iRight])
            arr[iA] = right[iRight]
            iA += 1
            iRight += 1
            
        # return newArr # created new sorted array
        return arr # sorts in place

testMergeSort = True
if testMergeSort:
    A = [1,2,2,7,3,12,6,-2,4,0,2]
    print("Original Array: " + str(A))
    
    # B = mergeSort(A)
    # print("Sorted Array: " + str(B))
    
    mergeSort(A)
    print("Sorted Array:   " + str(A))

"""Implement quick sort in Python.
Input a list.
Output a sorted list.
    
    if length of the array == 1 return None (this is the base case)

    pick the pivot as the final element 
    set the pivot index to the final index
    
    compare each element to the pivot & swap if necessary
    initialize the check index to 0
    compare check to pivot
    if check greater than pivot
        swap (pivot-1) with check and swap pivot with (pivot-1)
    otherwise
        increment the check index & repeat
    
    if check index == pivot
        split the array & recursively quicksort on each part

"""
def quicksort(array):
    if len(array) <= 1:
        return array
    
    iPivot = len(array) - 1
    iCheck = 0
    
    while iCheck < iPivot:
        if array[iCheck] > array[iPivot]:
            array[iCheck], array[iPivot-1] = array[iPivot-1], array[iCheck]
            array[iPivot-1], array[iPivot] = array[iPivot], array[iPivot-1]
            iPivot -= 1
        else:
            iCheck += 1
        # print(array)
        
    array[:iPivot] = quicksort(array[:iPivot])
    array[iPivot+1:] = quicksort(array[iPivot+1:])
    return array

testQuickSort = False
if testQuickSort:
    test = [21, 4, 1, -3, 9, 20, 25, 6, 21, 14, 7]
    print("Original list: " + str(test))
    print("Sorted list:   " + str(quicksort(test)))

