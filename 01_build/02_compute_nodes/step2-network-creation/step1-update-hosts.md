
### Update /etc/hosts 
Configure the /etc/hosts file on the compute nodes so they are aware of the headnode

-   Navigate to /etc and open the file `hosts`
-   Add the following lines at the bottom of the file. 
```
-  127.0.1.1 node1
-  10.0.0.1 headnode
```
-  Save the file.


### Test the network

-   Connect the compute node to the switch 
-   From the compute node run the following commands:
```
   hostname
   ping headnode
```

You should see output that looks like:
![output from pin](../../images/ping-headnode.png)
