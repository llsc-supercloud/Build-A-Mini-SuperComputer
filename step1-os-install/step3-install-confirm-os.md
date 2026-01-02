### Install OS on each node
Once you have written the OS onto the USB drive, you want to install it into the node.  For every node, you will 
1. Insert the USB Drive into the Pi
2. Connect the Pi to power
3. Connect the Pi to the Monitor using the micro-USB to HDMI cable
4. Connect a keyboard
5. Connect a mouse

When the monitor comes up, you should see the Raspbian Desktop.  

#### Headnode
The headnode needs to communicate with the internet via a hardwired or wifi connection.  If you are using wifi, you will need to select the network and provide the password. Confirm that the network is correct by opening the browser and connecting to a site.

### Confirming the OS customizations on each node
We made some customizations to our OS and before moving to the next node you should confirm that those customization were properly applied.
1. check to see that the node name is what you expect; headnode or node#
2. check to see that SSH is enabled

#### If the customizations were not correctly applied
Open a terminal window and type "raspi-config" at the command line
This will bring up crude dialog box that will allow you to set the nodename and enable ssh.  

### Configure SSH with Password Authentication
This is one configuration that often fails to be applied properly.  To force this configuration, we need to edit the /etc/ssh/sshd_config file.

With the screen, keyboard and mouse connected to the headnode

Open a terminal window

**NOTE:**  We will be using vi/vim as our editor.  If you are not familiar with this editor please review the “Reference Sheet” and ask for help or use an editor that you are familiar with.

You are currently, admin@nodeName and to modify the file you need to be root.  To become root, type the following at the command:
```
      sudo su -
```
We need to edit /etc/ssh/sshd_config. Navigate to /etc/ssh and open the file with vi
```
    cd /etc/ssh
    vi sshd_config
```
Change “PasswordAuthentication” to “yes” and then save the file.  

To save the configuration changes, restart ssh.  At the command line type
```
   systemctl restart sshd
```


  


