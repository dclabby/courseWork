#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Sep 29 09:35:20 2021

@author: dclabby
"""


"""
Quiz 1: Python Practice

You can use this class to represent how classy someone
or something is.
"Classy" is interchangable with "fancy".
If you add fancy-looking items, you will increase
your "classiness".
Create a function in "Classy" that takes a string as
input and adds it to the "items" list.
Another method should calculate the "classiness"
value based on the items.
The following items have classiness points associated
with them:
"tophat" = 2
"bowtie" = 4
"monocle" = 5
Everything else has 0 points.
Use the test cases below to guide you!"""

class Classy(object):
    def __init__(self):
        self.items = []
    
    def addItem(self, item):
        self.items.append(item)
    
    def getClassiness(self):
        classiness = 0
        for item in self.items:
            if item == "tophat":
                classiness += 2
            elif item == "bowtie":
                classiness += 4
            elif item == "monocle":
                classiness += 5
        return classiness

# Test cases
me = Classy()

# Should be 0
print me.getClassiness()

me.addItem("tophat")
# Should be 2
print me.getClassiness()

me.addItem("bowtie")
me.addItem("jacket")
me.addItem("monocle")
# Should be 11
print me.getClassiness()

me.addItem("bowtie")
# Should be 15
print me.getClassiness()

"""
Quiz 2: Efficiency Practise

input manatees: a list of "manatees", where one manatee is represented by a dictionary
a single manatee has properties like "name", "age", et cetera
n = the number of elements in "manatees"
m = the number of properties per "manatee" (i.e. the number of keys in a manatee dictionary)"""

def example1(manatees):
    for manatee in manatees: # iterate through n manatees & print 1 feature -> O(n + 1) ~ O(n)
        print manatee['name']

def example2(manatees): # print 2 features for one manitee -> O(2)
    print manatees[0]['name']
    print manatees[0]['age']

def example3(manatees):
    for manatee in manatees: # iterate through n manatees
        for manatee_property in manatee: # iterate through m features
            print manatee_property, ": ", manatee[manatee_property] # -> O(n(m + 1) + 1) = O(nm + n + 1) ~ O(nm)

def example4(manatees):
    oldest_manatee = "No manatees here!"
    for manatee1 in manatees: # iterate through n manitees
        for manatee2 in manatees: # iterate through n manitees
            if manatee1['age'] < manatee2['age']: # -> O(n(n(2) + 1) + 1) = O(2n^2 + n + 1) ~ O(n^2) 
                oldest_manatee = manatee2['name']
            else:
                oldest_manatee = manatee1['name']
    print oldest_manatee