# Setup Slurm database daemon

## Configuring Slurmdbd

The mariadb will have to be setup first. 

-   Copy slurmdbd.conf to /etc/slurm on the headnode.  
-   The slurmdbd.conf should be owned by slurm and readable only by slurm.
    To accomplish this, execute the following two lines:
    -   the first changes the owner to slurm
    -   the second sets the permissions
```
   root$> chown slurm:slurm /etc/slurm/slurmdbd.conf
   root$> chmod 600 /etc/slurm/slurmdbd.conf
```

## Slurmdbd configuration 
Here is slurmdbd.conf. 

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
