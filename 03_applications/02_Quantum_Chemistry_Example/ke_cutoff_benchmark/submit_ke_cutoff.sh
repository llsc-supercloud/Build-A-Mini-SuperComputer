#!/bin/bash

#SBATCH --job-name=dft_ke_cutoff
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --output=out/ke_cutoff_results_%j.out
#SBATCH --nodes=1
#SBATCH --exclusive

# load modules
source /etc/profile 
module purge
module load conda/Python-ML-2026a-pytorch 

# for reuthernet
# export PATH=/home/gridsan/miniconda3/bin:$PATH

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK

# KE_CUTOFF_LIST=(100)
KE_CUTOFF_LIST=(100 200 400)

echo "================================================"
echo "KE_CUTOFF  |  WALLTIME(s)  |  TOTAL ENERGY (Ev)"
echo "================================================"

KPT=1

for KE_CUTOFF in "${KE_CUTOFF_LIST[@]}"
do

    export KE_CUTOFF_VALUE=$KE_CUTOFF
    export KPT_MESH=$KPT

    python /home/gridsan/landerson/pyscf_proj/ke_cutoff_benchmark/dft_ke_cutoff_benchmark.py $KPT_MESH $KE_CUTOFF_VALUE 
done

echo "==================="
echo " Benchmark Complete."
echo "==================="

