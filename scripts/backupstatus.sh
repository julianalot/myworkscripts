#!/bin/bash
export GOOGLE_PROJEDT_ID=gcp-takealot
export GOOGLE_APPLICATION_CREDENTIALS=/etc/restic/backup.json
SRV=`gsutil ls gs://takealot-backup/restic | awk -F'/' '{print $5}'`

TFILE=$(tempfile)
exec > $TFILE 2>&1

echo "<html>
<head>
<style>
code {
font-family: monospace;
}
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 90%;
}
td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}
</style>
</head>
<body>
<h2>Takealot Backup report</h2>
<h3>Date: `date`</h3>
For further details refer to <a href=\"https://jira.takealot.com/wiki/display/IN/Backups\">Takealot Backups</a><p>"

# List Services Backups (DNS, DHCP)
echo "<table>"
echo "<tr><th>Latest DNS Backups</th></tr>"
echo "<tr><td>To check: Should be 5 backups with dates for the last 5 days, all similar size</tr></td>"
echo "<tr><td><pre>"
ls -s -h --format single-column /opt/backup/dns/zipped
echo "</pre></td></tr>"
echo "</table>"
echo "<p>"

echo "<table>"
echo "<tr><th>Latest DHCP Backups</th></tr>"
echo "<tr><td>To check: Should be 5 backups with dates for the last 5 days, all similar size</tr></td>"
echo "<tr><td><pre>"
ls -s -h --format single-column /opt/backup/dhcp/zipped
echo "</pre></td></tr>"
echo "</table>"
echo "<p>"

# List Jira and Confluence backups (application based backups)
echo "<table>"
echo "<tr><th>Jira Backups</th></tr>"
echo "<tr><td>To check: There should be 2 backups per day 9am and 9pm, all similar size</tr></td>"
echo "<tr><td><pre>"
ssh backupuser@jira.hq.takealot.com ls -s -h --format single-column /var/atlassian/application-data/jira/export | grep zip
echo "</pre></td></tr>"
echo "</table>"
echo "<p>"

echo "<table>"
echo "<tr><th>Confluence Backups</th></tr>"
echo "<tr><td>To check: Should be a backup per day similar size</tr></td>"
echo "<tr><td><pre>"
ssh backupuser@confluence.hq.takealot.com ls -s -h --format single-column /var/atlassian/application-data/confluence/backups | grep zip
echo "</pre></td></tr>"
echo "</table>"
echo "<p>"

# List MySQL backups
echo "<table>"
echo "<tr><th>Latest MySQL backups</th></tr>"
echo "<tr><td>To check: Each /opt/backup/mysql/\$DBNAME/\$DATABASE folder should contain the last 9 backups<br>Each of these 9 backups should be the last 9 days with similar size backups</tr></td>"
echo "<tr><td><pre>"
du -sh /opt/backup/mysql/*/*/*
echo "</pre></td></tr>"
echo "</table>"
echo "<p>"

# Restic backup summary - show the latest snapshot for each server
echo "<table>"
echo "<tr><th>Restic backup snapshot summary</th></tr>"
echo "<tr><td>To check: Each backup was run either yesterday or today<br>If the repository is locked and is greater than 24 hours ago, notify INFRA</tr></td>"
echo "<tr><td>Latest snapshots as of `/bin/date`</td></tr>"
echo "<tr><td>ID        Time                 Host                  Tags</td></tr>"

for server in $SRV ; do
       if [ "$server" == "config" ] || [ "$server" == "data" ] || [ "$server" == "index" ] || [ "$server" == "keys" ] || [ "$server" == "locks" ] || [ "$server" == "snapshots" ];
       then
	    continue;
       fi
       echo "<tr><td><pre>"
       restic -q -r gs:takealot-backup:/restic/$server  --password-file=/etc/restic/passwd snapshots -c --last | fgrep -v "ID" | fgrep -v "snapshots" | egrep -v "\-\-"
       echo "</pre></td></tr>"
done
echo "</table>"
echo "<p>"

# Restic backup detail - show all snapshots for each server
echo "<table>"
echo "<tr><th>Restic backup snapshot details</tr></th>"
echo "<tr><td>To check: Should only have the last 8 daily, 5 weekly, 13 monthy backups<br>Any issues notify INFRA</td></tr>"
echo "<tr><td>All snapshots</td></tr>"
echo "<tr><td>ID        Time                 Host                  Tags</td></tr>"

for server in $SRV ; do
       if [ "$server" == "config" ] || [ "$server" == "data" ] || [ "$server" == "index" ] || [ "$server" == "keys" ] || [ "$server" == "locks" ] || [ "$server" == "snapshots" ];
       then
            continue;
       fi
       echo "<tr><td><pre>"
       restic -q -r gs:takealot-backup:/restic/$server  --password-file=/etc/restic/passwd snapshots -c | fgrep -v "ID" | fgrep -v "snapshots"  | egrep -v "\-\-"
       echo "</pre></td></tr>"
done
echo "</table>"

echo "</body>"

# Email results and clean up
cat $TFILE | mail -aFrom:backup@takealot.com -a "Content-type: text/html" -s "Takealot Backup Status" backup@takealot.com
rm $TFILE
