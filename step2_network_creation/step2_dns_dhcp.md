# Domain Name System (DNS) and Dynamic Host Configuration Protocol (DHCP)

DNS - service to translate names to IP addresses.

DHCP - a network management protocol to assign IP addresses to devices and other network configuration on the network.

Dnsmasq does the job of DNS and DHCP.

1. Install dnsmasq on the headnode.
```
   # Become root
   sudo su -
   # Update and upgrade the system packages.
   apt update && apt upgrade
   # Install dnsmasq
   apt install dnsmasq
```

2. Edit /etc/hosts by adding node names and IP addresses

>  127.0.1.1 headnode
>  10.0.0.1 headnode
>  10.0.0.51 node1
>  10.0.0.52 node2
>  10.0.0.53 node3

3. Edit /etc/dnsmasq.conf

To enable DHCP, the following parameters need to be set in /etc/dnsmasq.conf.  
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

