from mpi4py import MPI

# Get the default communicator
comm = MPI.COMM_WORLD

# Get the total number of processes
size = comm.Get_size()

# Get the rank (ID) of the current process
rank = comm.Get_rank()

# Get the name of the processor/node
node_name = MPI.Get_processor_name()

print(f"Hello, World! I am process {rank} of {size} on {node_name}.")
