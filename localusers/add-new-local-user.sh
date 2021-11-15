#!/bin/bash

# This script creates a new user on the local system.
# You must supply a username as an argument to the script
# Optionally, you can also provide  comment for the account as an argument.
# A password will be automatically generated for the account.
# The username, password, and host for the account will be displayd.
# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then 
 echo "You must be root to run the script"
 exit 1
 fi

NUMBER_OF_PARAMETERS="${#}" 

# If the user doesn't supply at least one argument, then give them help.
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then 
  echo "Usage: ${0} USER_NAME [COMMENT]... "
  echo 'Create an account on the local system with the name of USER_NAME and a comments field of a COMMENT.'
  exit 1
fi

# The first parameter is the user name.
USER_NAME="${1}"

# The rest of the parameters are for the account comments.
shift # We'll shift everything down
COMMENT="${@}" # Every positional argument To everything else

# Generate a password.
PASSWORD=$(date +%s%N | sha256sum | head -c48)


# Create the user with the password.
useradd -c "${COMMENT}" -m ${USER_NAME} # -c -> comment "${COMMENT}" -> One thing (one argument for -c)


# Check to see if the useradd command succeeded.
# We don't want to tell the user that an account was created when it hasn't been.

if [[ "${?}" -ne 0 ]]
then 
  echo "The account could not be created"
  exit 1
fi

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME} 

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
  echo "The password for the account could not be set"
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo
echo 'username:'
echo ${USER_NAME}
echo 'password:'
echo ${PASSWORD}
echo 'host:'
echo ${HOSTNAME}
exit 0

