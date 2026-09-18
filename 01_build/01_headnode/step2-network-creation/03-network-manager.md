
# NetworkManager Configuration

We will be using the Network Manager Service to manage our network.
This will allow us to have one network using the eth0 interface for 
the cluster.  The headnode will also have access to wifi so that traffic
to the internet can be routed through a single device.

### Managing Eth0
To accomplish this, we start by instructing the Network Manager service to 
manage eth0 and assign an IP address of 10.0.0.1

To do this, as root, either type the commands below or run the nmcli-config-eth0.sh 
script that is included in network-scripts.

```
 root$> nmcli con add type ethernet con-name "Eth0" ifname eth0 ip4 10.0.0.1/24
 root$> nmcli con mod "Eth0" ipv4.dns 8.8.8.8,8.8.4.4
 root$> nmcli con up Eth0
```

If this is successful, you should see output similar to what is in the image below.
![confirmation of nmcli](../../images/nmcli-tho0-confirm.png)

### Test the Network Configuration

First, test to see that the Network Manager only controls eth0.  To do this, run 
the following command to get the device status.
```
   nmcli device status
```

The output should indicate that the wlan0 is connected to the correct router and eth0 is 
connected to Eth0.  

Second, confirm that the address 10.0.0.1 is being used for eth0.  
```text
  
    # As root at the headnode, issue the command
    ifconfig
```
Scroll up to eth0, and check to see that you see `inet 10.0.0.1` as in the image below.
![confirming eth0](../../images/nmcli-test-confirm)

Now that the network is configured, it is time to configure the compute nodes.
