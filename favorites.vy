# pragma version 0.4.1
# @license MIT

# favorite things list:
# favorite numbers
# favorite people with their favorite number

# Stores whether the user has specified a favorite number
has_favorite_number: bool
# Stores a user's favorite (non-negative) number
my_favorite_number: uint256

# Stores a number which could potentially be negative
some_signed_value: int256 #(Example if a signed number were needed)
# The key difference from uint is the abilityto store negative values

#Stores the address of a favorite person or contract
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
my_bytes: bytes32

# Other types not covered here are, flag, String(N), Type[N], DynArray[Type, N]
# Structs and Mappings

# Contract functions to set/get these values would go here