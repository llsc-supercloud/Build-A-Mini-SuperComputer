# Setup the Shared Filesystem on the Headnode

1. Insert the 256G USB drive into the fast USB (blue).

Once inserted, you typically see it mounted in `/media/admin/Samsung USB`.

2. Unmount the 256G USB drive

```
   umount /media/admin/Samsung\ USB
```

3. Check for the block devices on the system

```
   root$> lsblk
   NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
   loop0    7:0    0    2G  0 loop
   sda      8:0    1 59.8G  0 disk
   |_sda1   8:1    1  512M  0 part /boot/firmware
   |_sda2   8:2    1 59.2G  0 part /
   sdb      8:16   1  239G  0 disk
   |_sdb1   8:17   1  239G  0 part /data
   zram0  254:0    0    2G  0 disk [SWAP]
```
The 256G USB drive is device _sdb_.
The 64G USB drive (containing the operating system) is device _sda_.

4. Partition the 256G USB drive.
Use the _fdisk_ command, a tool to manage the harddrive's structure, to partition the drive.

```
   root$>  fdisk /dev/sdb
```
The above command will start the fdisk interactive interface.
Type `m` to display a menu of command options and help documentation.

  - `p` : display partition table

  - `n` : create a partition

  - `w` : save partition information

Type `n` to create one partition. Follow the instructions. Save partition configuration by typing `w`.

5. The drive needs to be formatted using the  `mkfs.ext4` command.
This command will format the disk in ext4 format.

```
   root$>  mkfs.ext4 /dev/sdb1
```

6. Mount the drive to the mount point.
The mount point is /data. This /data has to created.

```
   # Create the mount point
   root$> mkdir /data
   # Mount /dev/sdb1 to /data
   root$> mount /dev/sdb1 /data
```

7. Edit /etc/fstab to make the drive automatically mount on bootup.
  - Get the UUID of drive /dev/sdb1
  ```
    root$> blkid
    /dev/sda2: LABEL="rootfs" UUID="8abab6b9-ef90-4fee-ae3d-91079bfae7c1" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="a1ed0854-02"
    /dev/sda1: LABEL_FATBOOT="bootfs" LABEL="bootfs" UUID="BFD4-9C30" BLOCK_SIZE="512" TYPE="vfat" PARTUUID="a1ed0854-01"
    /dev/sdb1: UUID="9e9d157d-05ef-450d-8834-023c08086cf9" BLOCK_SIZE="4096" TYPE="ext4"
    /dev/loop0: LABEL="origin:rpi-swap" TYPE="swap"
    /dev/zram0: LABEL="zram0" UUID="bd587daa-98aa-4880-b429-0bf240f0c5a5" TYPE="swap"
  ```
  The UUID of sdb1 is `UUID="9e9d157d-05ef-450d-8834-023c08086cf9"`

  - Add the UUID, mount point, format, mount options, backup operation, and file system check order to /etc/fstab.  For a nice explanation of fstab go [here](https://www.redhat.com/en/blog/etc-fstab).

    Add  `UUID=9e9d157d-05ef-450d-8834-023c08086cf9  /data  ext4  defaults  0  2`
  ```
  root$> cat /etc/fstab
  proc            /proc           proc    defaults          0       0
  PARTUUID=a1ed0854-01  /boot/firmware  vfat    defaults          0       2
  PARTUUID=a1ed0854-02  /               ext4    defaults,noatime  0       1
  UUID=9e9d157d-05ef-450d-8834-023c08086cf9  /data  ext4  defaults  0  2
  ```

8.  Share the drive with the compute nodes.

Here we will make the drive accessible to the compute over the network. The headnode will serve as the network filesystem (NFS) server.
  -  Install `nfs-kernel-server` 
```
    # Install nfs-server on the headnode
    root$> apt install nfs-kernel-server -y
```
  - Export the filesystem to the compute nodes.

      - Edit /etc/exports.
      - Run `exportfs -a`
```
   # After editing, look at /etc/exports file with cat.
   root$> cat /etc/exports
   # /etc/exports: the access control list for filesystems which may be exported
   #               to NFS clients.  See exports(5).
   #
   # Example for NFSv2 and NFSv3:
   # /srv/homes       hostname1(rw,sync,no_subtree_check) hostname2(ro,sync,no_subtree_check)
   #
   # Example for NFSv4:
   # /srv/nfs4        gss/krb5i(rw,sync,fsid=0,crossmnt,no_subtree_check)
   # /srv/nfs4/homes  gss/krb5i(rw,sync,no_subtree_check)
   #
   /data  10.0.0.0/24(rw,sync,no_root_squash,no_subtree_check)
   /data/software  10.0.0.0/24(rw,sync,no_root_squash,no_subtree_check)

   
   root$>  exportfs -a
```

  - Confirm the export worked.

  ```
    root$>  showmount -e
    Export list for headnode:
    /data/software 10.0.0.0/24
    /data          10.0.0.0/24
  ```


