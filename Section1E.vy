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