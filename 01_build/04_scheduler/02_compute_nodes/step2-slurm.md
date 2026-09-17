# Install Slurm on the compute node

The slurm daemon (slurmd) will run on each compute node.

## Install slurmd and slurm-client packages 

Do the installation as root.
The slurmd package contains the slurm daemon.
The slurm-client package contains the slurm commands such as sbatch, sinfo, scontrol, etc.

1. Install slurmd and slurm-client on each compute node.

```bash
   root@node1$>  apt install slurmd slurm-client -y
```

2. For consistency, all nodes should have the same slurm.conf. You can copy `/etc/slurm/slurm.conf` from the headnode to `/etc/slurm/` of each compute node. The slurm.conf can also be found in the `scripts_and_conf/etc/slurm` directory.

3. Enable and start slurmd as a service on each compute node.

As root, use the `systemctl` command.

```bash
  # Enable slurmd service to start at bootup.
  root@node1$> systemctl enable slurmd
  # Start the service
  root@node1$> systemctl start slurmd
```
