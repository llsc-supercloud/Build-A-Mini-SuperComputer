## Configuring the OS via the Imager

### Select the Device
When the imager starts up, the first task is to select the device that you will be using

On the left under *Setup Steps*, click on the *Device* button (Raspberry Pi Device) and a menu *Select your Raspberry Pi Device* will appear in the main pane. Select the Raspberry Pi device  (For our cluster, it was Raspberry Pi 4)

### Select Operating System

Once you have selected your device, click the *OS* button (Operating System) under *Setup Steps*.  *Choose operating system* menu will appear in the main pane. select Raspberry Pi OS (64 bit). This is the version that is a port of Debian Trixie with Raspberry Pi Desktop.  It is also the recommended OS.

### Select Storage Device

Select *Storage* under *Setup Steps*.
The step is to select the device that you will write the OS onto.  

1. Insert the 64 GB drive into your laptop (you might need a USB-USB-C adapter)
2. Click on Choose Storage
3. Select the Flash Drive you just inserted into your system (We will refer to this as the USB Drive throughout these notes)
4. Hit *NEXT*

### Applying Customizations

You will see a dialog box asking if you want to customize the OS.  **Do not clck on Save until you have completed all of the modifications.**
Select "Edit Settings"

Under *Customisation*
1. Hostname
2. Localisation
3. User
4. WiFi
5. Remote Access
6. Raspberry Pi Connect

#### Hostname
1. provide the name of the node.  You will do this for each of the nodes that you have, one headnode and n compute nodes.  The naming convention used for these notes is:
      headnode
      node1
      node2
      node3, etc


#### Localisation
1. Select capital city, time zone, keyboard layout

#### User
1. set the username and password. The convention we are using is:
      username:  admin  
      password:  your choice - use the same password on all nodes

#### WiFi
- For the headnode, set WiFi SSID and password to enable it.
- For compute nodes, leave WiFi entries blank.

#### Remote Access
1. Enable SSH
2. Select password authentication

#### Raspberry Pi Connect
- **DO NOT enable** due to security concerns.

Finally, confirm all selections and inputs. Then click *Write* to write the OS image to the USB drive.



