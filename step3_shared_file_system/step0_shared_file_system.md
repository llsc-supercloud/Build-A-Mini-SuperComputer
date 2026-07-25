# Shared Filesystem

## Why a shared filesystem  

A shared filesystem allows the nodes in the cluster to share files and data.

## How to build the shared filesystem
### Summary
- Headnode
  1. Check for the new disk (lsblk)
  2. Partition the disk (fdisk)
  3.  Format the disk (mkfs.ext4)
  4. Mount the disk  (mount)
    - mount
    - edit /etc/fstab 
  5. NFS mount and export filesystem to compute nodes
    - Install nfs-kernel-server
    - Edit /etc/exports
    - Export filesystem (exportfs)

- Compute Node
  1. Install nfs-common
  2. Edit /etc/fstab
  3. Reload system daemon (systemctl daemon-reload)
  4. Mount  (mount -a)

