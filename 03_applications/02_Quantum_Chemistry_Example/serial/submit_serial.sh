#!/bin/bash
#SBATCH --job-name=dft_serial
#SBATCH --output=out/dft_serial-%j.out
#SBATCH --cpus-per-task=48
#SBATCH --ntasks=1
#SBATCH --nodes=1

# load SuperCloud modules
source /etc/profile 
module purge
module load conda/Python-ML-2026a-pytorch 

# Uncomment the following Path on Raspberry Pi cluster to use the conda environment
# export PATH=/home/gridsan/miniconda3/bin:$PATH

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK

KE_CUTOFF=200

export KE_CUTOFF=$KE_CUTOFF
python dft_serial.py $KE_CUTOFF
    
