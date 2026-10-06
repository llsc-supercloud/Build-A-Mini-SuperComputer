#!/bin/bash
# Date: 2026-01-08
# Purpose: Add a user to the BAM cluster (as a system user) and to Slurm database (as a Slurm user).
# Author: jmurray1@mit.edu, mullenj@mit.edu
set -euo pipefail

############################
# Configuration
############################
NODES=("node1" "node2" "node3")
HOME_BASE="/home/gridsan"
SSH_KEY_TYPE="ed25519"
SHELL="/bin/bash"
CLUSTER_NAME="txpi4"
SLURM_ACCT_NAME="default_group"
############################

function create_slurm_account () {
   # This function will create 'default_group' in the slurmdb if it does not exist.
   account_name=$SLURM_ACCT_NAME

   s1=$(sacctmgr --noheader show account where account=$account_name)

   if [[ -z "$s1" ]]; then
      echo "Create account $account_name in Slurm database."
      sacctmgr add account $account_name Cluster=$CLUSTER_NAME Description="default group" Organization="MITLL"
   fi

}

function add_slurmdb () {
   # Create user on slurm db. Use 'sacctmgr create'
   
   local user_name=$1
   acct_name=$SLURM_ACCT_NAME
   #admin_level="admin"
   #sacctmgr -i create user name=$user_name account=$acct_name adminlevel=$admin_level
   sacctmgr -i create user name=$user_name account=$acct_name
   echo "Add $user_name to Slurm database."
}


if [[ $EUID -ne 0 ]]; then
  echo "ERROR: This script must be run as root"
  exit 1
fi

# Prompt for username
read -rp "Enter new username: " USERNAME

if id "$USERNAME" &>/dev/null; then
  echo "ERROR: User '$USERNAME' already exists on headnode"
  exit 1
fi

# Prompt for password (silent)
read -rsp "Enter password: " PASSWORD
echo
read -rsp "Confirm password: " PASSWORD_CONFIRM
echo

if [[ "$PASSWORD" != "$PASSWORD_CONFIRM" ]]; then
  echo "ERROR: Passwords do not match"
  exit 1
fi

HOME_DIR="${HOME_BASE}/${USERNAME}"

echo "Creating user on headnode..."

# Create user on headnode
useradd \
  --home-dir "$HOME_DIR" \
  --shell "$SHELL" \
  "$USERNAME"

echo "$USERNAME:$PASSWORD" | chpasswd

# Ensure home directory exists with correct permissions
mkdir -p "$HOME_DIR"
chown "$USERNAME:$USERNAME" "$HOME_DIR"
chmod 700 "$HOME_DIR"

####################################
# SSH key generation
####################################
echo "Generating SSH key for $USERNAME..."

sudo -u "$USERNAME" mkdir -p "$HOME_DIR/.ssh"
sudo -u "$USERNAME" chmod 700 "$HOME_DIR/.ssh"

sudo -u "$USERNAME" ssh-keygen \
  -t "$SSH_KEY_TYPE" \
  -N "" \
  -f "$HOME_DIR/.ssh/id_${SSH_KEY_TYPE}"

sudo -u "$USERNAME" \
  cp "$HOME_DIR/.ssh/id_${SSH_KEY_TYPE}.pub" \
     "$HOME_DIR/.ssh/authorized_keys"

sudo -u "$USERNAME" chmod 600 "$HOME_DIR/.ssh/authorized_keys"

####################################
# Add user to compute nodes
####################################
for NODE in "${NODES[@]}"; do
  echo "Configuring user on $NODE..."

  ssh root@"$NODE" bash <<EOF
set -e

if ! id $USERNAME &>/dev/null; then
  useradd \
    --home-dir $HOME_DIR \
    --shell $SHELL \
    $USERNAME
fi

echo '$USERNAME:$PASSWORD' | chpasswd

mkdir -p $HOME_DIR
chown $USERNAME:$USERNAME $HOME_DIR
chmod 700 $HOME_DIR
EOF

done

echo
echo "User '$USERNAME' successfully created on:"
printf ' - %s\n' "${NODES[@]}"

# Create 'default_group' in the slurm db
create_slurm_account
# Add the user to the slurm db
add_slurmdb $USERNAME
