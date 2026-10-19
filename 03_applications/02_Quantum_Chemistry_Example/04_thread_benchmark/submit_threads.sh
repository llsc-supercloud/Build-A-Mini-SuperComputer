#!/bin/bash

#SBATCH --job-name=dft_threads
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --output=out/threads_results_%j.log
#SBATCH --nodes=1


# for reuthernet
export PATH=/home/gridsan/software/miniconda3/bin:$PATH
# export LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH

python dft_threading_benchmark.py


