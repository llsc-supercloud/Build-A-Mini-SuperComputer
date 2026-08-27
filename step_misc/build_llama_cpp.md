# Building llama.cpp

## Download llama.cpp
  - Use `git clone` to download the llama.cpp repo to /home/gridsan/software.

```bash
  cd /home/gridsan/software
  git clone https://github.com/ggml-org/llama.cpp.git
```


## Build llama.cpp

  - Set `-DGGML_BLAS=ON` and `-DGGML_BLAS_VENDOR=OpenBLAS` to use OpenBLAS for better performance on CPUs.
  - Set `-DGGML_RPC=ON` to build rpc server for distributed inference
  - Following example will build artifacts in the _build_ directory.

```bash
  cd llama.cpp
  cmake -B build -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS -DGGML_RPC=ON
  cmake --build build --config Release -j 4

```
