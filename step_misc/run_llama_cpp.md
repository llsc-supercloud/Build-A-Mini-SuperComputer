# Run llama server for inference on multiple nodes

RPC is used to achieve distributed inference across multiple nodes.

Following example uses the TinyLlama-1.1B-Chat-


## Download TinyLlama-1.1B-Chat from Huggingface

  - Download model and weights in original file structure using `--local-dir` option.

```bash
  ## The following hf download command is similar to this git clone command.
  ## git clone https://huggingface.co/TinyLlama/TinyLlama-1.1B-Chat-v1.0
  hf download TinyLlama/TinyLlama-1.1B-Chat-v1.0 --local-dir $HOME/tinyllama-hf
```


## Convert Huggingface model to GGUF format to use in llama.cpp

Convert Huggingface model to the GGUF format in floating point 16 precision.

```bash
  python convert_hf_to_gguf.py $HOME/tinyllama-hf/ --outfile $HOME/TinyLlama/TinyLlama-1.1B-Chat-v1.0.gguf --outtype f16
```

##  Quantize the model to 4-bit 

Quantize FP16 model to 4-bit integer.
Quantize methods:  
  - Q4_K_M - 4-bit but mixed precision in some layers
  - Q4_0 -  all layers in 4-bit


```bash
  cd llama.cpp/build/bin
 ./llama-quantize $HOME/TinyLlama/TinyLlama-1.1B-Chat-v1.0.gguf $HOME/TinyLlama/tinyllama-1.1B-chat-v1.0-Q4_0.gguf Q4_0
```

## Run the rpc server and llama server

The bash job script for running the rpc servers and llama server to serve the TinyLlama model.

```bash
#!/bin/bash
#SBATCH --job-name=rpc-server
#SBATCH --output %j.out
#SBATCH --partition=pi4
#SBATCH -N 3
export LLAMACPP_PATH=/home/gridsan/software/llama.cpp
LLAMABIN=$LLAMACPP_PATH/build/bin
export PATH=$LLAMACPP_PATH/build/bin:$PATH

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
echo $NODELIST
srun --nodes=${worker_num} --ntasks=${worker_num} --exclude=$MASTER_HOST ${LLAMABIN}/rpc-server -c -p $PORT_NUM -H 0.0.0.0 -t 4 &

# Run llama-server
MODELPATH="$HOME/TinyLlama/tinyllama-1.1B-chat-v1.0-Q4_0.gguf"
srun --nodelist=$MASTER_HOST --ntasks=1 ${LLAMABIN}/llama-server -m $MODELPATH \
  --host 0.0.0.0 --port $MASTER_PORT \
  --threads 4 \
  --cache-type-k q4_0 \
  --cache-type-v q4_0 \
  --spec-draft-type-k q4_0 \
  --spec-draft-type-v q4_0 \
  --ctx-size 4096  --rpc $NODELIST
```

##  Simple test script using curl

```bash
#!/bin/bash

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