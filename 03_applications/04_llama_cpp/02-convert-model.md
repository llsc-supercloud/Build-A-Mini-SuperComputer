# Convert the model weights to GGUF format

Llama.cpp works with models in the GGUF format.

Download packages required to do the Huggingface (HF) model weights to GGUF conversion.

As admin install the pytorch, transformer and sentencepiece to /home/gridsan/software/miniforge3.

```
# Install as admin
#  Need Pytorch, sentencepiece and transformers to do conversion.
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
pip install transformers
pip install sentencepiece
```

Do this as a user, not admin. 
Run the script to convert the HF to FP16 GGUF format. 

```
# Convert model weights to GGUF floating point 16.
python /home/gridsan/software/llama.cpp/convert_hf_to_gguf.py ./tinyllama --outfile tinyllama/tinyllama-1.1B-chat-v1.0.gguf --outtype f16
```

Quantize from FP16 to Q4_K_M ( 4-bit, K grouped quantization with scale/zero point, M medium precision).

```
export PATH=/home/gridsan/software/llama.cpp/build/bin:$PATH
llama-quantize tinyllama/tinyllama-1.1B-chat-v1.0.gguf tinyllama/tinyllama-1.1B-chat-v1.0_Q4_K_M.gguf Q4_K_M
```