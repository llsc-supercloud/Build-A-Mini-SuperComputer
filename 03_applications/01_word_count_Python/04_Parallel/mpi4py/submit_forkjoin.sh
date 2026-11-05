#!/bin/bash

# Slurm sbatch options
#SBATCH -o top5norm_forkjoin.log-%j
#SBATCH -n 4

# Set PATH to location of python
MFORGE3_PATH=/home/gridsan/software/miniforge3
export PATH=$MFORGE3_PATH/bin:$PATH

# Call your script as you would from the command line
mpirun python top5norm_forkjoin.py


