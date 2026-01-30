# pragma version 0.4.1
# @license MIT

#Introducing Vyper HashMaps (Mappings)
#Vyper offers a powerful data structure called HashMap, often referred to as a mapping in other smart contract languages like Solidity, or dictionaries/hash tables in traditional programming. A HashMap stores data as key-value pairs, allowing you to associate one piece of data (the key) directly with another (the value).
#Core Concept:
#A HashMap maps keys of a specific type to values of another specific type.
#The syntax for declaring a HashMap is: HashMap[KeyType, ValueType].
#This structure enables direct lookups using the key, bypassing the need for numerical indices.
#A key characteristic of HashMaps in Vyper (and mappings in Solidity) is how they handle lookups for keys that haven't been explicitly assigned a value. Instead of causing an error, they return the default value for the specified ValueType. Common default values include:
#0 for numerical types (uint256, int128, etc.)
#False for bool
#The zero address (0x00...00) for address
#An empty string or empty bytes for String or Bytes.

people_favnums: public(HashMap[String[100], uint256])
    
@external 
def add_person(name: String[100], fav_num: uint256):
    self.people_favnums[name] = fav_num