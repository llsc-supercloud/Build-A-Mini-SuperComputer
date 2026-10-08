# Serial Word Count

This example shows how to submit a simple serial job that does not require any special resources beyond a single core and about 4GB of memory.

This example was created using the Lincoln Laboratory Supercomputing Center (LLSC) tools, The LL commands
abstract away the complexity of working with scheduler commands. 

This directory shows two ways to submit this job, using LLsub with triples mode and using sbatch. 
LLsub has been installed as part of the LL commands in the 02_software_libraries section of the course.
The sbatch command is a SLURM schduler command and is available on any system that uses the SLURM scheduler. 
The same Python script can be used for each submission type, however, the names of the environment variables 
that you pass into the submission scripts need to change to reflect the two submission methods

The directory contains the serial version of several word count examples of varying complexity. The purpose is to provide baseline examples for different methods of submitting jobs and parallelizing code.

The three examples are:
    1. Basic word count and rank: What are the top 5 words in each file?
    2. Global/Overall word count and rank: What are the top 5 words in the entire corpus?
    3. Normalized word count and rank: What are the top 5 words in each file, normalized by the global counts?

The .sh files will submit a batch job to one process that iterates through each of the input files, rather than executing any step in parallel. Each of the three examples are done serially. It is good practice to make sure your code runs in serial on this system before attempting to run anything in parallel.

To run submit with:

```bash
LLsub submit_each.sh
LLsub submit_overall.sh
LLsub submit_norm.sh
```

To run on a Slurm system, the equivalent is:

```bash
sbatch -o submit_each.sh.log-%j submit_each.sh
sbatch -o submit_overall.sh.log-%j submit_overall.sh
sbatch -o submit_norm.sh.log-%j submit_norm.sh
```

This directory also contains a Jupyter Notebook that goes over the examples in more detail.
