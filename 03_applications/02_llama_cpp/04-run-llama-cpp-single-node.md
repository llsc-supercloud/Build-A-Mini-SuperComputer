# Run llama.cpp server for inference

This is an example of running llama.cpp on a single node.
Here we use the TinyLlama-1.1B-Chat-v1.0 model which downloaded, converted the GGUF format and quantized to 4-bit.

NOTE: These scripts should be from your user account, not admin or root.

## Start the  llama.cpp server

The following is a sbatch script to start the  llama-server on single node.
See script `batch-single-server.sh`.

```bash
#!/bin/bash
#SBATCH --job-name=llama-cpp-server
#SBATCH --output %j.out
#SBATCH --partition=pi4
#SBATCH -N 1

## Set PATH
export LLAMACPP_PATH=/home/gridsan/software/llama.cpp
LLAMABIN=$LLAMACPP_PATH/build/bin
export PATH=$LLAMABIN:$PATH

source /etc/profile
export LD_LIBRARY_PATH=/home/gridsan/software/openblas/usr/lib/aarch64-linux-gnu/openblas-openmp:$LD_LIBRARY_PATH

MASTER_HOST=$(hostname -s)
MASTER_PORT=8080
echo "LLAMA.CPP NODE NAME: " $MASTER_HOST
echo "LLAMA.CPP PORT: " $MASTER_PORT


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
  --ctx-size 2048

```

## Test inference


The following uses the Linux `curl` command to send a request to the inference server. 
See the bash script run-inference-with-curl.sh. The run-inference-with-curl.sh script can be run on the headnode.

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

The python script _llama_inf_client.py_ is client code that has hard-coded query to pass to the LLM.
To run the script,

```
python llama_inf_client.py -h node1 -p 8080
```

## Run the llama.cpp server on single node (non-distributed)

```
 LLsub ./batch-single-server.sh
```