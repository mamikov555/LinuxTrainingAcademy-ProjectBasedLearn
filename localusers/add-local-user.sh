#!/bin/bash
# This script creates a new user on the local system.

# Make sure you run the script as superuser priviliges
if [[ "${UID}" -ne 0 ]]
then 
 echo "You must be root to run the script"
 exit 1
 fi

#Prompts the person who executed the script to enter the username (login), the name for
# person who will be using the account, and the initial password for the account.
read -p 'Enter the username of the account to be created: ' USER_NAME
read -p 'Enter the name of the user of the account: ' COMMENT
read -p 'Enter the password of the account that is created: ' PASSWORD

# Creates a new user on the local system with the input provided by the user.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
  echo "The command useradd was successful"
  else
  echo "The command useradd was NOT successful"
  exit 1
fi

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded.
if [[ "${?}" -eq 0 ]]
then 
  echo "The command passwd was successful"
  else
  echo "The command passwd was NOT successful"
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}


# Display the username, password, and the host where the user was
#created.
 
 echo "The username is: ${USER_NAME}"
 echo "The password is: ${PASSWORD}"
 echo "The host is: ${HOSTNAME}"
 exit 0
# Informs the user if the account was not able to be created for some reason. If the account is
#not created, the script is to return an exit status of 1.

# Displays the username, password, and host where the account was created. This way the
#help desk staff can copy the output of the script in order to easily deliver the information to
#the new account holder.






