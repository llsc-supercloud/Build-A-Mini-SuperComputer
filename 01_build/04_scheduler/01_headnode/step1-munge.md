# Install Munge

Munge is used for authentication.

## Install munge

Install munge on the headnode and compute nodes

Go to each node and execute the following command to install munge.

```
   root$>  apt install munge -y
```

## Consistent munge keys

Each node MUST have the same munge.key. We will accomplish this by copying the munge key on the headnode
to all of the compute nodes. 

Execute the following commands, as root, to copy the munge.key from the headnode to each compute node and 
restart the munge daemon.  The example below is for node1.

```bash
   # From headnode, run the following scp and ssh commands. 
   root$>  scp /etc/munge/munge.key root@node1:/etc/munge/
   root$>  ssh root@node1 "systemctl restart munge"
```

Repeat step 2 for each compute node.


## Testing Munge

We recommend a sanity check to confirm that munge key had been copied correctly to each compute node.

From the headnode, run the following command to confirm that the node can decode the munge key

```bash
# Test node1 can decode the munge key sent by the headnode
root@headnode$> munge –n | ssh root@node1 unmunge

```

Repeat for each node.


### Troubleshooting munge
 - The munge.key should be owned by munge
   - To change owner `chown munge:munge munge.key`

 - The munge.key should be readable by  munge only.
   - To change permission  `chmod 600 munge.key`
