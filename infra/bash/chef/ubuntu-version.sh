#!/bin/bash

file=clients.txt

while read -r line;
do
knife ssh $line "sudo lsb_release -d"
sleep 5
done < "$file"
