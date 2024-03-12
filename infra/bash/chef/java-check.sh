#!/bin/bash
# Assign the string for the hostnames
ALL_HOSTS=(
cpt-hq-es02.hq.takealot.com
cpt-hq-syslog01.hq.takealot.com
cpt-hq-dhcp02.hq.takealot.com
jira-collector.hq.takealot.com
webmail.hq.takealot.com
cpt-hq-ofrep01.hq.takealot.com
cpt-hq-logstash01.hq.takealot.com
cpt-hq-knime01.hq.takealot.com
cpt-hq-map01.hq.takealot.com
cpt-hq-es01.hq.takealot.com
cpt-hq-es03.hq.takealot.com
cpt-hq-hivcor01.hq.takealot.com
cpt-hq-logstr01.hq.takealot.com
cpt-hq-logstr02.hq.takealot.com
cpt-hq-ofrep01.hq.takealot.com
)
# ALL_HOSTS=(
# "k8s-node-28.stagealot.com
# k8s-lb-01.stagealot.com
# k8s-etcd-01.stagealot.com"
# )
# For each line in the string, do this block using the $THIS_IP variable
for THIS_IP in ${ALL_HOSTS[@]}; do
    echo "==================================="
    echo $THIS_IP
    ssh -o StrictHostKeyChecking=no $THIS_IP "which java; java -version"
done
