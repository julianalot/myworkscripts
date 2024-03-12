#!/bin/bash

#
# This script takes the config and logs from DNS and DHCP servers across all sites
# This will be backed up to GCP via the nightly restic backups
#

# Variables
DHCPHQ=cpt-hq-dhcp01.hq.takealot.com
DHCPCPT=cpt-dc-dhcp01.cwh.takealot.com
DHCPJHB=jhb-dc-dhcp01.jwh.takealot.com

DNSHQ=cpt-hq-ns01.hq.takealot.com
DNSCPT=cpt-dc-ns01.cwh.takealot.com
DNSJHB=jhb-dc-ns01.jwh.takealot.com

TFILE=$(tempfile)
exec > $TFILE 2>&1

echo --------------------------------------------------
echo Backing up DNS, DHCP configuration and data
echo
echo DNS:  cpt-hq-ns01, cpt-dc-ns01, jhb-dc-ns01
echo       /etc/bind /var/lib/bind
echo
echo DHCP: cpt-hq-dhcp01, cpt-dc-dhcp01, jhb-dc-ns01
echo       /etc/dhcp /var/lib/dhcp
echo
echo Backup Date: `date +"%d/%m/%Y @ %H:%M"`
echo --------------------------------------------------
echo


# DHCP Servers

echo
echo ------------ Backing up DHCP Servers --------------
echo

# Phase 1 - Copy all files

echo Copying files from $DHCPHQ to /opt/backup/dhcp/HQ
cd /opt/backup/dhcp/HQ
scp -q $DHCPHQ:/etc/dhcp/dhcpd* .
scp -q $DHCPHQ:/var/lib/dhcp/dhcpd* .
scp -q $DHCPHQ:/var/log/syslog .
scp -q $DHCPHQ:/var/log/syslog.1 .

echo Copying files from $DHCPCPT to /opt/backup/dhcp/CPT
cd /opt/backup/dhcp/CPT
scp -q $DHCPCPT:/etc/dhcp/dhcpd* .
scp -q $DHCPCPT:/var/lib/dhcp/dhcpd* .
scp -q $DHCPCPT:/var/log/syslog .
scp -q $DHCPCPT:/var/log/syslog.1 .

echo Copying files from $DHCPJHB to /opt/backup/dhcp/JHB
cd /opt/backup/dhcp/JHB
scp -q $DHCPJHB:/etc/dhcp/dhcpd* .
scp -q $DHCPJHB:/var/lib/dhcp/dhcpd* .
scp -q $DHCPJHB:/var/log/syslog .
scp -q $DHCPJHB:/var/log/syslog.1 .

# Phase 2 - Zip all into a single file

echo
echo Zipping all files to dhcp-`date +"%Y%m%d"`.tgz
cd /opt/backup/dhcp
tar -czf ./zipped/dhcp-`date +"%Y%m%d"`.tgz HQ/* CPT/* JHB/*

# Phase 3 - Cleanup

echo Cleaning up
cd /opt/backup/dhcp
rm ./HQ/*
rm ./CPT/*
rm ./JHB/*
find /opt/backup/dhcp/zipped/dhcp*.tgz -type f -mtime +30 -delete


echo
echo ------------ Backing up DNS Servers --------------
echo

# Phase 1 - Copy all files

echo Copying files from $DNSHQ to /opt/backup/dns/HQ
cd /opt/backup/dns/HQ
scp -q $DNSHQ:/etc/bind/* ./etc
scp -q $DNSHQ:/var/lib/bind/* ./var

echo Copying files from $DNSCPT to /opt/backup/dns/CPT
cd /opt/backup/dns/CPT
scp -q $DNSCPT:/etc/bind/* ./etc
scp -q $DNSCPT:/var/lib/bind/* ./var

echo Copying files from $DNSJHB to /opt/backup/dns/JHB
cd /opt/backup/dns/JHB
scp -q $DNSJHB:/etc/bind/* ./etc
scp -q $DNSJHB:/var/lib/bind/* ./var

# Phase 2 - Zip all into a single file

echo
echo Zipping all files to dns-`date +"%Y%m%d"`.tgz
cd /opt/backup/dns/
tar -czf ./zipped/dns-`date +"%Y%m%d"`.tgz HQ/* CPT/* JHB/*

# Phase 3 - Cleanup

cd /opt/backup/dns
echo Cleaning up
cd /opt/backup/dns
rm ./HQ/etc/* ./HQ/var/*
rm ./CPT/etc/* ./CPT/var/*
rm ./JHB/etc/* ./JHB/var/*
find /opt/backup/dns/zipped/dns*.tgz -type f -mtime +30 -delete

# Phase 5 - Checking backups
echo
echo ------------ Checking backups --------------
echo
ls -l /opt/backup/dhcp/zipped/dhcp-`date +"%Y%m%d"`.tgz
echo
ls -l /opt/backup/dns/zipped/dns-`date +"%Y%m%d"`.tgz

# Email results and clean up
cat $TFILE | mail -aFrom:backup@takealot.com -s "Services Backup" backup@takealot.com
rm $TFILE
