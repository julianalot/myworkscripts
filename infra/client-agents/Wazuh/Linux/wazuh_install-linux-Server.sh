#!/bin/bash
curl -so wazuh-agent-4.3.10.deb https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.3.10-1_amd64.deb
sudo WAZUH_MANAGER='cpt-hq-wazser.hq.takealot.com' WAZUH_REGISTRATION_PASSWORD='234155*(sadf2FH*89)' WAZUH_AGENT_GROUP='Linux' dpkg -i ./wazuh-agent-4.3.10.deb

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PACKETBEAT_YAML="https://raw.githubusercontent.com/socfortress/Wazuh-Rules/main/Packetbeat/packetbeat.yml"

logger() {

    now=$(date +'%m/%d/%Y %H:%M:%S')
    case $1 in 
        "-e")
            mtype="ERROR:"
            message="$2"
            ;;
        "-w")
            mtype="WARNING:"
            message="$2"
            ;;
        *)
            mtype="INFO:"
            message="$1"
            ;;
    esac
    echo $now $mtype $message
}

if [ -n "$(command -v yum)" ]; then
    sys_type="yum"
    sep="-"
elif [ -n "$(command -v zypper)" ]; then
    sys_type="zypper"   
    sep="-"  
elif [ -n "$(command -v apt-get)" ]; then
    sys_type="apt-get"   
    sep="="
fi

DIR="/etc/packetbeat"
if [ -d "$DIR" ]; then
        logger "Packetbeat found. Not Installing"
        exit 0
else
logger "Installing Packetbeat"
        if [ ${sys_type} == "yum" ]; then
        eval "curl -L -O https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-7.16.3-x86_64.rpm ${debug}"
        eval "rpm -vi packetbeat-7.16.3-x86_64.rpm ${debug}"
        eval "wget ${PACKETBEAT_YAML} -O /etc/packetbeat/packetbeat.yml ${debug}"
        elif [ ${sys_type} == "apt-get" ]; then
        eval "curl -L -O https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-7.16.3-amd64.deb ${debug}"
        eval "dpkg -i packetbeat-7.16.3-amd64.deb ${debug}"
        eval "wget ${PACKETBEAT_YAML} -O /etc/packetbeat/packetbeat.yml ${debug}"
        fi
    fi
    service packetbeat restart
    logger "Need assistance? Please contact Security"

sudo apt install auditd

sudo echo "wazuh_command.remote_commands=1" >> /var/ossec/etc/local_internal_options.conf
sudo echo "sca.remote_commands=1" >> /var/ossec/etc/local_internal_options.conf

sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
