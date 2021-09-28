#!/bin/bash

#Micheal O' SUllivan
#R00128516
#Systems Scripting - Assignment 1

#The purpose of this task was to search for patters within files located in a folder. The first step was to implement parameter arguments:
#folderPath being the folder path parameter and the stringPattern being the string to search for if it exists. To make sure that the folderPath
#and string existed I used If statements to display an error message if either or both arguments were incorrect/didn't exist. An array was then
#created to store files which had a string occurence more than 1. For the purpose of this task we were to iterate through the the array using and until loop
#but I was running into errors using this as I kept running into a continous loop, so instead I used a for loop. 
#Within the loop we first checked the #occurences of the pattern in the file once the file exists by using the grep command to match it to the parameter given. 
#Then an occurence of 1 was checked #and if 1 occurence exists in a file it was printed followed by its size in bytes and also the number of occurences. 
#If a string parameter existed more than #once in a file, the path of #the file was added to an array. 
#This array was then writen into a txt file named report and also the the array was printed to #terminal.


# Getting 1st and 2nd parameter arguments
folderPath="$1"
stringPattern="$2"

# Check if the user gives argument is less than two, otherwise show error
if [[ $# -lt 2 ]]
then
    echo "Error: Invalid number of arguments"
    exit 2
fi

# Check if the folderPath exists, otherwise show error
if ! [[ -d "$folderPath" ]]
then
    echo "Error: The folder $folderPath does not exist"
    exit 2
fi

# Check if the user provided a string pattern, otherwise show error
if [[ -z "$stringPattern" ]]
then
    echo "Error: Please provide a string pattern"
    exit 2
fi

# Array to store files which has the string pattern at least twice
filesArray=()

# Looping through each file in the folderPath
for file in "$folderPath"/*
do
    echo "Checking $file"
    if [[ -f "$file" ]]
    then
        # Finding the occourences of the pattern in the file
        occurences=$(grep -o $stringPattern $file | wc -l)
    fi

        # If occureneces are greater than zero
        if [[ $occurences -gt 0 ]]
        then
            # Print the filename - size - occurences
            fileSize=$(stat -c%s $file)
            echo "$file - $fileSize bytes - $occurences times"
        fi

        # If the occurences are greater than one 
        if [[ $occurences -gt 1 ]]
        then
            # Append the filename to the array
            filesArray+=( "$file" )
        fi
done

# Adding those files in the report.txt file
echo "Files which have string pattern at least twice: ${filesArray[@]}" > report.txt

# Printing those file onto the screen one by one
echo -e "Files in which the string pattern occured at least twice:\n"

for file in "${filesArray[@]}"

do
	echo "$file"
done
