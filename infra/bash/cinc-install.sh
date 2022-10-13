#!/bin/bash

#################################################################################
### A script to check the version of Ubuntu being run install, run and enable ###
### the appropriate version of cinc					      ###							###
###                                                                           ### 
###	THE FILE MUST BE NAMED cinc-install.sh in order to work fully         ###
###                                                                           ###   
### Created by Julian Bailey						      ###	
### On 12th October 2022						      ###	
### Version 0.1.1							      ###	
#################################################################################

VERSION=`cat /etc/issue | cut -b 8-9`

VERSION_STD="https://storage.googleapis.com/tal_eu_devops_public/cinc/cinc_17.10.0-1_amd64_ubuntu20.04.deb"
INSTALL_STD="cinc_17.10.0-1_amd64_ubuntu20.04.deb"

VERSION_16="https://storage.googleapis.com/tal_eu_devops_public/cinc/cinc_15.17.4-1_amd64.deb"
INSTALL_16="cinc_15.17.4-1_amd64.deb"

### Depending ubuntu version will decide whether to install the latest cinc ###
### client or a version appropriate to Ubuntu 16

if [[ $VERSION -eq  16 ]]
then
        VERSION=$VERSION_16 && INSTALL=$INSTALL_16
elif [[ $VERSION -gt 16 ]]
then
        VERSION=$VERSION_STD && INSTALL=$INSTALL_STD
else
    echo "Not applicable here"
    exit 0
fi

###  The execution section - created by Cheewai Lai and published here	      ###
###  https://jira.takealot.com/wiki/pages/viewpage.action?pageId=134743477    ###

curl -sLO $VERSION && \
dpkg -i $INSTALL && \
(mv /etc/cinc /etc/cinc.ORIG || true) && \
ln -s /etc/chef /etc/cinc && \
apt remove --purge -y chef && \
chef-client && \
systemctl restart chef-client.service

### Cleanup Section							       ###   

rm -f $INSTALL
rm -f cinc-install.sh

exit 0
