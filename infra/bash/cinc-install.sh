#!/usr/bin/env bash
 
set -eu -o pipefail
 
#################################################################################
### A script to check the version of Ubuntu being run install, run and enable ###
### the appropriate version of cinc                                           ###
###                                                                           ###
### THE FILE MUST BE NAMED cinc-install.sh in order to work fully             ###
###                                                                           ###  
### Created by Julian Bailey                                                  ###  
### On 12th October 2022                                                      ###  
### Version 0.1.1                                                             ###  
#################################################################################
 
VERSION=$(cut -b 8-9 </etc/issue)
 
if [[ $VERSION -eq  16 ]]
then
        DEB_FILE='cinc_15.17.4-1_amd64.deb'
elif [[ $VERSION -gt 16 ]]
then
        DEB_FILE='cinc_18.0.185-1_amd64.deb'
else
        echo "Can't determine Ubuntu release from /etc/issue"
        exit 0
fi
 
# Overridable via pre-existing environment variable
#URL="${URL:-http://cpt-hq-appstore.hq.takealot.com/data/cinc/ubuntu/client}"
URL="${URL:-http://downloads.cinc.sh/files/stable/cinc/17.10.0/ubuntu/18.04}"

 
### Depending ubuntu version will decide whether to install version-pinned cinc ###
[[ $(dpkg -l cinc) ]] || {
        curl -sLO "$URL"/"$DEB_FILE" && dpkg -i "$DEB_FILE"
}
 
# Do nothing if cinc-client has been bootstrapped
DO_RESTART=''
[ -f /etc/cinc/client.pem ] || {
        # Only if /etc/chef has previous bootstrap info
        [ -f /etc/chef/client.pem ] && {
                (mv /etc/cinc /etc/cinc.ORIG || true) && ln -s /etc/chef /etc/cinc
                DO_RESTART=yes
        }
}
 
[[ $(dpkg -l chef >/dev/null 2>&1) ]] && apt remove --purge -y chef
 
[[ -n "$DO_RESTART" ]] && {
        chef-client && systemctl restart chef-client.service
}
 
### Cleanup Section                        ###  
rm -f $DEB_FILE cinc-install.sh
 
exit 0
