## Quantum Chemistry Benchmarking Tutorial using PySCF ##

**Objectives**
* Run a serial job to calculate the total energy of graphene.
* Determine the kinetic energy cutoff, kpoints, and threads based on their performance


**Overview of Benchmarking steps**
1. Determine the kinetic energy cutoff that balances wall time performance and the converged self-consistent field energy (scf)

2. Determine the number of kpoints that balances the converged scf energy with the wall time

3. Determine the number of threads that improves the wall time for the scf calculation


**Quantum Chemistry Computational Overview**

Quantum chemistry is a field that focuses determining chemical, molecular, and magnetic propertiesof materials using first principles. Density functional theory is one of many methods used to Kohn-Sham equations to calculate the electronic structure of materials, semiconductors and insulators in particular. It is a method that transforms a number of electrons to an electron density problem. 

In this case, this uses the self-consistent field method in which the electronic structure is calculated using an iterative method that solves for the Hamiltonian. 

----------
### Instructions ###

**Serial Test**
1. Review submit_serial.sh script and edit the --cpus-per-task based on the number of cores on the node.

2. Review dft_serial.py script and edit the cell.max_memory() (in MB) based on the amount of hardware RAM that it is permitted to use per process. 
    
    * If this is not set, then it will most likely fail with an out-of-memory error. 

3. Run the submit_serial.sh.  You will find the original script, information on the unit cell, along with the HOMO (highest occupied molecular orbital) and LUMO (lowest unoccupied molecular orbital) .
    
    * The SCF energy which will show whether it has converged 
    * You can also review the out/dft_serial-<job-id>.out to determine whether the SCF calculation converged. 

4. Also note that, if you've uncommented the code blocks that prints the verbose output, review the log in the log/ subdirectory.in the gto.Cell(), verbose = 4, dumps the above output. If you need to debug, you can set it to verbose = 5, otherwise, you can set it to a lower value to print less output.


***Visualizing Molecular Orbitals***

To plot the molecular orbital energies, you need to uncomment the Molecular Orbitals
code blocks towards the end of the dft_serial.py script. 
The orbital energies, the highest occupied molecular orbitals or HOMO, which are the valence electrons, and the lowest unoccupied molecular orbitals or LUMO, which are the energy levels the electrons hop to when excited, will be printed. 

To view them, you will need to download and install a program such as [Avogadro2](https://avogadro.cc/install/index.html) or [JMol](https://jmol.sourceforge.net/). An example molden file is currently saved in the data subdirectory. 

---------------------------------------
**Benchmark the Kinetic Energy Cutoff**

1.  Review  *submit_kpt.sh*  and edit the` --cpus-per-task` based on the number of cores on the node

2. Edit *dft_ke_cutoff_benchmark.py* with the following:

    * ke_cutoff: Enter the list of integers to benchmark. Note that the larger the integer, the more memory required to finish the SCF calculation.

3. Check the cell.max_memory() in dft_ke_cutoff_benchmark.py to ensure that the correct amount of RAM (in MB) is set, otherwise, you may experience out of memory errors.

4. Submit the submit_ke_cutoff.sh. This will run the SCF calculation for each kinetic energy cutoff and prints the results: kpoints, threads, converged scf energy, total energy, and wall time

5. Plot a wall time versus kinetic energy cutoff graph to determine the highest kinetic energy cutoff that does not cause a speed down.

----------------------------  
**Benchmark the Kpoint Mesh**

1. Review  *submit_kpt.sh*  and edit the` --cpus-per-task` based on the number of cores on the node

2. Edit *dft_kpoints_benchmark.py* with the following:

    * ke_cutoff: Enter the result from step 2 under the Benchmarking section

    * kpt_mesh: Enter the list of integers to benchmark. Note that the larger the integer, the more memory required to finish the SCF calculation.

    * cell.max_memory(): Ensure that the correct amount of RAM (in MB) is set, otherwise, you may experience out of memory errors.

3. Submit the submit_kpt.sh. This will run the SCF calculation for each kpoint mesh and prints the results: kpoints, threads, converged scf energy, total energy, and wall time

4. Plot a wall time versus kpoints graph to determine the highest kpoint value that does not cause a speed down.

-----------------------------
**Benchmark the Thread Count**
1. Review  *submit_threaeds.sh*  and edit the` --cpus-per-task` based on the number of cores on the node

2. Edit *dft_threads_benchmark.py* with the following:

    * ke_cutoff: Enter the result from step 2 under the Benchmarking section
    * kpt_mesh: Enter the result from step 3 under the Benchmarking section
    * cell.max_memory(): Ensure that the correct amount of RAM (in MB) is set, otherwise, you may experience out of memory errors.

3. Submit the submit_threads.sh. This will run the SCF calculation for each kpoint mesh and prints the results: kpoints, threads, converged scf energy, total energy, and wall time

4. Plot a wall time versus threads graph to determine the threads that does not cause a speed down.