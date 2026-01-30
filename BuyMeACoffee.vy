#REQUIREMENTS
#1 Get funds for users
#2 Withdraw funds 
#3 Set a minimum funding value in USD

# pragma version 0.4.1  
#Specifies Vyper compiler version
# @license:MIT          
#Declares the software license
# @author:kcrachapudi   
#Declares the author

#Both our fund function (so users can send funds) and our 
#withdraw function (so the owner can withdraw) need to be externally callable.

#Vyper's Global Variables
#msg.value is one of several helpful global variables Vyper provides, 
#offering context about the current transaction or blockchain state. 
#Another essential one frequently used alongside msg.value is msg.sender, 
#which provides the address (address type) that initiated the current specific call 
#to the contract function.
#Vyper Docs - Environment Variables: https://docs.vyperlang.org/en/stable/constants-and-vars.html

"""
 sending ETH with function calls is enabled by the transaction value field. 
 Receiving and accessing this ETH within a Vyper contract requires marking 
 the function @payable and using the msg.value global variable (always in Wei)
  to read the amount sent in the current call. Use assert to enforce funding requirements 
  and remember that contracts themselves maintain an ETH balance.
"""

# Define the required amount in Wei
# 1 followed by 15 zeros, 0.001 ETH
REQUIRED_AMOUNT: constant(uint256) = 1_000_000_000_000_000

#If a function lacks @payable, any attempt to send ETH to it results in transaction reversion.
@payable
@external
def fund():
    """
    Allow users to send $ to this contract.
    Accepts funds but requires 'REQUIRED_AMOUNT' to be sent.
    """
    # Check if the received value matches the required amount
    assert msg.value >= REQUIRED_AMOUNT, "Incorrect ETH amount sent"
    #If the condition is false (the wrong amount was sent), the transaction reverts with the optional error message provided. The sent ETH (minus gas fees) is returned to the sender.
    
    #If assert passes, proceed with function logic...
    #For example, log the funding event or update
    pass 

@external
def withdraw():
    pass # Placeholder for withdrawal logic
