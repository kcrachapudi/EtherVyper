# pragma version 0.4.1
# @license MIT

#Working with Fixed-Size Lists in Vyper
#This lesson explores how to use fixed-size arrays, which Vyper refers to as lists, within your smart contracts. We'll cover declaring, initializing, reading from, and writing to these lists, highlighting important considerations like indexing and boundary checks. 

my_fav_number: public(uint256)

@external
def store(new_fav_number:uint256):
    self.my_fav_number = new_fav_number

@view
@external
def retrieve()->uint256:
    return self.my_fav_number

list_of_numbers: public(uint256[5])
num_index: public(uint256)
pindex: public(uint256)

@deploy
def __init__():
    self.my_fav_number = 7
    self.num_index = 0
    self.pindex = 0

@external
def add_number(fav_number:uint256):
    #Use the current value of self.num_index to access the list
    self.list_of_numbers[self.num_index] = fav_number
    #increment the index for the next addition
    self.num_index = self.num_index + 1

# Define a new type called 'Person'
struct Person: 
    fav_number: uint256 #Member 1: the person's fav num
    name: String[100]   # Member2: the person's name

#State variable to hold an array of Persons
people: public(Person[5])

@external 
def add_person(name: String[100], fav_num: uint256):
    #Core Logic for adding a person
    #1.Create a new Person struct instance in memory
    new_person:Person = Person(fav_number=fav_num, name=name)

    #2.Assign the newly created person to the array
    self.people[self.pindex] = new_person

    #3. Increment the index for the next person
    self.pindex = self.pindex + 1

#WORKSHOP Testing on Metamask and Remix
#This exercise demonstrates several fundamental concepts in smart contract development and interaction:
#State Modification: Changing the data stored on the blockchain requires sending transactions that execute state-changing functions (like add_person).
#Mappings: Vyper mappings provide a flexible way to store key-value data. They don't have a fixed size but allow accessing values via their keys (indices in this case).
#Structs: Custom data types (Person) allow grouping related information, making the contract code more organized and readable.
#Function Interaction: Using a development environment or library to call functions (add_person) on a deployed contract.
#Index Management: Using a dedicated state variable (index) to control the insertion position within mappings, simulating array-like sequential addition.
#Gas Costs: Remember that every state-changing transaction (like each call to add_person) consumes gas on a live blockchain network.