'''
This module is demonstrate an SCF calculation of a crystal for a 
FIXED set of k-point meshes, kinetic energy, and threads using density functional theory.
The results are printed to the console and saved to a log file.
'''

import numpy as np
import os
from pyscf.pbc import dft, gto, df
from pyscf import lib
import time
import sys
from pathlib import Path



'''
--------------------------------
Set Calculation Parameters
-------------------------------
Get the kinetic energy cutoff, kpoints, and number of threads
from the command line arguments
The commented code lines are there for testing during an 
interactive session.
'''

# Get the kinetic energy cutoff from the command line argument
try:
    # ke_cutoff = 200
    ke_cutoff = int(sys.argv[1])
except ValueError:
    print("Invalid kinetic energy cutoff. Please provide a valid integer.")
    sys.exit(1)


 # Get the number of cores allocated for the job from the SLURM environment variable. If not set, default to 1 core.
try:
    num_cores = int(os.environ.get('OMP_NUM_THREADS', 1)) 
    # print(lib.num_threads()) 
except ValueError:
    print("Invalid number of cores. Please provide a valid integer.")
    sys.exit(1)

# Name of output file where the results will be saved.
try:
    path = Path.cwd() / "log"
except ValueError:
    print("Invalid file path. Please check the file path.")
    sys.exit(1)

calc = path / f'dft_serial_{ke_cutoff}'

# Convergence tolerance (Hartree) used to flag when successive energies
# have stopped changing meaningfully -- mirrors the "energy convergence
# threshold" concept from the QE exercise.
convergence_total_hartree = 1e-4


'''
--------------------------
Build a Crystal Unit Cell
--------------------------
Define the crystal structure of the material being studied. 
The unit cell is used to specify the atomic positions, basis functions, 
pseudopotentials, and lattice vectors for the crystal. 
Verbose output is printed to the log file specified in the output parameter.

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
These are the "knobs" that will be adjusted in other scripts to control the accuracy 
and performance of the calculation:

1. cell.ke_cutoff = KE_CUTOFF from KE_CUTOFF_LIST
2. kpt = KPT from KPOINT_LIST
3. num_cores = OMP_NUM_THREADS 
'''
# Set the maximum memory for the calculation based on the amount of available RAM that can be used during the calculation
# Calculation will fail if it requires more memory than this
# Note: this total memory limit is for MIT SuperCloud
# Sets a 3GB limit per process for Rasberry Pi
cell.max_memory = 300 # in MB

# Kinetic energy cutoff for the plane-wave basis set which determines accuracy of the calculation
# Note: If you get a warning about the mesh being too small, you can increase the kinetic energy cutoff to improve the accuracy of the calculation.
cell.ke_cutoff = int(ke_cutoff)

# Number of dimensions of the crystal. 
# In this case, we are performing a 2D calculation for a graphene sheet.
cell.dimension = 2

# This is when the unit cell is built and the basis functions are generated for the calculation.
cell.build()


# List of k-point meshes to test. T
kpt = 1
kmesh = cell.make_kpts([1,kpt,kpt])


'''
--------------------------------
Perform the DFT Calculation
-------------------------------
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

print(f"k-point mesh: {kpt} {kpt} {kpt}")
print(f"Kinetic energy (eV): {cell.ke_cutoff} {e_tot:.6f}")
print(f"wall time (s): {wall_time:.6f} s" )
