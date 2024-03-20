#!/bin/bash

file=clients-2204.txt

while read -r line;
do
#knife bootstrap $line -N $line -U julian.bailey --sudo -y -r 'role[HQ],recipe[agent-cinc]'
#knife node $line delete -y && knife client $line delete -y
#knife node run_list add  $line 'role[HQ]'
#knife node run_list add  $line 'recipe[agent-cinc]'
#knife node run_list remove $line 'recipe[agent-wazuh]'
#knife node run_list remove  $line 'recipe[agent-suricata-logrotate]'
#knife node run_list add $line 'recipe[agent-cinc]' -y
#knife node show $line -r 
#knife ssh $line "hostname || ls -l /home/finlay.tachiona"
knife ssh -t5 $line "sudo systemctl stop chef-client && sudo systemctl disable chef-client"
#knife ssh -t5 $line "sudo cinc-client"
#knife ssh -t5 $line 'sudo ls -l /etc/sudoers.d/ | grep svc_linux*' 
#knife ssh -t5 $line "lsb_release -d"
#knife ssh -t5 $line "sudo systemctl status {auditd,glpi-agent,datacollector,suricata,sysmon,velociraptor_client,wazuh-agent}" &
#knife ssh -t5 $line "dpkg -l restic" & 
#knife ssh $line -t5 "systemctl status auditd" &
#knife node show $line &
#ping -c 1 $line 
#knife ssh -t5 $line "which java; java -version"
#knife ssh -t5 $line 'ls /opt/'
#ssh -t5 $line 'ls /opt/'
#knife ssh -t5 $line "sudo systemctl status velociraptor_client" &
#         knife node run_list remove $line 'recipe[dns_base]','recipe[dns_master]','recipe[dns_slave]','recipe[dhcp_base]','recipe[dhcp_master]','recipe[dhcp_slave]','recipe[zabbix:infra]' -y
#        knife node show $line
#        knife client delete $line -y
#knife node show $line 
#knife bootstrap $line -N $line -U julian.bailey  --sudo -r 'role[HQ]','recipe[agent-cinc]' -y
sleep 5
done < "$file"
