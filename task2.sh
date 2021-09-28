#!/bin/bash

#Micheal O' Sullivan
#R00128516
#Systems Scripting - Assignment 1

#The purpose of this task was to implement an interactive menu which had 3 main operations and were to be implemented using functions. The main functions were:
#write to a file (writeToFile()), print out a file (printFile()), rename a file (renameFile()). First a menu option was created to show the available options. 
#Then 3 functions were made: writeToFile, printFile and renameFile. The first being writeToFile was to prompt a user to enter a filename, if it had already existed 
#the file was cleared and if it didn't exist it was created. When the filename was enetered the user could then enter content into the file, but when 
#the string 'end' was entered the script would finish and return the user to the menu again. The second function was printFile. This functions prompted a user 
#to enter a filename, if #the file didn't exist an error message was shown and the menu was prompted again, but if the file did exist it's content was printed 
#to the terminal. The last function #was the renameFunction which was similar to the print function. It prompted the user to enter a filename and checked if 
#it existed, if it did the user was then asked #to enter the name it would like to change the file to and this was implemented using the mv command. To allow 
#the user to choose from different options in the menu a While loop was used to iterate though the menu. As there were three main fucntions, another option 
#available was to exit the menu and terminate the script. Within the #while loop the functions were called using the appropriate numbers relevant to the menu. 
#But while the number: 4 was not enetered the menu would constantly loop until the number 4 was entered terminating the script. 
#A goodybe message was then shown in the terminal when the script was terminated.  


# Menu to show the user for selection
menu="1. Write to a file
2. Print out a file
3. Rename a file
4. Exit"

#Create function for writing to a file
function writeToFile(){
    # Reading filename
    read -p "Enter filename: " fileName

    # Cleaning content of the file if it's already there
    >$fileName

    # Telling user to enter content
    echo -e "Enter content below (write end to exit):"

    # Reading input into the $content variable
    read content

    # Reading until the user input "end"
    while ! [[ "$content" = "end" ]]
    do
        # Appending the content variable at the file
        echo "$content" >> $fileName

        # Reading again
        read content
    done
}


#Create function for printing file
function printFile(){
    # Reading filename
    read -p "Enter filename: " fileName

    # Checking if the file not exist then show error and return the function
    if ! [[ -f $fileName ]]
    then
        echo "ERROR: $fileName does not exist"
        return
    fi

    echo -e "Following are the contents of the file ($fileName): "

    # Priting the contents of the file
    cat "$fileName"
}

#Create function for renaming file
function renameFile(){

    # Reading filename
    read -p "Enter filename: " fileName

    # Checking if the file not exist then show error and return the function
    if ! [[ -f $fileName ]]
    then
        echo "ERROR: $fileName does not exist"
        return
    fi

    # Reading new name of the file
    read -p "Enter new name: " newFileName

    # Renaming file
    mv "$fileName" "$newFileName"

}

# Printing the menu
echo "$menu"

# Reading the selection into selectedOption variable
read -p "Select option: " selectedOption


# Reading until the user entered 4 into the variable
while ! [[ $selectedOption -eq 4 ]]
do
    # If user entered 1
    if [[ $selectedOption -eq 1 ]]
    then
        # call function writeToFile
        writeToFile
    
    # If user entered 2
    elif [[ $selectedOption -eq 2 ]]
    then
        # call function writeToFile
        printFile
    
    # If user entered 3
    elif [[ $selectedOption -eq 3 ]]
    then 
        renameFile
    fi

    # Printing the menu again
    echo "$menu"

    # Reading the selection again
    read -p "Select option: " selectedOption
done

echo "Thank you and goodbye!"
