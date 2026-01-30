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

# Defining the interface directly in the contract file
interface AggregatorV3Interface:
    def decimals() -> uint8: view
    def description() -> String[1000]: view
    def version() -> uint256: view
    # This is the function we need to call:
    def latestAnswer() -> int256: view

minimum_usd: public(uint256)
price_feed_address: public(address) # Store the feed address
ETH_USD_FEED_SEPOLIA: constant(address) = 0x694AA1769357215DE4FAC081bf1f309aDC325306

@external
@view
def get_price()->int256:
    #Instantiate the external contract
    # Pass the known Address as ana argument 
    price_feed:AggregatorV3Interface = AggregatorV3Interface(ETH_USD_FEED_SEPOLIA)

    # Call the External function using staticcall
    # staticcall is used because latestAnswer() ia a view function 
    return staticcall price_feed.latestAnswer()

