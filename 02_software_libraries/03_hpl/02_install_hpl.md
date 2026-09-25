# HPL - High Performance Linpack

Do the following steps on the headnode.

1. Download HPL source code to /home/gridsan/software

```
  cd /home/gridsan/software
  git clone https://github.com/icl-utk-edu/hpl.git
```

2. Set PATH to point at mpicc compiler

MPICC is in OpenMPI-5.0.10 bin directory.

```
  export PATH=/home/gridsan/software/openmpi-5.0.10/bin:$PATH
```

3. Set LD_LIBRARY_PATH to point at openmpi and blas

```
  export LD_LIBRARY_PATH=/home/gridsan/software/openmpi-5.0.10/lib:$LD_LIBRARY_PATH
  export LD_LIBRARY_PATH=/home/gridsan/software/openblas/usr/lib/aarch64-linux-gnu/openblas-openmp:$LD_LIBRARY_PATH

```
4.  Modify Makefile

Generate Make.rpi from template Makefile. Template files are found in the setup directory.

```
  cd hpl
  cp setup/Make.HPUX__FBLAS ./Make.rpi
```

The following illustrate the variables to modify in Make.rpi

```
ARCH = rpi 
TOPdir = /home/gridsan/software/hpl 
MPIdir = /home/gridsan/software/openmpi-5.0.10
MPIplat = $(MPIdir)
MPIlib = $(MPIdir)/lib/libmpi.la
BLASlib = -L/home/gridsan/software/openblas/usr/lib/aarch64-linux-gnu/openblas-openmp -lblas –lopenblas –lm -lgomp
 
HPL_OPTS = -DHPL_CALL_CBLAS -I/home/gridsan/software/openblas/usr/include/aarch64-linux-gnu/openblas-openmp 
 
CC = mpicc 
 
CCFLAGS = $(HPL_DEFS) -O2 
 
LINKER = mpicc 
```

5. Build HPL
Compile HPL source code using `make`.

```
  make arch=rpi
```