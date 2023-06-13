#!/bin/bash

file=clients.txt

while read -r line;
do
knife node run_list add $line 'recipe[agen-auditd]' -y
knife ssh -t5 $line sudo chef-client
#knife ssh -t5 $line "sudo systemctl status glpi-agent" & 
#         knife node run_list remove $line 'recipe[dns_base]','recipe[dns_master]','recipe[dns_slave]','recipe[dhcp_base]','recipe[dhcp_master]','recipe[dhcp_slave]','recipe[zabbix:infra]' -y
#        knife node show $line
#        knife client delete $line -y
sleep 5
done < "$file"
