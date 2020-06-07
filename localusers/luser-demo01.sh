#!/bin/bash

# This script displays various information to the screen.

# Display 'Hello'
echo 'Hello'

# Assign a value to  a variable
WORD='script'

echo "$WORD"

echo "This is a shell ${WORD}"

echo "${WORD}ing is not fun at all."

# Create a new variable
ENDING='ed'

# Combine two variables.

echo "This is a ${WORD}${ENDING}"

# Change the value in variable

ENDING='ing'

echo "This is a ${WORD}${ENDING}"
