#!/bin/bash

file=2004-nodes

while read -r line;
do
         knife node run_list remove $line 'recipe[dns_slave]','recipe[dhcp_master]''recipe[dhcp_slave]' -y
#        knife node run_list add $line 'recipe[agent-lacework]' -y
#        knife node show $line
#        knife client delete $line -y
done < "$file"
