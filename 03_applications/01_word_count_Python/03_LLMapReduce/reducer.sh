#!/bin/bash

# Set PATH to location of python
MFORGE3_PATH=/home/gridsan/software/miniforge3
export PATH=$MFORGE3_PATH/bin:$PATH

# Call your script as you would from the command line, passing in $1 and $2 as arugments
# Note that $1 and $2 are the arguments passed into this script
python top5overall_reduce.py $1 $2
