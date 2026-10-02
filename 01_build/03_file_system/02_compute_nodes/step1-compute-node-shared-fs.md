# Setup the Compute Node to NFS Mount the Shared Filesystem

1. Install the NFS client

The NFS client will connect with the NFS server on the headnode. 
Install the nfs-common package which contains the client.

```bash
  root@node1$> apt install -y nfs-common
```

2. Edit /etc/fstab to mount the network drive

Add these 2 lines to /etc/fstab.  
`10.0.0.1:/data /data  nfs  defaults  0  0`
`10.0.0.1:/data/software /data/software  nfs  defaults  0  0`

```bash
# After editing, check /etc/fstab
root@node1:~# cat /etc/fstab
proc            /proc           proc    defaults          0       0
PARTUUID=ee43aca1-01  /boot/firmware  vfat    defaults          0       2
PARTUUID=ee43aca1-02  /               ext4    defaults,noatime  0       1
10.0.0.1:/data /data  nfs  defaults  0  0
10.0.0.1:/data/software /data/software  nfs  defaults  0  0
```

3. Create the mount point, and create symlink /home/gridsan on each of the compute nodes.

```bash
  root@node1$> mkdir -p /data/software
  root@node1$> ln -s /data /home/gridsan
```

4. Reload the systemd daemon  to recognize the changes to /etc/fstab.

```bash
  root@node1$>  systemctl daemon-reload
```

5. Mount the filesystem

Running `mount -a` command will mount the drive to the mount point.

```bash
  root@node1$>  mount -a
```
6.  Check that the drive is mounted.

Run the `df` command.

```bash
root@node1:~ $ df
Filesystem              1K-blocks     Used Available Use% Mounted on
udev                      3728924        0   3728924   0% /dev
tmpfs                     1601288     9320   1591968   1% /run
/dev/sda2                61078840  7150480  51372592  13% /
tmpfs                     4003220      212   4003008   1% /dev/shm
tmpfs                        5120       16      5104   1% /run/lock
tmpfs                        1024        0      1024   0% /run/credentials/systemd-journald.service
tmpfs                     4003220        4   4003216   1% /tmp
/dev/sda1                  516204    88908    427296  18% /boot/firmware
10.0.0.1:/data          245580800 39260160 193773568  17% /data
10.0.0.1:/data/software 245580800 39260160 193773568  17% /data/software
tmpfs                      800644       64    800580   1% /run/user/1000
tmpfs                        1024        0      1024   0% /run/credentials/getty@tty1.service
tmpfs                        1024        0      1024   0% /run/credentials/serial-getty@ttyS0.service
```

The above steps should be repeated for all the compute nodes.
