#!/bin/bash


#This script displays various information to the screen
# Display the text 'Hello'

echo "Hello"

echo "Hello madafaka"

# Assign a value to a variable

WORD='script'
WORD1='script1'
_WORD1='script1'

# Display that value using the variable.

echo "$WORD"
 
# Demonstrate that single quotes cause varaibles to NOT get expected
echo '$WORD'

# combine the variable with hard-coded text.
echo "This is a shell $WORD"

# Display the contets of the variable using an alternative syntax
echo "this is a shell ${WORD}"

#Append text to the variable.

echo "${WORD}ing is fun!"

# Show how NOT to append text to a variable
echo "$WORDing is fun!"

# Create a new variable
ENDING='ed'

#Combine the two variables

echo "This is ${WORD}${ENDING}."

#Change the value stored in the Ending variable (Reassignment)
ENDING='ing'

echo "${WORD}${ENDING} is fun!"

# Reassing value to ENDING
ENDING='s'
echo "You are going to write many ${WORD}${ENDING} in this class!"

