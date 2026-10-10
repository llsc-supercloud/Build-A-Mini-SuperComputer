## Quantum Chemistry Benchmarking Tutorial using PySCF

**Objectives**
* Build an crystal system
* Calculate the electronic structure of 2D graphene
* Determine the kinetic energy cutoff, kpoints, and threads based on their performance


**Overview of Benchmarking steps**
1. Determine the kinetic energy cutoff that balances wall time performance and the converged self-consistent field energy (scf)
2. Determine the number of kpoints that balances the converged scf energy with the wall time
3. Determine the number of threads that improves the wall time for the scf calculation


**Quantum Chemistry Computational Overview**
Quantum chemistry is a field that focuses determining chemical, molecular, and magnetic properties
of materials using first principles. Density functional theory is one of many methods used to  Kohn-Sham equations to calculate the electronic structure of materials, semiconductors and insulators in particular. It is a method that transforms a 3N dimension for N number of electrons to an electron density problem. In this case, this uses the self-consistent field method in which the electronic structure is calculated using an iterative method that solves for the Hamiltonian. 


**Instructions**
1. Serial
----------
* Review submit_serial.sh script and edit the --cpus-per-task based on the number of cores on the node.
* Review dft_serial.py script and edit the cell.max_memory() (in MB) based on the amount of hardware RAM that it is permitted to use per process. 
    * If this is not set, then it will most likely fail with an out-of-memory error. 
* Run the submit_serial.sh review the log in the log/ subdirectory. You will find the original script, information on the unit cell, along with the HOMO (highest occupied molecular orbital) and LUMO (lowest unoccupied molecular orbital) that can be plotted using [Avogadro2](https://www.openchemistry.org/projects/avogadro2/).
    * Note the SCF energy which will show whether it has converged 
    * You can also review the out/dft_serial-<job-id>.out to determine whether the SCF calculation converged. 
* Also note that in the gto.Cell(), verbose = 4, dumps the above output. If you need to debug, you can set it to verbose = 5, otherwise, you can set it to a lower value to print less output.

2. Benchmark the Kinetic Energy Cutoff
---------------------------------------
* Review submit_ke_cutoff.sh script and:
    - edit the --cpus-per-task based on the number of cores on the node.
    - in the submit_ke_cutoff.sh, enter 4 different KE cutoff integers in the KE_CUTOFF_LIST 
* Check the cell.max_memory() in dft_ke_cutoff_benchmark.py to ensure that the correct amount of RAM (in MB) is set, otherwise, you may experience out of memory errors.
* Submit the submit_ke_cutoff.sh. This will run the SCF calculation for each kinetic energy cutoff and prints the results: kpoints, converged scf energy, total energy, and wall time
    * Determine the local minima that balances between kinetic energy cutoff and wall time 
    
3. Benchmark the Kpoint Mesh
----------------------------
* Review dft_serial.sh script and:
    - edit the --cpus-per-task based on the number of cores on the node
    - in the submit_kpt.sh, enter 4 integer kpoint values in the KPOINT_LIST
* Check the cell.max_memory() in dft_ke_cutoff_benchmark.py to ensure that the correct amount of RAM (in MB) is set, otherwise, you may experience out of memory errors.
* Submit the submit_kpt.sh. This will run the SCF calculation for each kpoint mesh and prints the results: kpoints, converged scf energy, total energy, and wall time
* Determine the local minima that balances between kpoint mesh and wall time 

4. Benchmark the Thread Count
-----------------------------
* In the submit_threads.sh, enter 3 or 4 integers in the THREAD_LIST
* Check the cell.max_memory() in dft_threading_benchmark.py to ensure that the correct amount of RAM (in MB) is set, otherwise, you may experience out of memory errors.
* Submit the submit_threads.sh. This will run the SCF calculation for each kpoint mesh and prints the results: kpoints, converged scf energy, total energy, and wall time
* Determine the number of threads that balances the performance via the wall time and the number of threads
