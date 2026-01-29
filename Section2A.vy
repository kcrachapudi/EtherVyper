# pragma version 0.4.1
# @license MIT
    
#Initializing Smart Contracts: Understanding Vyper Constructors (__init__)
#When deploying a Vyper smart contract, you often need to set up its initial state. This could involve defining ownership, setting configuration parameters, or establishing starting values for key variables. This critical initialization step is handled by a special function known as the constructor.
#In Vyper, the constructor follows specific conventions derived from Python. It's a function named __init__ (double underscore init double underscore) that must be decorated with the @deploy decorator. This decorator signals to the Vyper compiler that the __init__ function contains the logic to be executed only once, precisely at the moment the contract is deployed onto the blockchain. After deployment, the constructor cannot be called again.
#Setting Initial State: The Owner Pattern
#One of the most common and crucial uses of a constructor is to establish the owner of the contract. Typically, the owner is the account address that initiates the deployment transaction. Vyper provides a global variable, msg.sender, which holds the address of the transaction originator. During deployment, msg.sender is the deployer's address.
#To implement this pattern, you first declare a state variable (usually public for easy verification) to store the owner's address. Then, within the __init__ function, you assign msg.sender to this state variable using the self keyword, which refers to the contract's storage.

# State variables
owner: public(address)
name: public (String[100])
expiresAt: public(uint256)
fav_number: public(uint256)

# The constructor function 
#Purpose: Constructors (__init__) initialize a contract's state variables when it's deployed.
#Execution: They run automatically and only once during the deployment transaction.
#Syntax: Defined as def __init__(...) and must have the @deploy decorator.
#State Access: Use the self keyword to access and modify state variables within the constructor (e.g., self.owner = msg.sender).
#Parameters: Constructors can accept parameters to allow for customized initialization based on values provided at deployment time.
#Globals: Commonly used global variables inside constructors include msg.sender (deployer address) and block.timestamp (deployment time).
#Default Values: If a state variable isn't explicitly set in the constructor, it retains its default zero value (0, empty string, zero address, etc.).
@deploy
def __init__(name: String[100], duration: uint256, fav_number:uint256):
    # Assign the deployer's address to the owner state variable
    # self refers to the contract's storage space
    # Vyper provides a global variable, msg.sender, which holds the address of the transaction originator. 
    #During deployment, msg.sender is the deployer's address.
    self.owner = msg.sender
    
    # Set the name
    self.name = name

    # Calculate the expiry timestamp
    # block.timestamp is a global variable representing the current block's timestamp
    self.expiresAt = block.timestamp + duration

    #Constructors are useful even for simple initialization tasks.
    self.fav_number = fav_number