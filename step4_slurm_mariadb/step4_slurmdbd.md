# Setup Slurm database daemon

The mariadb will have to be setup first. 
Copy slurmdbd.conf to /etc/slurm on the headnode.  

Here is slurmdbd.conf. The slurmdbd.conf should be owned by slurm and readable only by slurm.

```
### Slurmdbd.conf
AuthType=auth/munge
DbdAddr=headnode
DbdHost=headnode
SlurmUser=slurm
DebugLevel=4
LogFile=/var/log/slurm/slurmdbd.log
PidFile=/var/run/slurmdbd.pid
StorageType=accounting_storage/mysql
StoragePass=llsc-db
StorageUser=slurm
StorageLoc=slurm_acct_db
StoragePort=3306

```

The slurmdbd service will need to be enabled and started 

```bash
  root@headnode$>  systemctl enable slurmdbd
  root@headnode$>  systemctl start slurmdbd
```
