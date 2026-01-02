## Preparatory Work for Mini-Supercomputer

Supercomputers generally arrive as a set of preassembled racks filled with servers. To replicate a real HPC/supercomputer starting point, and because it takes about an hour to build the rack, we provided pre-built racks.  We flashed the Raspberry Pi 4B's with the Boot Utility.


### Building the Rack
To build the rack , we followed the instructions included with the kit and the "BrambleBOX by C4 Labs - Assembly and Overview tutorial: https://www.youtube.com/watch?v=Xz8wMReHrWE&t=22s

Once the Raspberry Pi boards are on the drawer slides and installed into the rack, access to the SD slot is difficult.  For this reason, we recommending flashing all of the boards before inserting them into the rack.

### Flashing the Pi with Boot Utility
If you need to do this step yourself, the process is:

1. Download the Raspberry Pi imager onto your desktop system.  This set of instructions has been tested and confirmed for RaspberryPi Imager v1.9.6 

    Go to: https://github.com/raspberrypi/rpi-imager/releases

    Scroll down until you find: 1.9.6

    At the bottom of that block you will see: Assets

    Download the version for the OS on your laptop 
2. Install the imager on your system
3. Open up the software
4. Select your device (we have Pi 4Bs)
5. Click on Choose Operating System
6. Click on Misc utility images
7. From the dropdown, select Bootloader (Pi 4 Family)
8. From the dropdown, select USB Boot (so that USB Boot is first, followed by SD card)
9. Insert the 64 SD card into your laptop (you will need a microSD card to might need a USB-USB-C adapter)
10. Click on Choose Storage
11. Write the image to the SD card

Once you have written the boot utility onto the SD card, it is time to flash the Pi boards.

1. For each of the nodes in your cluster,

     Insert the SD card into the SD slot
   
     Attach a keyboard, mouse and monitor
    
     Power up the node
   
3. If you see a green screen on the monitor, you have correctly flashed the Pi
