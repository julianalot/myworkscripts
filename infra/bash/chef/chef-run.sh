#!/bin/bash

file=clients.txt

while read -r line;
do
#knife bootstrap $line -N $line -U julian.bailey --sudo -y -r 'recipe[agent-velociraptor]'
#knife node run_list add  $line 'role[HQ]'
#knife node run_list add  $line 'role[HQ]'
#knife node run_list remove $line 'recipe[agent-velociraptor]','recipe[agent-wazuh]' -y
#knife node run_list add $line 'recipe[agent-velociraptor]' -y
#ssh $line "ls -l /home"
#knife ssh -t5 $line "sudo chef-client"
#knife ssh -t5 $line "lsb_release -d"
#knife ssh -t5 $line "sudo systemctl status {auditd,glpi-agent,datacollector,suricata,sysmon,velociraptor_client,wazuh-agent}" &
#knife ssh -t5 $line "sudo systemctl status auditd" & 
#knife ssh $line -t5 "systemctl status auditd" &
knife node show $line &
#knife ssh -t5 $line "sudo systemctl status datacollector | grep running" 
#knife ssh -t5 $line "sudo systemctl status velociraptor_client" &
#         knife node run_list remove $line 'recipe[dns_base]','recipe[dns_master]','recipe[dns_slave]','recipe[dhcp_base]','recipe[dhcp_master]','recipe[dhcp_slave]','recipe[zabbix:infra]' -y
#        knife node show $line
#        knife client delete $line -y
sleep 5
done < "$file"
