#!/bin/bash

# Set PATH to location of python
MFORGE3_PATH=/home/gridsan/software/miniforge3
export PATH=$MFORGE3_PATH/bin:$PATH

# Slurm sbatch options
#SBATCH -o top5norm_MapReduce.log-%j
#SBATCH -n 4


# Call your script as you would from the command line
mpirun python top5norm_MapReduce.py
