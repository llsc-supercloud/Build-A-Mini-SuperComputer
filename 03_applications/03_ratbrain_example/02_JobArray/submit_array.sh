#!/bin/bash

#SBATCH --array=0-0

export PATH=/home/gridsan/software/miniforge3/bin:$PATH

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT

python3 MultipleSliceRatBrain_t_Test_array.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
