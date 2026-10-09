#!/bin/bash
#SBATCH --job-name=rpc-server
#SBATCH --output %j.out
#SBATCH --partition=pi4
#SBATCH -N 3

## This batch script to start the rpc-server and llama-server
## You may have to make edits to certain variables.

export LLAMACPP_PATH=/home/gridsan/software/llama.cpp
export LLAMABIN=$LLAMACPP_PATH/build/bin
export PATH=$LLAMABIN:$PATH

source /etc/profile
export LD_LIBRARY_PATH=/home/gridsan/software/openblas/usr/lib/aarch64-linux-gnu/openblas-openmp:$LD_LIBRARY_PATH

MASTER_HOST=$(hostname -s)
MASTER_PORT=8080
echo $MASTER_HOST
let "worker_num=(${SLURM_NNODES} - 1)"
# Listening port  for the RPC server
PORT_NUM=50052

NODELISTS=$SLURM_JOB_NODELIST
echo "SLURM NODELIST =  $NODELISTS"
echo ""
#NODENAMES=$(scontrol show hostnames | tr '\n' ',')
NODENAMES=$( scontrol show hostnames | tr '\n' ',' )
echo $NODENAMES

#  Start the RPC servers on the other compute nodes, not MASTER_HOST
srun --nodes=${worker_num} --ntasks=${worker_num} --exclude=$MASTER_HOST ${LLAMABIN}/rpc-server -c -p $PORT_NUM -H 0.0.0.0 -t 1 &
#Sleep to wait for RPC servers to start up.
sleep 120

RPC_NODELIST=""
# Create a comma-separated list host1:port,host2:port,etc that are running the RPC server
firsttime=1
IFS="," read -r -a nodearray <<< "$NODENAMES"
for i in "${nodearray[@]}"; do
   if [ "$i" != "$MASTER_HOST" ]; then
      if [ -z "$RPC_NODELIST" ] ; then
         RPC_NODELIST+=$i":$PORT_NUM"
      else
         RPC_NODELIST+=","$i":$PORT_NUM"
      fi
   fi
done

echo "RPC host:port list - ${NODELIST}"

# Run llama-server on MASTER_HOST
MODELPATH="$HOME/tinyllama/tinyllama-1.1B-chat-v1.0_Q4_K_M.gguf"
srun --nodelist=$MASTER_HOST --ntasks=1 ${LLAMABIN}/llama-server -m $MODELPATH \
  --host 0.0.0.0 --port $MASTER_PORT \
  --threads 1 \
  --cache-type-k q8_0 \
  --cache-type-v q8_0 \
  --spec-draft-type-k q8_0 \
  --spec-draft-type-v q8_0 \
  --ctx-size 2048  --rpc $RPC_NODELIST 
