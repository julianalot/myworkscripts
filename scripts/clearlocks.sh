#!/bin/bash
#
# This script finds any backups that has a repository lock for over 24 hours and clears them
# We find there are times when backups fail, and the locks are not cleared
#
# Relies on the snapshot check to fail with the message below
#
# Fatal: unable to create lock in backend: repository is already locked exclusively by PID 115457 on webmail by  (UID 0, GID 0)
# lock was created at 2020-07-28 00:55:35 (7h20m41.080906604s ago)
#

export GOOGLE_PROJEDT_ID=gcp-takealot
export GOOGLE_APPLICATION_CREDENTIALS=/etc/restic/backup.json

SRV=`gsutil ls gs://takealot-backup/restic | awk -F'/' '{print $5}'`

TFILE=$(tempfile)
exec > $TFILE 2>&1

# Go though all the restic repos on gs://takealot-backup/restic

echo "Checking restic repository locks"

for server in $SRV ; do

       if [ "$server" == "config" ] || [ "$server" == "data" ] || [ "$server" == "index" ] || [ "$server" == "keys" ] || [ "$server" == "locks" ] || [ "$server" == "snapshots" ];
       then
	    continue;
       fi

       # For each check search for "lock was created" line and extract the value between ( and h) to get the hour value
       hour=$(restic -q -r gs:takealot-backup:/restic/$server  --password-file=/etc/restic/passwd snapshots -c --last 2>&1 | grep "lock was created" | grep -o -P '(?<=\().*(?=h)')

       # Check first that $hour has a value (no value, means no error, which means no lock, so nothing to do)
       if [ ! -z "$hour" ]; then

	        # If lock was created over 24 hours ago
       		if [ $hour -ge 24 ]; then

			echo "Unlocking $server.  Backup lock over 24 hours ago ($hour hours)"
			# Remove lock
			restic -q -r gs:takealot-backup:/restic/$server --password-file=/etc/restic/passwd unlock
       		fi
       fi
done

# Email results and clean up
cat $TFILE | mail -aFrom:backup@takealot.com -s "Restic Clear Backup locks" backup@takealot.com
rm $TFILE
