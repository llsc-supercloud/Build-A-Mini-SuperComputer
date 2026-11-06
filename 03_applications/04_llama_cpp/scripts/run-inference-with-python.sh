#!/bin/bash
USAGE="$0 <SERVER> <PORT>"
[[ $# -eq 2 ]] && NODE=$1 && PORT=$2 || echo $USAGE
export PATH=/home/gridsan/software/miniforge3/bin:$PATH
NODE=$1
PORT=$2

python -u llama_inf_client.py -h $NODE -p $PORT