#!/bin/bash

for x in  (0,10001)
do
    echo $(cat /etc/bandit_pass/bandit24 )$x >> test.txt
done
