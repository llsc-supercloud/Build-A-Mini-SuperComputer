# INSTALLATION of LLGrid Commands

The LLGrid commands consist of the LLsub, LLMapReduce, LLstat, LLkill, LLfree, LLload commands.  
The LLGrid commands are packaged in the a deb file. Each cluster needs it own customized yaml configuration to define the partition and its hardware plus other configuration parameters.

 - llgrid-commands_20260925-1ubuntu1_all.deb
 - txpi4.yml - contains partition and hardware related information and default settings for the commands 
 - llgrid.id - cluster name identifier

1. As root, on each node run the dpkg command to install

At the minimum, the LLGrid commands should be installed on the headnode.

```bash
  root@headnode$>  dpkg -x llgrid-commands_20260225-3ubuntu1_all.deb /
```

The llgrid-commands are installed in /usr/local

The following is a brief overview of  the LLGrid commands directory structure.

```
   /usr/local/
           |_ LLSC/  #  Python scripts and config files
           |_ bin/   #  LLGrid command shell scripts
           |_ sbin/  #  LLGrid system related shell scripts
```

2. On each node, copy txpi4.yml to /usr/local/LLSC/ll_config

```bash
   root@headnode$> cp configs/usr/local/LLSC/ll_config/txpi4.yml /usr/local/LLSC/ll_config/
```

3. The llgrid.id contains the cluster name and should be copied to /etc.

```bash
   root@headnode$> cp configs/etc/llgrid.id /etc/
```

4. Make txpi4.yml and llgrid.id world readable

```bash
   root@headnode$> chmod o+r /usr/local/LLSC/ll_config/txpi4.yml
   root@headnode$> chmod o+r /etc/llgrid.id

```

There is a convenience script - scripts/install-llgrid-commands.sh - that performs all the above steps.
To use the script, do the following as root.

```
cd scripts
./install-llgrid-commands.sh
```

