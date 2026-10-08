#!/bin/bash

# Run as root
# Unpack llgrid-commands deb package to /usr/local 
dpkg -x ../configs/llgrid-commands_20260925-1ubuntu1_all.deb /

# Copy txpi4.yml
cp ../configs/usr/local/LLSC/ll_config/txpi4.yml /usr/local/LLSC/ll_config

# Copy llgrid.id
cp ../configs/etc/llgrid.id /etc

# Make files world readable, eg txpi4.yml and llgrid.id
#  Octal values example - chmod 644 /usr/local/LLSC/ll_config/txpi4.yml 
chmod o+r /usr/local/LLSC/ll_config/txpi4.yml
chmod o+r /etc/llgrid.id
