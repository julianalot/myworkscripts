#!/bin/bash

file=clients.txt

while read -r line;
do
        knife client delete $line -y
done < "$file"
