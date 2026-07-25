# Time Sync using NTP

Use NTP to sync time.  

- Start the NTP client

`timedatectl set-ntp true`

- Check the time

` timedatectl status`

- It may be necessary to restart the timesync service
`sudo systemctl restart systemd-timesyncd`