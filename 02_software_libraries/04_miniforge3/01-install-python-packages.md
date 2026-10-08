# Install Python packages

Python packages can be installed using *mamba* ( which is better and faster than conda) or *pip*. 
For starters, we will use pip to install the following packages into the base environment of our Miniforge3 installation.

 - PySCF - Python module for quantum chemistry
 - Matplotlib - plotting library
 - Mpi4py  - python wrapping for MPI
 - Psutil - system and process utilities

## Installing the packages with pip into the base environment of the miniforge3 installation directory

Set the PATH variable to the location of the python interpreter and pip executables. By setting the PATH, python and pip will know where the base environment is.   
Also set PATH and LD_LIBRARY_PATH variables to the OpenMPI executables and libraries respectively.  
Use pip to install the packages into the base environment.

```bash
admin@headnode$> export PATH=/home/gridsan/software/miniforge3/bin:$PATH
admin@headnode$> export PATH=/home/gridsan/software/openmpi-5.0.10/bin:$PATH
admin@headnode$> export LD_LIBRARY_PATH=/home/gridsan/software/openmpi-5.0.10/lib:$LD_LIBRARY_PATH

admin@headnode$> pip install mpi4py
admin@headnode$> pip install psutil
admin@headnode$> pip install pyscf 
admin@headnode$> pip install matplotlib

```

## Test PySCF installation
 
This test will print the version of PySCF that was installed.

```bash
admin@headnode$> export PATH=/home/gridsan/software/miniforge3/bin:$PATH
admin@headnode$> export PATH=/home/gridsan/software/openmpi-5.0.10/bin:$PATH
admin@headnode$> export LD_LIBRARY_PATH=/home/gridsan/software/openmpi-5.0.10/lib:$LD_LIBRARY_PATH
admin@headnode$> python -c "import pyscf; print(pyscf.__version__)"
2.14.0
```

## Test of mpi4py installation  and the MPI version

This test will print the name and version of the MPI implementation that was installed. 

```bash 
admin@headnode$> export PATH=/home/gridsan/software/miniforge3/bin:$PATH
admin@headnode$> export PATH=/home/gridsan/software/openmpi-5.0.10/bin:$PATH
admin@headnode$> export LD_LIBRARY_PATH=/home/gridsan/software/openmpi-5.0.10/lib:$LD_LIBRARY_PATH
admin@headnode$> python -c "from mpi4py import MPI; print(MPI.Get_library_version())"

Open MPI v5.0.11, package: Open MPI user@localhost Distribution, ident: 5.0.11, repo rev: v5.0.11rc1, Sep 16, 2026
```

