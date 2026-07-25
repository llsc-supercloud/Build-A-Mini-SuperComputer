# Setup the Compute Node to NFS Mount the Shared Filesystem

1. Create the mount point, and create symlink /home/gridsan.

```
  root$> mkdir -p /data/software
  root$> ln -s /data /home/gridsan
```

2. Install the NFS client

```
  root$> apt install -y nfs-common

```
3. Edit /etc/fstab to mount the network drive
Add these 2 lines to /etc/fstab.  
`10.0.0.1:/data /data  nfs  defaults  0  0`
`10.0.0.1:/data/software /data/software  nfs  defaults  0  0`

```
root@node2:~# cat /etc/fstab
proc            /proc           proc    defaults          0       0
PARTUUID=ee43aca1-01  /boot/firmware  vfat    defaults          0       2
PARTUUID=ee43aca1-02  /               ext4    defaults,noatime  0       1
10.0.0.1:/data /data  nfs  defaults  0  0
10.0.0.1:/data/software /data/software  nfs  defaults  0  0
```

4. Reload the daemon

```
  root$>  systemctl daemon-reload
```

5. Mount

```
  root$>  mount -a
```

The above steps should be repeated for all the compute nodes.
