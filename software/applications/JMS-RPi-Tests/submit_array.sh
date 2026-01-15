#!/bin/bash

#SBATCH --array=0-3

source mri_venv/bin/activate

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT

python3 MultipleSliceRatBrain_t_Test_array.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
