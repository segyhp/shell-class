#!/bin/bash

# Make sure the script is running with root privilege

if [[ "${UID}" -ne 0 ]]
then
    echo "Please run with sudo or as root."
    exit 1
fi

NUMBER_OF_PARAMETERS="${#}"

if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
    echo "Usage ${0} USER_NAME [USER_NAME]..."
    echo 'Create an account on local system with name of USER_NAME and a commend field of COMMENT'
    exit 1
fi 

# The first parameter is the user name
USER_NAME="${1}"

# The rest of the parameters are for the account comments.
shift
COMMENT="${@}"

# Generate Passoword
PASSWORD=$(date +%s%N | sha256sum | head -c48)

# Create the user with password.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succedded.
if [[ "${?}" -ne 0 ]]
then
     echo 'The account could not be created.'
     exit 1
fi

# Set the password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# check if the passwd command succeeded
if [[ "${?}" -ne 0 ]]
then
    echo 'The passoword for the account could not be set.'
    exit 1
fi

# Force password change
passwd -e ${USER_NAME}

echo 'username:'
echo "${USER_NAME}"
echo
echo 'passoword:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0
