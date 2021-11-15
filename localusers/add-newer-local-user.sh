#!/bin/bash

# The goal of this exercise is to create a shell script that adds users to the same Linux system as the
# script is executed on.

#The script:
#● Is named "add-new-local-user.sh ". (You add the word new to distinguish it from the
#original script.)
#● Enforces that it be executed with superuser (root) privileges. If the script is not executed with
#superuser privileges it will not attempt to create a user and returns an exit status of 1.
#● Provides a usage statement much like you would find in a man page if the user does not
#supply an account name on the command line and returns an exit status of 1.
#● Uses the first argument provided on the command line as the username for the account. Any
#remaining arguments on the command line will be treated as the comment for the account.
#● Automatically generates a password for the new account.
#● Informs the user if the account was not able to be created for some reason. If the account is
#ot created, the script is to return an exit status of 1.
#● Displays the username, password, and host where the account was created. This way the
#help desk staff can copy the output of the script in order to easily deliver the information to
#the new account holder.


# Make sure the script is being executed with superuser privileges.

if [[ "${UID}" -ne 0 ]]
then 
 echo "You must be root to run the script" >&2
 exit 1
 fi

NUMBER_OF_PARAMETERS="${#}" 

# If the user doesn't supply at least one argument, then give them help.
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then 
  echo "Usage: ${0} USER_NAME [COMMENT]... " >&2
  echo 'Create an account on the local system with the name of USER_NAME and a comments field of a COMMENT.' >&2
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
useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null # -c -> comment "${COMMENT}" -> One thing (one argument for -c)


# Check to see if the useradd command succeeded.
# We don't want to tell the user that an account was created when it hasn't been.

if [[ "${?}" -ne 0 ]]
then 
  echo "The account could not be created" >&2
  exit 1
fi

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
  echo "The password for the account could not be set" >&2
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME} &> /dev/null

# Display the username, password, and the host where the user was created.

echo 'username:'
echo ${USER_NAME}
echo 
echo 'password:'
echo ${PASSWORD}
echo
echo 'host:'
echo ${HOSTNAME}
exit 0
