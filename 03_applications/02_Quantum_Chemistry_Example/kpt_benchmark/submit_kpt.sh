#!/bin/bash

#SBATCH --job-name=dft_kpt
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --output=out/kpt_results_%j.log
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


KPOINT_LIST=(1 2 4)
KE_CUTOFF=(200)

echo "=========================================================================="
echo "KPOINTS  |  CONVERGED  |  KE_CUTOFF  |  TOTAL ENERGY (Ev)  |  WALLTIME(s)"
echo "========================================================================="

# this is the mapper 
for KPT in "${KPOINT_LIST[@]}"
do
    export KE_CUTOFF_VALUE=$KE_CUTOFF
    export KPT_MESH="$KPT"

    python /home/gridsan/landerson/pyscf_proj/kpt_benchmark/dft_kpoints_benchmark.py $KPT_MESH $KE_CUTOFF_VALUE
    # python /path/to/kpt_benchmark/dft_kpoints_benchmark.py $KPT_MESH $KE_CUTOFF_VALUE

done

echo "===================="
echo " Benchmark Complete."
echo "===================="

