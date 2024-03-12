#!/bin/bash
export GOOGLE_PROJEDT_ID=gcp-takealot
export GOOGLE_APPLICATION_CREDENTIALS=/etc/restic/backup.json

LOGFILE=/var/log/restic/restic.log

exec >> $LOGFILE 2>&1

# First time we do a backup we need to first create the repo
if [ ! -f "/etc/restic/.repocreated" ]; then
   restic -r gs:takealot-backup:/restic/`hostname` --password-file=/etc/restic/passwd init
   touch /etc/restic/.repocreated
fi

echo -------------------------------------------------------------------------------------

# Sleep random  time within a 4 hour period so all backups don't happen at the same time
rmin=$(( $RANDOM % 240 * 60 ))
echo Sleeping for $rmin seconds
sleep $rmin

echo Backup started `date`

cpulimit -b -e restic -l 50

restic -r gs:takealot-backup:/restic/`hostname` --password-file=/etc/restic/passwd backup / --exclude-file=/etc/restic/exclude

echo "Pruning"
restic -r gs:takealot-backup:/restic/`hostname` --password-file=/etc/restic/passwd forget --prune  --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --keep-yearly 75


killall cpulimit

echo Backed finished `date`
