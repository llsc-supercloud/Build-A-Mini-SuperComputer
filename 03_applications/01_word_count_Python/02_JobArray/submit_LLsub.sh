#!/bin/bash

# Set PATH to location of python
MFORGE3_PATH=/home/gridsan/software/miniforge3
export PATH=$MFORGE3_PATH/bin:$PATH

# Run with: LLsub ./submit_LLsub.sh [1,4,1]

echo "My task ID: " $LLSUB_RANK
echo "Number of Tasks: " $LLSUB_SIZE


python top5each.py $LLSUB_RANK $LLSUB_SIZE

