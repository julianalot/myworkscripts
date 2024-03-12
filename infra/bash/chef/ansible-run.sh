#!/bin/bash

file=inventory

while read -r line;
do
ssh $line 'sudo /sbin/shutdown -h now'  
done < "$file"
