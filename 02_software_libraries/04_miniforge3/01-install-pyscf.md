# PySCF - Python module for quantum chemistry

## Install PySCF into the base environment of the miniforge3 installation directory

Set the PATH variable to the location _bin_ directory of the python interpreter.  
Also set PATH and LD_LIBRARY_PATH variables to the OpenMPI executables and libraries respectively.  
Use pip to install the packages into the base environment.

```bash
admin@headnode$> export PATH=/home/gridsan/software/miniforge3/bin:$PATH
admin@headnode$> export PATH=/home/gridsan/software/openmpi-5.0.10/bin:$PATH
admin@headnode$> export LD_LIBRARY_PATH=/home/gridsan/software/openmpi-5.0.10/lbb:$LD_LIBRARY_PATH

admin@headnode$> pip install mpi4py openmpi
admin@headnode$> pip install psutil
admin@headnode$> pip install pyscf 

```

## Test PySCF installation
 
This test will print the version of PySCF that was installed.

```bash
admin@headnode$> python -c "import pyscf; print(pyscf.__version__)"
2.14.0
```

## Test of mpi4py installation  and the MPI version

This test will print the name and version of the MPI implementation that was installed. 

```bash 
admin@headnode$> python -c "from mpi4py import MPI; print(MPI.Get_library_version())"

Open MPI v5.0.11, package: Open MPI user@localhost Distribution, ident: 5.0.11, repo rev: v5.0.11rc1, Sep 16, 2026
```

