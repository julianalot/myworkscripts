#!/bin/bash
 
echo "Please give me a folder"
read folder
echo "You typed $folder."

sleep 10

sudo find $folder -empty -exec echo {} is empty. \; 
