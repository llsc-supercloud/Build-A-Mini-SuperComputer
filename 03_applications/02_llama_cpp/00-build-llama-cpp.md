# Build llama.cpp

## Download llama.cpp

Download and build llama.cpp as admin. 

```
git clone https://github.com/ggml-org/llama.cpp
```

## Build

```
cd llama.cpp
cmake -B build -DGGML_RPC=ON -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release

```

