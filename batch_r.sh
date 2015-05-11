#!/bin/bash

#########################################################
# Author: Anny, John
# Project: Assignment 4
# File: batch_r.sh
# Instructor: F.Chen
# Class: cs4103
# LogonID: cs410302
#########################################################

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White
Color_Off='\e[0m'       # Text Reset 

 
# Variables
totalProcessed = 0
totalOriginalSize = 0
totalNewSize = 0

 
 
# This method should provide a help page which should print 
# information that will explain how to use the script - exit
info() {
    echo -e "${Green}Usage: $0 [/path/to/input] [path/to/output] [ratio-or-sequence-of-ratio]${Color_Off}";
    echo -e "${Green}Example: ./batch_resize.sh ./input ./output '20 30 50'${Color_Off}" 1>&2; 
    exit 1
}
 
# This method will keep track of the # of files processed.
processed() {
    totalProcessed = $((totalProcessed++))
    echo $totalProcessed
}
 
 
# Counts total file size before processing. 
trackOriginalSize() {
    totalOriginalSize = $((totalOriginalSize+$1))
    echo $totalOriginalSize
}
 
 
# This method will keep track of the total file size.
countNewSize() {
    totalNewSize = $((totalNewSize+$1))
    echo $totalNewSize
}
 
 
# Check for correct # and type of arguments - without 3 arguments exit script
if [[ $# -ne 3]]; 
    then
    echo -e "\n"
    echo -e "${Red}Invalid instructions.${Color_Off}"
    exit 1
fi
 
 
# If the user requires information about the input commands
if [["$1" == "help"]]; then
    info
fi
 
 
# Check if the input provided is/isn't a directory - if it isn't print the input info
if [[ ! -d "$1" ]]; then
    echo -e "${Red}Input directory is not a valid path${Color_Off}"
    info
else
    input = "$1"
fi
 
 
# Check the output directory:
# -> If it doesn't exist, create a directory
# -> If it does exist, display warning and exit script
if [[ ! -d "$2" ]]; then
    echo -e "${Yellow}Directory doesn't exist. Making one!${Color_Off}"
    mkdir "$2"
    output = "$2"
else
    echo -e "${Red}Directory already exists - exiting shell script${Color_Off}" 1>&2;
    exit 1
fi
 
 
 
# Initialise array of ratios
ratArray = ', ' read -a array <<< "$3"
index = "${#array[@]}"
address = "$3"
 
# File handling
shopt -s null   # Enable (set) each optname
 
while read f; # read file line-by-line
do
    leng = "${#input}" # param
    seg = "${d:leng}" # segment
    newDir = "$output$seg/" # new Directory
    dir = $(dirname "${f}") # original directory
    mkdir -p "${newDir}${dir#$1/}" # make new directory
    for ((i = 0; i < $index; i++)) # for everything in drectory (array)
    do
        # Handle ratio 
        sourceName = $f 
        base = $(baseName "${f}")
        filename = "${base%.*}"
        extension = "${base##*.}"
 
        tag = ${dir#$1/}
        r = "-r"
 
        # Sequence formatting within array and files
        appendResize = "${array[i]}"
        endFilename = $r$appendResize # file tail
        startFilename = $filename$endFilename # file header
        dot = '.' # dot
        slash = '/' # slash
        newFilename = $slash$startFilename$dot$extension # new file
        target = $newDir$newFilename # target
        convertedFile = $startFilename$dot$extension # file post-conversion
 
        # Resize an image
        convert -resize ${array[i]}% $f $target
 
        # From project specification - Use the following command to get file size in bytes
        baseSize =`wc -c $sourceName | awk '{print $1;}'`
        newSize =`wc -c $target | awk '{print $1;}'`
        echo -e "Complete" 
        processed # track the # of processed files
        trackOriginalSize baseSize # track pre-processed #
        countNewSize newSize # track post-resized #
 
        echo -e "${Cyan}Original Image:   ${base}.${Color_Off}" # print original image
        echo -e "${Cyan}Original Image Size:   ${basesize}.${Color_Off}" # print original image size
        echo -e "${Purple}New image:   ${printedFilename}.${Color_Off}" # print new image
        echo -e "${Purple}New Image Size:   ${newsize}.${Color_Off}" # print new image size

        totalProcessed = $((totalProcessed+1)) # increment the # of processed files
        totalOriginalSize = $((totalOriginalSize + $baseSize)) # update original file #
        totalNewSize = $((totalNewSize + $newSize)) # update processed file #
    done
done < <(find $input -type f)

echo -e "${Green}Total Files Processed:     ${totalProcessed}${Color_Off}" # print the # of processed files
echo -e "${Green}Original File Size (bytes):     ${totalOriginalSize} bytes${Color_Off}" # print the orginal # of processed files
echo -e "${Green}New File Size (bytes):     ${totalNewSize} bytes${Color_Off}" # print the updated # of processed files
