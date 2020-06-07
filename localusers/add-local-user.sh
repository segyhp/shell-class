#!/bin/bash

# Create script that will create new user accounts.


# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
    echo 'Please run with sudo or as root.'
    exit 1
fi

# Get the username (login).
read -p  'Enter the username to create: ' USER_NAME

# Get the real name (contents for the description field).
read -p 'Enter the name of user to create: ' COMMENT

# Get the password.
read -p 'Enter the password of user to create: ' PASSWORD

# Create the user with the password.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
    echo 'Failed to create account, please try again.'
    exit 1
fi
  
# Set the password.
echo PASSWORD | passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
    echo 'Password for the account could not be set'
    exit 1
fi
# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo
echo 'username: '
echo ${USER_NAME}
echo
echo 'password: '
echo "${PASSWORD}"
echo
echo 'host: '
echo "${HOSTNAME}"
exit
