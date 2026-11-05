#!/bin/bash

# Set PATH to location of python
MFORGE3_PATH=/home/gridsan/software/miniforge3
export PATH=$MFORGE3_PATH/bin:$PATH

# Call your script as you would from the command line
python top5norm.py
