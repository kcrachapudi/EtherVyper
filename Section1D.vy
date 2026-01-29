# pragma version 0.4.1
# @license MIT
    
#Beyond Single Variables: Introducing Vyper Reference Types
#In our previous explorations of Vyper, we've often dealt with simple state variables, like storing a single favorite number using uint256. While useful, this approach quickly becomes limited when we need to manage more complex data or collections of data associated with multiple users or entities.
#Imagine trying to store a favorite number for every user interacting with your contract. You could try adding individual state variables like alice_favorite_number, bob_favorite_number, etc. However, this is highly inefficient and static. What happens when a new user arrives? You'd need to modify the contract code, recompile, and redeploy – a completely impractical solution for dynamic applications.
#To build smarter, more flexible contracts, Vyper provides powerful Reference Types. These are data structures designed to handle collections and complex data groupings efficiently. Unlike simple Value Types (uint256, bool, address, etc.), where assignments or function passes typically create copies of the data, Reference Types often work with pointers or references to the data's location in memory or storage.
#This lesson focuses on three fundamental Vyper reference types: Fixed-Sized Lists, Mappings, and Structs. We'll explore how to declare them, initialize them, and interact with them, paving the way for more sophisticated contract logic.

#Example: A public list holding 10 uInts
nums: public(uint256[10])
    
#Key-Value Storage: Mappings (HashMaps)
#Mappings, declared using the HashMap keyword, provide a powerful way to store key-value pairs. Think of them like dictionaries or hash maps in other languages. You associate a unique key of one data type with a value of another data type.
#Unlike lists, mappings do not have a concept of length or order, and you cannot iterate directly over their keys or values within Vyper. They are highly optimized for retrieving a value when you know its corresponding key.
#Declaration:
#Declaring a mapping involves specifying the key type and the value type within the HashMap structure.

#Example: Mapping addresses to uints
#Stores a uint245 for each unique address key
myMap: public(HashMap[address, uint256])
#This declares a public state variable myMap. It maps keys of type address to values of type uint256. This is ideal for scenarios like tracking balances, roles, or preferences associated with specific user addresses.
#Initialization and Access:
#You access and modify values in a mapping using the key within square brackets [].

#Defining Custom Data Structures: Structs
#Structs allow you to create your own custom, complex data types by grouping several variables (called fields or members) together under a single name. These fields can be of different data types, including value types, other structs, or even fixed-sized lists and mappings (though usage within structs has specific considerations).
#Definition:
#First, you define the structure of your custom type using the struct keyword.

#Define a new datatype called 'Person
struct Person:
    name:String[10] # Field for name, max 10 chars
    age:uint256     # Field for age
#Once defined, you can declare state variables using your custom struct type.
# Declare a public state variable of type Person
person: public(Person)
#This creates a state variable person of Type Person

@deploy
def __init__():
    #Set the value of the first element of nums
    self.nums[0] = 123
    #Set the value of the second element of nums
    self.nums[1] = 456
    # nums Elements from 2 to 9 remain uninitialized
    #Any elements in a fixed-sized list that you don't explicitly assign a value to will automatically receive the default value for their data type. For uint256, the default value is 0. So, in the example above, accessing self.nums[2] (or any index from 2 to 9) would return 0.

    #msg.sender is the address deploying the contract
    #Assign the value 1 to the key with the deployer's address
    self.myMap[msg.sender] = 1
    #Update the value for the same key
    self.myMap[msg.sender]=11
    #Accessing a key that is not assigned will return the default value for that value type

    #Accessing and modiying Structs
    #Modify the name field of the person state 
    self.person.name = "Vyper"
    self.person.age = 33
    #These assignments directly modify the data stored on the blockchain within the person state variable.

#Understanding Storage vs. Memory with Structs
#A crucial concept when working with reference types, especially structs, is the difference between storage and memory.
#Storage: This is the persistent state of the contract, stored permanently on the blockchain. State variables (self.nums, self.myMap, self.person) reside in storage. Modifying storage is relatively expensive in terms of gas cost.
#Memory: This is temporary, volatile data space used during function execution. It's cheaper to use than storage but is cleared after the function call finishes. Local variables within functions typically reside in memory.

# --- Storage vs. Memory Demonstration ---
#    # 1. Load the struct from storage (self.person) into a memory variable 'p'
#    #    This operation CREATES A COPY of the struct data in memory.
#    #p: Person = self.person
#    # 2. Modify the fields of the memory variable 'p'
#    #p.name = "solidity"
#    #p.age = 22
#    # At this point:
#    # - The memory variable 'p' holds {name: "solidity", age: 22}
#    # - The storage variable 'self.person' STILL holds {name: "vyper", age: 33}
#
#    # The changes made to 'p' (the memory copy) DO NOT automatically update
#    # the original 'self.person' struct in storage.
#    # The memory variable 'p' and its modified values will be discarded
#    # when the __init__ function execution completes.