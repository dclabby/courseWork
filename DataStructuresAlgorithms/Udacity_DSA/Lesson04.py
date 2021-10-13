#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Sep 30 18:49:08 2021

@author: dclabby
"""
"""Time to play with Python dictionaries! You're going to work on a dictionary that
stores cities by country and continent. One is done for you - the city of Mountain 
View is in the USA, which is in North America.

You need to add the cities listed below by modifying the structure.
Then, you should print out the values specified by looking them up in the structure.

Cities to add:
Bangalore (India, Asia)
Atlanta (USA, North America)
Cairo (Egypt, Africa)
Shanghai (China, Asia)"""

locations = {'North America': {'USA': ['Mountain View']}}
locations['Asia'] =  {'India': 'Bangalore'}
locations['North America']['USA'].append('Atlanta')
locations['Africa'] =  {'Egypt': 'Cairo'}
locations['Asia']['China'] = 'Shanghai'

"""Print the following (using "print").
1. A list of all cities in the USA in alphabetic order. 2. All cities in Asia, in alphabetic
order, next to the name of the country. In your output, label each answer with a number
so it looks like this:
1
American City
American City
2
Asian City - Country
Asian City - Country"""

testDict = False
if testDict:
    print("1")
    cities = locations['North America']['USA']
    for city in sorted(cities):
        print(str(city))
    
    print("2")
    temp = []
    cities = locations['Asia']
    for country in cities.keys():
        temp.append(cities[country] + " - " + country)
    for city in sorted(temp):
        print(str(city))


"""Write a HashTable class that stores strings in a hash table, where keys are calculated
using the first two letters of the string:

Hash Value = (ASCII Value of First Letter * 100) + ASCII Value of Second Letter 

You can use the Python function ord() to get the ASCII value of a letter, and chr() to get 
the letter associated with an ASCII value. """

class HashTable(object):
    def __init__(self):
        self.table = [None]*10000
    
    def store(self, string):
        """Input a string that's stored in the table."""
        
        # hashValue = ord(string[0])*100 + ord(string[1])
        hashValue = self.calculate_hash_value(string)
        if self.table[hashValue] != None:
            self.table[hashValue].append(string)
        else:
            self.table[hashValue] = [string]
        pass

    def lookup(self, string):
        """Return the hash value if the string is already in the table.
        Return -1 otherwise."""
        
        # hashValue = ord(string[0])*100 + ord(string[1])
        hashValue = self.calculate_hash_value(string)
        
        if self.table[hashValue]:
            if string in self.table[hashValue]:
                return hashValue
        else:
            return -1
            
    def calculate_hash_value(self, string):
        """Helper function to calulate a hash value from a string."""
        hashValue = ord(string[0])*100 + ord(string[1])
        return hashValue
        
# Setup
hash_table = HashTable()

# Test calculate_hash_value
# Should be 8568
print(hash_table.calculate_hash_value('UDACITY'))

# Test lookup edge case
# Should be -1
print(hash_table.lookup('UDACITY'))

# Test store
hash_table.store('UDACITY')
# Should be 8568
print(hash_table.lookup('UDACITY'))

# Test store edge case
hash_table.store('UDACIOUS')
# Should be 8568
print(hash_table.lookup('UDACIOUS'))

# print the values in the bucket where UDACIOUS is stored
print(hash_table.table[hash_table.lookup('UDACIOUS')])