#!/bin/bash

# -----------------------------------------------------------
# This script performs the following for a production node:
# - Network configuration
# - Hostname confguration
# - Restart networking
# - Regenerate host keys and reconfigure the ssh server
# -----------------------------------------------------------

function configure_interfaces {
    echo    "Please enter the IP address for the host:"
    echo -n "IPADDRESS1=10.0.1."; read IPADDRESS1;
    cat <<EOF >/etc/network/interfaces
iface lo inet loopback
auto lo

auto eth0
iface eth0 inet static
address 10.0.1.$IPADDRESS1
netmask 255.255.255.0
up route add default gw 10.0.1.254 metric 10
dns-search hq.takealot.com
dns-nameservers 10.0.1.70 10.0.1.71

EOF
}

function update_hostname {
    echo    "Please enter the hostname:"
    echo -n "HOSTNAME="; read HOSTNAME

    echo $HOSTNAME > /etc/hostname
    hostname $HOSTNAME

    sed -i "s/^10.0.1.200.*/10.0.1.$IPADDRESS1        $HOSTNAME.hq.takealot.com $HOSTNAME localhost/g" /etc/hosts
    sed -i "s/Hostname=1604template/Hostname=$HOSTNAME.hq/g" /etc/zabbix/zabbix_agentd.conf

}

function regenerate_host_keys {
    rm -rf /etc/ssh/ssh_host_*
    dpkg-reconfigure openssh-server
}

function main {

    configure_interfaces

    update_hostname

    ip addr flush eth0
    service networking restart
    service zabbix-agent restart

    regenerate_host_keys

}

main
