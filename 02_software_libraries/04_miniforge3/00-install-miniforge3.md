# Miniforge3

Miniforge3 is the open source python environment.

## Install Miniforge3

Do the installation as the admin user from the headnode.

```bash
# Download the Miniforge3 installer
admin@headnode$>  curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"

# Make the script executable
admin@headnode$> chmod 755 Miniforge3-Linux-aarch64.sh

# Install miniforge3 in /home/gridsan/software/miniforge3.
# Follow the prompts
admin@headnode$> ./Miniforge3-Linux-aarch64.sh -p /home/gridsan/software/miniforge3
```
