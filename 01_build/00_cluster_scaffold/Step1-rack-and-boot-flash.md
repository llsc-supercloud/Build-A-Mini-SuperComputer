## Preparatory Work for Mini-Supercomputer

Supercomputers generally arrive as a set of preassembled racks filled with servers. To replicate a real HPC/supercomputer starting point, and because it takes about an hour to build the rack, we provided pre-built racks.  We also flashed the Raspberry Pi 4B's with the Boot Utility so that the default for booting is from the USB drive..


### Building the Rack
To build the rack , we followed the instructions included with the kit and the "BrambleBOX by C4 Labs - Assembly and Overview tutorial: https://www.youtube.com/watch?v=Xz8wMReHrWE&t=22s

Once the Raspberry Pi boards are on the drawer slides and installed into the rack, access to the SD slot is difficult.  For this reason, we recommending flashing all of the boards before inserting them into the rack.

### Flashing the Pi with Boot Utility
If you need to do this step yourself, follow the process below.

The cluster built with this set of instructions has been tested and confirmed for RaspberryPi Imager v2.0.X
NOTE: The newest Imager versions (2.0) are designed to simplify the installation of the operating system for a single Raspberry Pi where it is assumed that the user needs wifi to be operational on the system. 

#### Install the RaspberryPi Imager on your desktop or laptop

1. Go to either the home page of the Raspberry Pi Imager or the Git repo to download the imager for the appropriate OS:
    - [Home of RasperryPi Imager](https://www.raspberrypi.com/software/)
       - Select the download that is appropriate to the OS of your laptop.

    - [RaspberryPi Git](https://github.com/raspberrypi/rpi-imager/releases)

       - At the bottom of that block you will see: Assets
       - Download the file that matches the OS on your laptop

2. Install the imager
3. Open up the software
4. Select your device (we have Pi 4Bs)
5. Click on Choose Operating System
6. Click on Misc utility images
7. From the dropdown, select Bootloader (Select the correct Pi family))
8. From the dropdown, select USB Boot (so that USB Boot is first, followed by SD card)
9. Insert the 64 SD card into your laptop (you will need a microSD card to might need a USB-USB-C adapter)
10. Click on Choose Storage
11. Write the image to the SD card

#### Flash each of the Pi boards so that they boot from USB first

Once you have written the boot utility onto the SD card, it is time to flash the Pi boards.

1. For each of the nodes in your cluster,

-   Insert the SD card into the SD slot
   
-   Attach a keyboard, mouse and monitor
    
-   Power up the node
   
2. If you see a green screen on the monitor, you have correctly flashed the Pi
