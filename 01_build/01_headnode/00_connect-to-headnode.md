### Supercomputing Networks
Supercomputers are impactful not because they are faster but because we can distribute many tasks across many machines.  In order for this to work, we need to create a network so that all the nodes are aware of one another and can share intermediate results and work collectively on an application.

#### Preparation

Before we start configuring the network, we need to do the following:

1. Connect to headnode via monitor, keyboard and mouse and open a terminal window
2. Connect the headnode to the switch
3. Get the IP address of the headnode - you can do this by typing the the following at the command line
```   
    ifconfig
```
4.  In the output that is printed to the screen look for wlan0, this section will print the IP address
5.  From your laptop: ssh to headnode as admin, at the IP address listing under wlan0
```
     ssh admin@<wlan0-ipaddress>
```
6.  become root using the command
```
   sudo su –
```

