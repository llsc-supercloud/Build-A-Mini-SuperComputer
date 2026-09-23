#!/bin/bash

# Add eth0 with NetworkManager
# Set eth0 to a static IP address
# Set dns address
# These nmcli commands will generate /etc/NetworkMaanager/system-connections/Eth0.nmconnections
nmcli con add type ethernet  con-name Eth0 ifname eth0 ip4 10.0.0.1/24
nmcli con mod Eth0 ipv4.dns "8.8.8.8;8.8.4.4"
nmcli con up Eth0

