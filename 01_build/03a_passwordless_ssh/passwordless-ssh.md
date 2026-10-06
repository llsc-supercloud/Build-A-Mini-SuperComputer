
# Setting up Passwordless ssh on the cluster

Supercomputing clusters require passwordless ssh keys so that when you run applications, the applications can communicate without you going to each node and starting up a process

SSH keys include
-   Private key  that resides in .ssh on your “home” computer,  no file extension
-   Public key 
    -   Same name as the private key with the extension ‘.pub’. (Microsoft systems confuse this with Publisher files – be aware)
    -   Used and shared so that you have passwordless access to systems where you have shared it.

!!! danger "Be Careful with ssh Keys"
           NEVER share your private key!  If you share by mistake, create a new set of keys

## Creating the Passwordless ssh key

Creation is fairly easy:
-   The command for generating ssh keys is 
```
   ssh-keygen
```
-   First create the ssh-keys root on  the headnode: sudo su –
-   Execute/run the command ssh-keygen
-   You will be asked where to save the keys:  hit return to accept the default (.ssh)
-   You will be asked to enter a passphrase: hit return for passwordless
-   You will be asked to re-enter the passphrase: hit return again to accept passwordless 
-   You should see a message that says:
```
   Your identification has been saved in /root/.ssh/id_ed25519
   Your public key has been saved in /root/.ssh/id_ed25519.pub
```
Along with a key fingerprint and randomart

## Sharing the keys across the cluster
Now that you have a private-public ssh key pair on the headnode, you need to copy the keys to the nodes in the system so that you can access nodes seamlessly:
To copy the keys to each node use the command 
```
  ssh-copy-id root@<nodeName>
```

## Testing passwordless ssh
To test:
-   ssh to each  node 
-   confirm that you can connect without a password

## Complete the process
Copy the keys to each node of the cluster and confirm that you can ssh to the node passwordlessly

Do this as `root` and as `admin`
