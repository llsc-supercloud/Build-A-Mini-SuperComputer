# Running LLMapReduce


# LLMapReduce Word Count

**NOTE** : You will need to run this example as your own user, not as _admin_.

In the scripts directory, the LLMapReduce directory contains an example of how to submit an LLMapReduce job using `mimo` (multiple input multiple output).

There are a number of data files containing text. The goal is to get the top 5 words in the entire text corpus. In this case, you specify five options to run LLMapReduce:

- `--mapper`: The mapper (a shell script calling the function/script that is being mapped over the input files, in this case counting the number of words in each file)
- `--reducer`: The reducer (a shell script calling the function/script that iterates through the results of the mapper, and in this case sums the word counts to get a global word count)
- `--input`: A directory that contains the input files OR file containing inputs
- `--output`: A directory to write out the result of the mapper
- `--np`: The resources you want to use, expressed as a triple (or the number of concurrent processes, expressed as a single number, best used for testing)

The `mimo` option will create np map processes and split the workload amongst those processes, with each process working on multiple files. This reduces the overhead of starting new map processes when the number of files is large.

The command to run this example is:

```bash
LLMapReduce --mapper mapper.sh --reducer reducer.sh --input ./data/word_count/ --output counts --apptype=mimo --np=[1,4,1]
```

or, using an input file:

```bash
LLMapReduce --mapper mapper.sh --reducer reducer.sh --input input.txt --output counts --apptype=mimo --np=[1,4,1]
```

If you would like to keep the log files for debugging, add the option `--keep=true`. Here we using triples mode to request resources. A triple is expressed as `[Nodes,NPPN,NThreads]`, where

- `Nodes` is number of compute nodes
- `NPPN` is number of processes per node
- `NThreads` is number of threads per process (default is 1)
