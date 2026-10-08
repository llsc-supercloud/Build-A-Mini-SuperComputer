# OpenMPI

OpenMPI is an open source implementation of Message Passing Interface (MPI).  MPI is a communications layer to connect multiple application processes across multiple devices (CPUs, GPUs, nodes) in parallel computing.

# Build OpenMPI from source code

### Downloaad
`curl -L -o openmpi-5.0.10.tar.gz  https://download.open-mpi.org/release/open-mpi/v5.0/openmpi-5.0.10.tar.gz`

### Configure
`./configure --prefix=/home/gridsan/software/openmpi-5.0.10 --enable-shared=yes --disable-rsmi`

- The --prefix option sets the installation directory of the software.

### Make
- Compile the software
`make -j 2 all`
- Install the software to directory set by the **configure** step (see the --prefix option).
`make install`

# Using OpenMPI

OpenMPI-5.0.10 binary executables (eg mpirun) and libraries will be installed in /home/gridsan/software/openmpi-5.0.10.
To use the binary executable, the PATH variable will need to be set for the location of the executables.

`export PATH=/home/gridsan/software/openmpi-5.0.10/bin:$PATH`

In order for applications to use OpenMPI, the applications will likely need to know the location of the library. The LD_LIBRARY_PATH environment variable may need to be set to point at the location of the libraries.

`export LD_LIBRARY_PATH=/home/gridsan/software/openmpi-5.0.10/lib:$LD_LIBRARY_PATH`
