#!/bin/bash
# Date: 2026-01-08
# Purpose: Add a user to the BAM cluster
# Author: jmurray1@mit.edu, mullenj@mit.edu
set -euo pipefail

############################
# Configuration
############################
NODES=("node1" "node2" "node3")
HOME_BASE="/orcd/home"
SSH_KEY_TYPE="ed25519"
SHELL="/bin/bash"
############################

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
