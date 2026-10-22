#!/bin/bash

#SBATCH --job-name=dft_kpt
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --output=out/kpt_results_%j.out
#SBATCH --nodes=1

source /etc/profile
module load conda/Python-ML-2026a-pytorch

# for reuthernet
# export PATH=/home/gridsan/software/miniconda3/bin:$PATH

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK


python dft_kpoints_benchmark.py 

