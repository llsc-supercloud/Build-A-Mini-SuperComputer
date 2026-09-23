
# Time Sync using NTP
In order for the network and applications to work on the cluster
all nodes must be synchronized so that they have the same date and 
time.  We will use NTP To synchronize them.


- As root, activate the NTP client.

`timedatectl set-ntp true`

- Check the time status

` timedatectl status`

- It may be necessary to restart the timesync service.  This is also the 
command that you will use to restart the NTP server if there is a problem with 
your time synchronization
```
  sudo systemctl restart systemd-timesyncd
```
