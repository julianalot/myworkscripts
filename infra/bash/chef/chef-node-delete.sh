#!/bin/bash

file=clients.txt

while read -r line;
do
    knife node delete $line -y && knife client delete $line -y 
done < "$file"
