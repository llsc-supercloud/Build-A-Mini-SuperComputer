# Introduction

Overview:

0.  Install Munge on all nodes
    - Distribute the munge.key from headnode to all compute nodes
1. Setup slurm components on the headnode and compute nodes
  - Install slurmctld on the headnode
  - Install slurmd on the compute nodes
  - Install slurm-client on all nodes
2. Setup the mariadb to keep account of users and jobs.
  - Initialize by running _mariadb-secure-installation_
  - Create database, and user