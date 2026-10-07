# How to run the helloworld mpi python test code


```bash
admin@headnode$> export PATH=/home/gridsan/software/miniforge3/bin:$PATH
admin@headnode$> export PATH=/home/gridsan/software/openmpi-5.0.10/bin:$PATH
admin@headnode$> export LD_LIBRARY_PATH=/home/gridsan/software/openmpi-5.0.10/lib:$LD_LIBRARY_PATH

admin@headnode$>  mpirun -n 2 python hello_world_mpi.py
```