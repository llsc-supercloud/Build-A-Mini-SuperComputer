# Build llama.cpp

## Download llama.cpp

```
git clone https://github.com/ggml-org/llama.cpp
```

## Build

```
cd llama.cpp
cmake -B build -DGGML_RPC=ON -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release

```

