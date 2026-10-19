#!/bin/bash

#SBATCH --job-name=dft_threads
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --output=out/threads_results_%j.log
#SBATCH --nodes=1

# for SuperCloud
export LD_LIBRARY_PATH=/state/partition1/llgrid/pkg/conda/python-ML-2026a-pytorch/lib:$LD_LIBRARY_PATH

source /etc/profile 
module purge
module load conda/Python-ML-2026a-pytorch

# for reuthernet
# export PATH=/home/gridsan/software/miniconda3/bin:$PATH
# export LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH


python dft_threading_benchmark.py


