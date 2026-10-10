"""
-------------------
KPOINT BENCHMARKING
-------------------
This module will help determine the minimum number of kpoints (kpt)
needed to balance performance (wall time) with numerical accuracy.

The thread count (threads) and kinetic energy (ke_cutoff) 
is held FIXED for this study.

"""

import numpy as np
import os
import sys
import time
from pyscf.pbc import dft, gto, df
from pyscf import lib
from pathlib import Path

'''
--------------------------------
Set Calculation Parameters
-------------------------------
Get the kinetic energy cutoff, kpoints, and number of threads
from the command line arguments.
'''

### BENCHMARK PARAMETER ###
# Get k-point mesh to sweep, in increasing density, from the command line argument
# Note: Keep list modest for a Raspberry Pi cluster -- k-point cost grows roughly linearly to
# super-linearly, and RPi nodes have limited RAM.
try: 
    # kpt = 1
    kpt = sys.argv[1]  # Update the KPOINT_LIST in the submit_kpt.sh
except IndexError:
    raise ValueError("Please provide a k-point mesh as a command line argument")



# Get the kinetic energy cutoff from the command line argument
# Note: This should be updated based on the results from the ke_cutoff benchmark 
try:
    # for testing purposes, we can set the kinetic energy cutoff to a fixed value
    # ke_cutoff = 200 
    ke_cutoff = sys.argv[2]  # Get the kinetic energy cutoff from the command line argument
   
except IndexError:
    raise ValueError("Please provide a kinetic energy cutoff as a command line argument")



# Get the number of threads from the command line argument
try:
    threads = int(os.environ.get("OMP_NUM_THREADS", 1))
except ValueError as e:
    raise RuntimeError(f"Invalid OMP_NUM_THREADS environment variable: {e}")

# Prints the number of threads PySCF is using for the calculation. 
# This is useful for debugging and performance tuning.
print(lib.num_threads())

# Name of output file where the results will be saved.
try:
    path = Path.cwd() / "log"
except ValueError:
    print("Invalid file path. Please check the file path.")
    sys.exit(1)

# This is the name of the calculation being performed. It is used to name the output file where the results will be saved.
calc = path / f'dft_kpt_{kpt}'

# Convergence tolerance (Hartree) used to flag when successive energies
# have stopped changing meaningfully -- mirrors the "energy convergence
# threshold" concept from the QE exercise.
convergence_total_hartree = 1e-4


'''
--------------------------
Build a Crystal Unit Cell
--------------------------
We define the crystal structure of the material being studied. 
The unit cell is built using the PySCF library's gto.Cell class, which allows us to specify the atomic positions, 
basis functions, pseudopotentials, and lattice vectors for the crystal. The output file name is also specified here.

'''
# Build the unit cell
cell = gto.Cell(

    # Add the atoms to the unit cell at specific Cartesian coordinates
    atom =  '''
        C 0.0 0.0 0.0
        C 0.0 1.42 0.0
    ''',

    # Specify Gaussian-type orbital as the basis function for periodic calculations
    basis = 'gth-dzvp',

    # Specify pseudopotentials that describes the exchange-correlation interactions between electrons
    pseudo = 'gth-lda',

    # Lattice vectors defines the positions of the atoms inside the unit cell 
    a =  [[2.46, 0.0, 0.0],
        [-1.23, 2.13, 0.0],
        [0.0, 0.0, 20.0]
    ],

    # Name of the output file where the verbose calculations will be saved
    output = f'{calc}.log',

    verbose = 4
)



'''
---------------------------------
Set Calculation Parameters
--------------------------------
These are the "knobs" that can be adjusted to control the 
accuracy and performance of the calculation. This is where the
kpoints (cell.make_kpts) will be benchmarked. 

'''
# Set the maximum memory for the calculation based on the amount of available RAM that can be used during the calculation
# Calculation will fail if it requires more memory than this
# Sets a 3GB limit per process for Rasberry Pi
cell.max_memory = 300 # in MB

# kinetic energy cutoff for the plane-wave basis set which determines accuracy of the calculation
# Note: If you get a warning about the mesh being too small, you can increase the kinetic energy cutoff to improve the accuracy of the calculation.
cell.ke_cutoff = int(ke_cutoff) # update the KPOINT_LIST in the submit_kpt.sh

# Number of dimensions of the crystal. In this case, we are performing a 2D calculation for a graphene sheet.
cell.dimension = 2
cell.build()

# list of k-point meshes to test. The script will perform calculations for 
#each of these meshes and record the CPU time taken for each calculation.
kmesh = cell.make_kpts([1, int(kpt),int(kpt)])

'''
---------------------------
Perform the DFT Calculation
---------------------------
This will perform the DFT calculation that will determine the total energy of the crystal for a specific k-point mesh. 
The calculation is performed using the Kohn-Sham method with a specific exchange-correlation functional (PBE in this case). 
The density fitting method is used to speed up the calculation by approximating the electron density using a set of auxiliary basis functions. 
The AFTDF method is used for this purpose, which is a specific implementation of density fitting for periodic systems. 
The SCF calculation is executed and the CPU time taken for the calculation is recorded. 
'''
# Perform the DFT calculation using the Kohn-Sham method with a specific exchange-correlation functional (PBE in this case).
mf = dft.KRKS(cell,kmesh)
mf.xc = 'pbe'

# The density fitting method is used to speed up the calculation by approximating the electron density using a set of auxiliary basis functions. 
#The AFTDF method is used for this purpose, which is a specific implementation of density fitting for periodic systems.
mf.with_df = df.AFTDF(cell, kmesh)
mf.with_df.coul_poly_cutoff = 2
        
# Execute the SCF calculation (mf.kernel()) and record the CPU time taken for the calculation.
start_time = time.time()
e_tot = mf.kernel()
end_time = time.time()


'''
-------------------------
Collect and Print Results
-------------------------
The wall time taken for the calculation is calculated by subtracting the start time from the end time
The convergence status of the SCF calculation is checked to determine if the calculation converged successfully.
The total energy is converted from Hartree to electron volts (eV) for easier interpretation.
The results of the calculation, including the k-point mesh, number of k-points, wall time, total energy, and convergence status, are printed to the console in a formatted table.
'''
# Save the wall time taken for the calculation.
wall_time = end_time - start_time

# Boolean value that prints whether the scf converged.
converged = mf.converged

# Total energy converted from Hartree to electron volts (eV) for easier interpretation.
e_tot = e_tot * 27.2114

print(f" {kpt} {converged}: {cell.ke_cutoff} {e_tot:.6f} eV {wall_time:.6f} s")
