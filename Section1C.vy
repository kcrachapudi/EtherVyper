# pragma version 0.4.1
# @license MIT
    

# State variables
owner: public(address)
name: public (String[100])
expiresAt: public(uint256)
fav_number: public(uint256)

@deploy
def __init__(name: String[100], duration: uint256, fav_number:uint256):
    self.owner = msg.sender
    self.name = name
    self.expiresAt = block.timestamp + duration
    self.fav_number = fav_number

#Handling Integer Division
#A crucial point in Vyper involves integer division. When dividing two integers where the result might not be a whole number, Vyper requires a specific operator:
# // This is the floor division operator. It performs the division and rounds the result down to the nearest whole number.
# Using a single slash / is not the standard way to perform integer division in Vyper as demonstrated here. Always use // when dividing integers to ensure predictable, floored results.

#Returning Multiple Values
#Vyper functions are not limited to returning just a single value. You can return multiple values, potentially of different types.
#Declaring Multiple Return Types: In the function signature, enclose the multiple return types within parentheses: -> (type1, type2, ...).
#Returning Multiple Values: In the return statement, provide the values as a tuple, enclosed in parentheses: return (value1, value2, ...).

#Example: Basic Multiplication
@external
@pure
def multiply(x:uint256, y:uint256) -> uint256:
    """
    @notice Multiiplies two unsigned integers
    @param x The first number
    @param y The second number
    @return The product of x and y
    """
    return x*y

#Example 2: Integer Division
@external
@pure
def divide(x:uint256, y:uint256)->uint256:
    """
    @notice Divides two unsigned integers using floor division
    @param x The dividend
    @param y The divisor
    @return The result of x//y (rounded down)
    """
    # Note the use of // for Integer division
    return x//y

#Example3: Placeholder function using 'pass'
@external
def todo():
    """
    @notice A placeholder function that does nothing yet
    """
    #'pass' allows an empty function body
    pass

#Example4: Returning multiple values
@external
@pure
def return_many()->(uint256, bool):
    """
    @notice Demonstaates returning multile values of different types
    """
    #Return types are (uint256, bool)
    #Return values as a tuple
    return (123, True)

#Key Takeaways
#Functions intended to be called from outside the contract must be marked @external.
#@pure functions promise not to read or write contract storage.
#Use the floor division operator // for integer division in Vyper.
#The pass keyword serves as a placeholder for an empty function body.
#Specify multiple return types using parentheses in the signature: -> (type1, type2).
#Return multiple values as a tuple: return (value1, value2).

