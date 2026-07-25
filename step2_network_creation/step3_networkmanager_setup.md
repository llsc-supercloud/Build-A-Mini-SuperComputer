# NetworkManager Configuration

Configure eth0 and assign in IP address of 10.0.0.1.  
Run the following commands as root. 


```
 root$> nmcli con add type ethernet con-name "Eth0" ifname eth0 ip4 10.0.0.1/24
 root$> nmcli con mod "Eth0" ipv4.dns 8.8.8.8,8.8.4.4
 root$> nmcli con up Eth0
```



