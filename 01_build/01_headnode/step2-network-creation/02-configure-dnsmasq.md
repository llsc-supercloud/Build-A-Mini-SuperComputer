
# Domain Name System (DNS) and Dynamic Host Configuration Protocol (DHCP)

DNS - service to translate names to IP addresses.

DHCP - a network management protocol to assign IP addresses to devices and other network configuration on the network.

Dnsmasq does the job of DNS and DHCP.

### Install dnsmasq on the headnode.
```
   # Become root
   sudo su -
   # Update and upgrade the system packages.
   apt update && apt upgrade
   # Install dnsmasq
   apt install dnsmasq
```

### Establish the hosts within the system

-   Navigate to /etc and open the file `hosts`
-   Add the following lines at the bottom of the file. (This example is for 
4 nodes, if you have 5 nodes, add another by adding the line 
(10.0.0.54 node4) at the bottom.
```
-  127.0.1.1 headnode
-  10.0.0.1 headnode
-  10.0.0.51 node1
-  10.0.0.52 node2
-  10.0.0.53 node3
```
-  Save the file.

### Confirm the modifications to /etc/hosts
At the command line, type `cat hosts`
The output should look like:
![output from cat etc/hosts](../../etc-hosts.png)

### Configure dnsmasq on the headnode
The system will be using DHCP.  To enable DHCP, we need to set some 
parameters in the file /etc/dsnmasq.conf
In particular, the commands that we will modify are:
```text
# Network interface to listen to
interface=eth0
bind-interfaces

# DHCP range for cluster nodes
dhcp-range=10.0.0.1,10.0.0.100,12h

# Gateway and DNS
dhcp-option=3,10.0.0.1
dhcp-option=6,10.0.0.1

# Enable DNS forwarding
server=8.8.8.8
server=8.8.4.4

# Optional: log DNS queries for debugging
log-queries

# Domain name
expand-hosts
domain=cluster.local

# Static leases for nodes
dhcp-host=headnode,10.0.0.1
dhcp-host=node1,10.0.0.51
dhcp-host=node2,10.0.0.52
dhcp-host=node3,10.0.0.53
dhcp-host=node4,10.0.0.54
```

The cleanest was to do this is to replace the default RaspberryPi file /etc/dsnmaasq.conf 
with the `dnsmasq.conf` file in the network-scripts.  
```
  # Become root
  sudo su -
  # copy the file
  cp /location-downloaded-scripts/dnsmasq.conf /etc/dnsmasq.conf
```


