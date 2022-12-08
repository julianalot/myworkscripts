#!/bin/bash

file=clients.txt

while read -r line;
do
        knife node show $line
#        knife client delete $line -y
done < "$file"
