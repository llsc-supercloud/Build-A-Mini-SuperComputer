# Installing Slurm

##  Headnode 
1. Installing slurmctld, slurmdbd, slurm-client

  ` root@headnode$>  apt install slurm-wlm`

2. Install slurm.conf

  - Copy slurm.conf to /etc/slurm
  - Stop and start the slurmctld service

## Compute Nodes

1. Install slurmd and slurm-client

` root@headnode$>  apt install slurmd slurm-client`

2. Put a copy of slurm.conf in /etc/slurm

## Create account on the Slurm db

In slurm jargon, an account is like a group.
Here we add "default_group" using the `saccmgr add account` command.

```text
root@headnode:/etc/slurm# sacctmgr add account default_group Cluster=txpi4 Description="default group" Organization="MITLL"
sacctmgr: error: _open_persist_conn: failed to open persistent connection to host:headnode:6819: Connection refused
sacctmgr: error: Sending PersistInit msg: Connection refused
root@headnode:/etc/slurm# systemctl status slurmdbd
○ slurmdbd.service - Slurm DBD accounting daemon
     Loaded: loaded (/usr/lib/systemd/system/slurmdbd.service; enabled; preset: enabled)
     Active: inactive (dead)
  Condition: start condition unmet at Wed 2026-07-15 13:25:45 EDT; 3h 35min ago
       Docs: man:slurmdbd(8)

Jul 15 13:25:45 headnode systemd[1]: slurmdbd.service - Slurm DBD accounting daemon skipped, unmet condition check Co>
root@headnode:/etc/slurm# systemctl enable slurmdbd
Synchronizing state of slurmdbd.service with SysV service script with /usr/lib/systemd/systemd-sysv-install.
Executing: /usr/lib/systemd/systemd-sysv-install enable slurmdbd
root@headnode:/etc/slurm# systemctl restart slurmdbd
root@headnode:/etc/slurm# sacctmgr add account default_group Cluster=txpi4 Description="default group" Organization="MITLL"
 Adding Account(s)
  default_group
 Settings
  Description     = default group
  Organization    = mitll
 Associations =
  C = txpi4      A = default_group
 Settings
Would you like to commit changes? (You have 30 seconds to decide)
(N/y):
```
## Add user to the Slurm db

```text
root@headnode:~# sacctmgr create user name=cyee account=default_group adminlevel=admin
 Adding User(s)
  cyee
 Settings
  Admin Level     = Administrator
 Associations =
  C = txpi4      A = default_group        U = cyee
Would you like to commit changes? (You have 30 seconds to decide)
(N/y): y
root@headnode:~#
```