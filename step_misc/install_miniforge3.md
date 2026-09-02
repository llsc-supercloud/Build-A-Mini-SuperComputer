# Install Miniforge3

Use Miniforge3 to setup a  python (or conda) environment separate from the system python installation. 
A conda environment allows the user to build a  customized environment.
Miniforge3 is open-source unlike Anaconda.

## Download the Miniforge3 installer

```bash
 curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
```

## Install miniforge3

```bash
## Make the script executable
chmod 755 Miniforge3-$(uname)-$(uname -m).sh

## Install miniforge3 in /home/gridsan/software/miniforge3 with -p option
./Miniforge3-$(uname)-$(uname -m).sh -p /home/gridsan/software/miniforge3

```

## Install python packges in your base conda environment

The base conda environment is /home/gridsan/software/miniforge3.

```bash
  ## Set PATH to point at the path of the python interpretor, mamba and pip executables
  export PATH=/home/gridsan/software/miniforge3/bin:$PATH
  ## Check the location of pip
  which pip
  ## Install numpy and pandas into the base environment
  pip install numpy pandas
```