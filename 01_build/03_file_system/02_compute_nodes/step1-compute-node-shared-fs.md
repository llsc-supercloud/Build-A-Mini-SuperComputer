# Setup the Compute Node to NFS Mount the Shared Filesystem

1. Create the mount point, and create symlink /home/gridsan on each of the compute nodes.

```bash
  root@node1$> mkdir -p /data/software
  root@node1$> ln -s /data /home/gridsan
```

2. Install the NFS client

The NFS client will connect with the NFS server on the headnode. 
Install the nfs-common package which contains the client.

```bash
  root@node1$> apt install -y nfs-common

```
3. Edit /etc/fstab to mount the network drive

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

4. Reload the systemd daemon  to recognize the changes to /etc/fstab.

```bash
  root@node1$>  systemctl daemon-reload
```

5. Mount the NFS

Running `mount -a` command will mount the drive to the mount point.

```bash
  root@node1$>  mount -a
```

The above steps should be repeated for all the compute nodes.
