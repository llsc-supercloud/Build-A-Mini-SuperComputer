
## Set Root Password on the Node

When we configured the OS on the Raspberry Pi we set the admin password.  
Now, to simplify the remaining system configuration, we are going to set the root password

### Set Root Password

-   Become root `sudo su -`
-   As root, execute the command `passwd`
-   You will be prompted for a password.  For this class we are using `llsc`
-   You will be prompted to retype the new password

If you are successful, you should see the following message:
(The image was captured for node3 and you should see a similar image.)
![root password success](../../images/root-password.png

### Test the root password on the node 

-   From your local system, login to the headnode as root
```
   ssh root@<IP iaddress>
```
-   You may be asked if you want to continue, type: yes
-   When asked for a password, provide the password you just set

If you are sucessful, you should have access to the system and see the following message:
(The image was captured for node3 and you should see a similar image.)
![testing root password](../../images/test-root-password.png)


