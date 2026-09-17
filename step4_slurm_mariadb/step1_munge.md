# Install Munge

Munge is used for authentication.

1. Install munge on the headnode and compute nodes

Go to each node to install munge.

```
   root$>  apt install munge -y
```

2. Copy munge.key to compute nodes.

Each node has to have the same munge.key. Thus copy /etc/munge/munge.key from the headnode to each compute node.
After copying the munge.key, the munged daemon has to be restarted.

```bash
   # From headnode, run the following scp and ssh commands. 
   root$>  scp /etc/munge/munge.key root@node1:/etc/munge/
   root$>  ssh root@node1 "systemctl restart munge"
```
Repeat step 2 for each compute node.

3. Sanity check that munge key had been copied correctly to each compute node.

Run the test from the headnode.

```bash
# Test node1 can decode the munge key sent by the headnode
root@headnode$> munge –n | ssh root@node1 unmunge

```

4. Troubleshooting munge
 - The munge.key should be owned by munge
   - To change owner `chown munge:munge munge.key`

 - The munge.key should be readable by  munge only.
   - To change permission  `chmod 600 munge.key`