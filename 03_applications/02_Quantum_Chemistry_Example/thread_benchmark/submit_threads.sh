#!/bin/bash

#SBATCH --job-name=dft_threads
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --output=out/threads_results_%j.log
#SBATCH --nodes=1
#SBATCH --exclusive

export LD_LIBRARY_PATH=/state/partition1/llgrid/pkg/conda/python-ML-2026a-pytorch/lib:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH


# load modules
source /etc/profile 
module purge
module load conda/Python-ML-2026a-pytorch

# for reuthernet
# export PATH=/home/gridsan/miniconda3/bin:$PATH

# THREAD_LIST=(1)
THREAD_LIST=(1 2 4)
KE_CUTOFF=(200)
KPT=(1)


echo "=========================================================================="
echo "KPOINTS  |  CONVERGED  |  KE_CUTOFF  |  TOTAL ENERGY (Ev)  |  WALLTIME(s)"
echo "=========================================================================="

# this is the mapper 
for THREADS in "${THREAD_LIST[@]}"
do
    export KE_CUTOFF=$KE_CUTOFF
    export KPT_MESH="$KPT"
    export OMP_NUM_THREADS=$THREADS
    export OPENBLAS_NUM_THREADS=$THREADS
    export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK

    python /home/gridsan/landerson/pyscf_proj/thread_benchmark/dft_threading_benchmark.py $KPT_MESH $KE_CUTOFF
    # python /path/to/thread_benchmark/dft_threading_benchmark.py $KPT_MESH $KE_CUTOFF_VALUE

done

echo "====================="
echo " Benchmark Complete."
echo "====================="



