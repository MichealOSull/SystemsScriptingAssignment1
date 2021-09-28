#!/bin/bash

#Micheal O' Sullivan
#R00128516
#Systems Scripting - Assignment 1

#The purpose of this task was to create a script which automated the creation and deletion os user accounts. The first step was to implement an argument 
#parameter which would be used for the file containing the list of names to be created as users. Like in the previous task I then created two functions. 
#One being for the purpose of creating users and the second function for deleting users. In the createUser function we first checked if a input paramater is set, 
#if not an error message is shown. If it does exist it checks if the file entered exists and if not a message error is shown. If no error has been shown
#we then read the content of the file line by line. If the file exists a message showing this is shown and it is skipped. The user account is created with home
#directory using the sudo useradd command. The content of the etc/passwd which contains the username, real name and ID information is printed followed by 
#printing the folders in the home directory. Next the delete user function is created. We again use the sudo command along with userdel to delete the userNames
#which have been provided in the file along with printing the etc/passwd and home/directory. To call these functions within the terminal, like the menu 
#in task 2 the user is prompted with two options to create or delete users. When create is entered we call the createUser function and when delete is enetered 
#the deleteUser function is called. We can then loop through these options until end is entered to terminate the script.

# Getting input argument containing list of names
userNameFile="$1"

#Create a function for creating a user
function createUser {

# Checking if the user gives argument less than 0
if [[ $# -lt 0 ]]
then
    echo -e "ERROR: No Input Parameter."
    exit 2
fi

# Checking if the file exists
if ! [[ -f "$userNameFile" ]]
then
    echo "ERROR: The file $userNameFile does not exist"
    exit 2
fi

# Reading the file line by line and 
# getting content into the userName variable
while read -r userName
do

    # Checking if the username already exist in the /etc/passwd, 
    # if it exists, show warning and skip
    if ! [[ -z $(grep "$userName" /etc/passwd) ]]
    then
        echo "WARNING: $userName already exist. Skipping $userName"
        continue
    fi

    # Create the user account with home directory 
    echo "Creating account for $userName"
    sudo useradd -m $userName
    
done < $userNameFile

# Printing the content of the /etc/passwd
echo -e "Content of /etc/passwd: \n"
cat /etc/passwd


# Printing the folders in the home directory
echo -e "Home folders at home directory"
ls /home
echo ""

}




#Create function for deleting a user
function deleteUser {
    while read -r userName
    do
        echo -e "Deleting account for $userName"
        sudo userdel -r $userName

    done < $userNameFile

    # Printing the content of the /etc/passwd
    echo -e "Content of /etc/passwd: "
    cat /etc/passwd

    # Printing the folders in the /home directory
    echo -e "Home folders at /home:"
    ls /home


}




#Prompt user would they like to create or delete user accounts
echo "Would you like to create or delete user accounts? (create/delete):"

# Reading the selection into choice variable
read -p "Select option: " choice

#End will terminate script
while [[ $choice != "end" ]]
do
    # If user entered choice = create call function createUser
    if [[ $choice = "create" ]]
    then
    
        # call function createUser
        createUser



    # If user entered choice = deleteUser call function createUser
    elif [[ $choice = "delete" ]]
    then
        # call function deleteUser
        deleteUser
fi


#Call option and choice again
echo "Would you like to create or delete user accounts? (create/delete):"

# Reading the selection into choice variable
read -p "Select option: " choice

done




