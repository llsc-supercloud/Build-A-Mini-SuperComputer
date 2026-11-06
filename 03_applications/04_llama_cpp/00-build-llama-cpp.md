# Build llama.cpp

## Install openssl and libopenblas-dev

As root, install openssl and libopenblas-dev on all nodes as these libraries are needed for building and running.

```bash
apt install -y libssl-dev openssl libopenblas-dev
```

## Download llama.cpp

Download and build llama.cpp as admin. 

```
git clone https://github.com/ggml-org/llama.cpp
```

## Build

Build the code as admin. The following build instructions will build the llama-server and rpc server (plus other binary executables).

```
cd llama.cpp
cmake -B build -DGGML_RPC=ON -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release

```

