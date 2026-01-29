# pragma version 0.4.1
# @license MIT

#State Variables or Storage Variables
#Variables declared at the contract level (outside any function) are called state variables 
#or storage variables. They store data persistently on the blockchain.

#Below variables is State Variable
# Stores whether the user has specified a favorite number
#Below variables is State Variable
has_favorite_number: bool
# Stores a user's favorite (non-negative) number
#Below variables is State Variable
my_favorite_number: uint256

# Stores a number which could potentially be negative
#Below variables is State Variable
some_signed_value: int256 #(Example if a signed number were needed)
# The key difference from uint is the abilityto store negative values

#Stores the address of a favorite person or contract
#Below variables is State Variable
my_address: address
# These are 20 byte (160 bit) values typically seen in hexadecimal format starting with 0x.
# Used to store addresses of user accounts (Externally Owned Accounts) or other smart contracts

# Stores a decimal value 
# my_decimal: decimal
# You need to pass the --enable-decimals flag to Vyper compiler 

# bytesN Fixed size byte array. N is the number of bytes
# Ex: bytes2, bytes8, bytes32. Useful for handling
# raw byte data, hashes, binary data.
# Stores a fixed size 32 byte value like a hash
#Below variables is State Variable
my_bytes: bytes32

# Other types not covered here are, flag, String(N), Type[N], DynArray[Type, N]
# Structs and Mappings

# Contract functions to set/get these values would go here

# Basic function definition structure
#def function_name(parameter1_name:type1, parameter2_name: type2):
    # Indented code forming the function body goes here
    # This code executes when the function is called
#    pass # Placeholder for logic

#self.my_favorite_number = new_number

# Function to modify the state variable
@external
def store(new_number: uint256): # Defines function 'store' taking a uint256 input
    # Assigns the input 'new_number' to the contracts's state variable 'my_favorite_number'
    # using 'self' to reference the contract's storage
    self.my_favorite_number = new_number

# Below variable is by default internal to the Contract
my_internal_number:uint256

# Below function is by default internal to the Contract
def store2(new_number:uint256):
    self.my_internal_number = new_number

@internal
def _update_number(new_number: uint256): #Often prefixed with _
    self.my_favorite_number = new_number

# external can call internal but not otherwise
@external
def set_favorite_to_seven():
    #Valid:External function calling an internal one
    self._update_number(7)

# internal cannot call external
@internal
def try_invalid_call():
    #Invalid call
    ##self.set_favorite_to_seven()
    pass

# external cannot call external
@external
def ex_set_favorite_to_seven():
    #Invalid call
    #self.set_favorite_to_seven()
    pass

# Return Values
@external 
def get_number() -> uint256:
    my_number: uint256 = 42
    return my_number

#Transactions vs. Calls: A Summary
#Transactions:
#Modify blockchain state e.g., writing to storage variables.
#Require gas.
#Must be mined and included in a block.
#Have a transaction hash.
#Often represented by orange buttons in tools like Remix for functions assumed to be transactions, like non-@view @external functions.

# This is a transaction 
@external
def change_number(new_number:uint256)->uint256:
    self.my_favorite_number = new_number
    return self.my_favorite_number

# This is a transaction even though it does not modify State
@external
def change_number_2(updated_number:uint256) -> uint256:
    return self.my_favorite_number

#Calls:
#Read blockchain state without modifying it.
#When initiated off-chain (e.g., by a user interface):
#Do not cost the caller gas.
#Do not need to be mined.
#Do not have a transaction hash associated with the read itself.
#Often represented by blue buttons in tools like Remix (for public getters and @view functions).
# This is NOT a transaction 
# This can call other @view or @pure functions
# It cannot write to State
@external 
@view
def change_number_3(updated_number:uint256) -> uint256:
    return self.my_favorite_number
