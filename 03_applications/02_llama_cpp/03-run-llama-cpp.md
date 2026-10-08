# Run llama.cpp server for inference

This is an example of running llama.cpp on a distributed system, ie multiple nodes.
The nodes will be using RPC to communicate with one another.
Here we use the TinyLlama-1.1B-Chat-v1.0 model which downloaded, converted the GGUF format and quantized to 4-bit.

## Start the RPC server and llama.cpp server

The following is a sbatch script to start the rpc-server and llama-server.

```bash
#!/bin/bash
#SBATCH --job-name=rpc-server
#SBATCH --output %j.out
#SBATCH --partition=pi4
#SBATCH -N 3

## Set PATH
export LLAMACPP_PATH=/home/gridsan/software/llama.cpp
LLAMABIN=$LLAMACPP_PATH/build/bin
export PATH=$LLAMABIN:$PATH

source /etc/profile
export LD_LIBRARY_PATH=/home/gridsan/software/openblas/usr/lib/aarch64-linux-gnu/openblas-openmp:$LD_LIBRARY_PATH

MASTER_HOST=$(hostname -s)
MASTER_PORT=8080
echo $MASTER_HOST
let "worker_num=(${SLURM_NNODES} - 1)"
PORT_NUM=50052

NODELISTS=$SLURM_JOB_NODELIST
echo $NODELISTS

#NODENAMES=$(scontrol show hostnames | tr '\n' ',')
echo $NODENAMES
NODENAMES=$( scontrol show hostnames | tr '\n' ',' )
echo $NODENAMES
IFS="," read -r -a nodearray <<< "$NODENAMES"
NODELIST=""
for i in "${nodearray[@]}"; do
   if [ "$i" != "$MASTER_HOST" ]; then
      NODELIST+=$i":$PORT_NUM,"
   fi
done

## Start RPC server on node2 and node3
echo $NODELIST
srun --nodes=${worker_num} --ntasks=${worker_num} --exclude=$MASTER_HOST ${LLAMABIN}/rpc-server -c -p $PORT_NUM -H 0.0.0.0 -t 4 &

# Run llama-server on node1
# q8_0 is supposed to halve the cache memory compared to fp16.
MODELPATH="$HOME/tinyllama/tinyllama-1.1B-chat-v1.0-Q4_K_M.gguf"
srun --nodelist=$MASTER_HOST --ntasks=1 ${LLAMABIN}/llama-server -m $MODELPATH \
  --host 0.0.0.0 --port $MASTER_PORT \
  --threads 1 \
  --cache-type-k q8_0 \
  --cache-type-v q8_0 \
  --spec-draft-type-k q8_0 \
  --spec-draft-type-v q8_0 \
  --ctx-size 2048  --rpc $NODELIST

```

## Test inference

```
curl http://node1:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [
      {
        "role": "system",
        "content": "You are a helpful assistant."
      },
      {
        "role": "user",
        "content": "Why is the sky blue?"
      }
    ],
    "temperature": 0.7,
    "max_tokens": 150
  }'

```
## Another test inference using a python script.

The python script _llama_inf_client.py_ is client code that has hard-code query to pass to the LLM.
To run the script,

```
python llama_inf_client.py -h node1 -port 8080
```