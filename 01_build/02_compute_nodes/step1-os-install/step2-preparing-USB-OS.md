## Configuring the OS via the Imager

Open the RaspberryPi imager application and it will walk you through the steps to write the OS image onto a device of your choice.  This configuration uses a USB drive to provide for an easy upgrade path when needed. 


### Select the Device
When the imager starts up, the first task is to select the device that you will be using

Click on the left most button (Raspberry Pi Device) and select your device from the dropdown menu.  (For our cluster, it was Raspberry Pi 4)

### Select Operating System

Once you have selected your device, move to the middle button (Operating System).  From the list, select Raspberry Pi OS (64 bit). This is the version that is a port of Debian Trixie with Raspberry Pi Desktop.  It is also the recommended OS.

### Select Storage Device

Click on Storage in the left hand menu to select the device that you will write the OS onto.  

1.  Insert the 64 GB drive into your laptop (you might need a USB-USB-C adapter)
2.  Click on Choose Storage
3.  Select the USB Drive you just inserted into your system (We will refer to this as the USB Drive throughout these notes)
4.  Hit return

### Applying Customizations
Note that this needs to be completed for each node.  The only change will be node name: node1 to nodeN where N is the number of compute nodes that you have.  Once you have set the configuration for Node1, the imager should retain your previous selections but you should check each configuration option.

You will see a dialog box asking if you want to customize the OS.  **Do not clck on Save until you have completed all of the modifications.**
The imager will walk you through the customizations, after you have set the values for each item, select 'NEXT'.

1.  Hostname: In the dialog box, type node_number (without quotes) and hit. (NOTE: node_number is the compute node number associated with the board you are imaging.)
2.  Localization: Set the capital city of your country, your time zone and your preferred keyboard layout.
3:  User:  There are 2 important dialog boxes
       -   Name:  we are using admin
       -   Password:  your choice, it needs to be the same on all nodes
4.  WiFi:  Leave blank, if there is a network listed, remove it and the passwords
5.  Remote Access:  
       -   Enable SSH by clicking the dialog button to turn it on
       -   Use Password Authentication:  click on the radio button next to Use Password Authentication
6.  Raspberry Pi Connect
       -   Confirm that Raspberry Pi Connect is disabled (off)


### Write the Image to the USB drive
You are now ready to write the image ot the USB drive.  Review the information that is displayed to confirm

-   storage device
-   customizations that you have set

When you are confident that it has been set correctly, click on Write.
There are 2 stages to the Write: 
1.   The image is written
2.   The image is verified

Note:  depending on your laptop, this might take a few minutes and there is a progress bar to track where the process is. 


