# PySCF - python module for quantum chemistry

## Install PySCF into the base environment of the miniforge3 installation directory

Set the PATH variable to the location _bin_ directory of the python interpreter.
Also set PATH to the OpenMPI 

```bash
export PATH=/home/gridsan/software/miniforge3/bin:$PATH
export PATH=/home/gridsan/software/openmpi-5.0.10/bin:$PATH
export LD_LIBRARY_PATH=/home/gridsan/software/openmpi-5.0.10/lbb:$LD_LIBRARY_PATH

pip install mpi4py openmpi
pip install psutil
pip install pyscf 

```

## Simple test of mpi4py and the MPI version

```bash 
python -c "from mpi4py import MPI; print(MPI.Get_library_version())"
```

