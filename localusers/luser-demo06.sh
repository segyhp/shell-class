#!/bin/bash

# This script generates a random passowrd for each user specified on the command line.

# Display what user typed on the command line.
echo "You executed this command: ${0}"

# Display the path and filename of the script.
echo "You used $(dirname ${0}) as path to the $(basename ${0}) script." 

# Tell them how many argument they passed in.
# (Inside the script the are paramaters, outside they are arguments)
NUMBER_OF_PARAMETERS=${#}
echo "You supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line."

# Make sure they at least supply one argument.
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1  ]]
then
    echo "Usage ${0} USER_NAME [USER_NAME]..."
    exit 1
fi

# Generate and display a password for each parameter.

for USER_NAME in "${@}"
do
    PASSWORD=$(date +%s%N | sha256sum | head -c48)
    echo "${USER_NAME}: ${PASSWORD}"
done
