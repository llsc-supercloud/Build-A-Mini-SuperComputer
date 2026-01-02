## Configuring the OS via the Imager

### Select the Device
When the imager starts up, the first task is to select the device that you will be using

Click on the left most button (Raspberry Pi Device) and select your device from the dropdown menu.  (For our cluster, it was Raspberry Pi 4)

### Select Operating System

Once you have selected your device, move to the middle button (Operating System).  From the dropdown, select Raspberry Pi OS (64 bit). This is the version that is a port of Debian Trixie with Raspberry Pi Desktop.  It is also the recommended OS.

### Select Storage Device

The final button on the far right is to select the device that you will write the OS onto.  

1. Insert the 64 GB drive into your laptop (you might need a USB-USB-C adapter)
2. Click on Choose Storage
3. Select the Flash Drive you just inserted into your system (We will refer to this as the USB Drive throughout these notes)
4. Hit return

### Applying Customizations

You will see a dialog box asking if you want to customize the OS.  **Do not clck on Save until you have completed all of the modifications.**
Select "Edit Settings"

Another dialog box will pop open that has 3 sections:
1. General
2. Services
3. Options

#### General Customizations
1. provide the name of the node.  You will do this for each of the nodes that you have, one headnode and n compute nodes.  The naming convention used for these notes is:
      headnode
      node1
      node2
      node3, etc
2. set the username and password. The convention we are using is:
      username:  admin
      password:  your choice - use the same password on all nodes
3. DO NOT CONFIGRE WIRELESS LAN
4. Move to the 2nd tab: Services

#### Services Customizations
We will use SSH across the cluster, 
1. click on enable SSH
2. click on Use Password Authentication

#### Options
We did not modify anything in the Options tab.

#### Save the configurations and write the OS to the USB drive
1. Click on Save to save our configurations
2. When you are asked about overwriting the existing USB drive, select Yes

The image will be written to the USB drive and verified. 


