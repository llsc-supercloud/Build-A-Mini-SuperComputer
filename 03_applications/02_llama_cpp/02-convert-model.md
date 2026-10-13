# Convert the model weights to GGUF format

Llama.cpp works with models in the GGUF format.

Download packages required to do the Huggingface (HF) model weights to GGUF conversion.

```
#  Need Pytorch, sentencepiece and transformers to do conversion.
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
pip install transformers
pip install sentencepiece
```
Run the script to convert the HF to FP16 GGUF format. 

```
# Convert model weights to GGUF floating point 16.
python llama.cpp/convert_hf_to_gguf.py ./tinyllama --outfile tinyllama/tinyllama-1.1B-Chat-v1.0.gguf --outtype f16
```

Quantize from FP16 to Q4_K_M ( 4-bit, K grouped quantization with scale/zero point, M medium precision).

```
llama-quantize tinyllama/tinyllama-1.1B-Chat-v1.0.gguf tinyllama/tinyllama-1.1B-Chat-v1.0_Q4_K_M.gguf Q4_K_M
```