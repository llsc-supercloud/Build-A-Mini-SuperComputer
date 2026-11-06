#!/bin/bash
#SBATCH --job-name=llama-cpp-server
#SBATCH --output %j.out
#SBATCH --partition=pi4
#SBATCH -N 1

## This batch script to start the  llama-server on a single node
## You may have to make edits to certain variables PATH, MODELPATH.

export LLAMACPP_PATH=/home/gridsan/software/llama.cpp
export LLAMABIN=$LLAMACPP_PATH/build/bin
export PATH=$LLAMABIN:$PATH

source /etc/profile
export LD_LIBRARY_PATH=/home/gridsan/software/openblas/usr/lib/aarch64-linux-gnu/openblas-openmp:$LD_LIBRARY_PATH

MASTER_HOST=$(hostname -s)
MASTER_PORT=8080
echo "LLAMA.CPP NODE NAME: " $MASTER_HOST
echo "LLAMA.CPP PORT: " $MASTER_PORT

# Run llama-server on MASTER_HOST
MODELPATH="$HOME/tinyllama/tinyllama-1.1B-chat-v1.0_Q4_K_M.gguf"
srun --nodelist=$MASTER_HOST --ntasks=1 ${LLAMABIN}/llama-server -m $MODELPATH \
  --host 0.0.0.0 --port $MASTER_PORT \
  --threads 1 \
  --cache-type-k q8_0 \
  --cache-type-v q8_0 \
  --spec-draft-type-k q8_0 \
  --spec-draft-type-v q8_0 \
  --ctx-size 2048
