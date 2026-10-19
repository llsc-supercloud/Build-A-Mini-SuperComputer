#!/bin/bash
#SBATCH --job-name=dft_serial
#SBATCH --output=/home/gridsan/landerson/pyscf_proj/testing_out/dft_serial-%j.out
#SBATCH --cpus-per-task=4
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


python /home/gridsan/landerson/pyscf_proj/01_serial/dft_serial.py 
    
