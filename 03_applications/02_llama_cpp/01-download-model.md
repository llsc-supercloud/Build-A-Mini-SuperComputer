# Download a Huggingface model

You will need the Huggingface huggingface_hub package for doing downloads.

```
# Install Huggingface repo utilities which are used for create, delete, update and retrieve information from the repos.
export PATH=/home/gridsan/software/miniforge3:$PATH
pip install huggingface_hub
```

# Download with the _hf download_ command

Download the TinyLlama-1.1B-Chat-v1.0 model weights.

```
# Takes about 6 minutes to download from home wifi.
# At LL, it will probably take longer.
hf download TinyLlama/TinyLlama-1.1B-Chat-v1.0  --local-dir ./tinyllama
```

