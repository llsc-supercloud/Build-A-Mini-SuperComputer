# How to run the helloworld mpi python test code on the headnode

```bash
admin@headnode$> export PATH=/home/gridsan/software/miniforge3/bin:$PATH
admin@headnode$> export PATH=/home/gridsan/software/openmpi-5.0.10/bin:$PATH
admin@headnode$> export LD_LIBRARY_PATH=/home/gridsan/software/openmpi-5.0.10/lib:$LD_LIBRARY_PATH

admin@headnode$>  mpirun -n 2 python hello_world_mpi.py
```


# Run as batch job

Here is batch job script "batch.sh"

```bash
#!/bin/bash
#SBATCH --job-name=helloworld
#SBATCH --partition=pi4
#SBATCH -N 4
#SBATCH --ntasks=4

export PATH=/home/gridsan/software/miniforge3/bin:$PATH
export PATH=/home/gridsan/software/openmpi-5.0.10/bin:$PATH
export LD_LIBRARY_PATH=/home/gridsan/software/openmpi-5.0.10/lib:$LD_LIBRARY_PATH

mpirun -np ${SLURM_NTASKS} python hello_world_mpi.py

```
The permissions on the script should read-write-executable

`chmod 755 batch.sh`

To run, use LLsub

`LLsub batch.sh`