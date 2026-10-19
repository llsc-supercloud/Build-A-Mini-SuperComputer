#!/bin/bash

#SBATCH --job-name=dft_ke_cutoff
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --output=out/ke_cutoff_results_%j.out
#SBATCH --nodes=1

# load modules
source /etc/profile 
module purge
module load conda/Python-ML-2026a-pytorch 

# for reuthernet
# export PATH=/home/gridsan/miniconda3/bin:$PATH

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK


python dft_ke_cutoff_benchmark.py


