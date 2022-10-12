nmcli device show enp0s31f6 | grep IP4.DNS
systemd-resolve --status | grep -B 9 -A 6 Current DNS Server
