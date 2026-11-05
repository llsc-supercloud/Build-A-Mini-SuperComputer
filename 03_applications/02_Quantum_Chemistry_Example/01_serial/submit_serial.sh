#!/bin/bash
#SBATCH --job-name=dft_serial
#SBATCH --output=out/dft_serial-%j.out
#SBATCH --cpus-per-task=4
#SBATCH --ntasks=1
#SBATCH --nodes=1


# The following Path on Raspberry Pi cluster to use the conda environment
export PATH=/home/gridsan/software/miniconda3/bin:$PATH


export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK


python dft_serial.py 
    
