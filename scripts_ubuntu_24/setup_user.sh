#!/bin/bash

# This script creates a new user on an Ubuntu system, disables their password auth,
# and sets up their SSH key for passwordless login.
#
# setup_user.sh <username> <ssh_key>
#

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <username> <ssh_key>"
    exit 1
fi

USERNAME=$1
SSH_KEY=$2

sudo useradd -m -s /bin/bash "$USERNAME" || { echo "User creation failed"; exit 1; }

sudo passwd -l "$USERNAME"

sudo mkdir -p /home/"$USERNAME"/.ssh
echo "$SSH_KEY" | sudo tee /home/"$USERNAME"/.ssh/authorized_keys > /dev/null

sudo chown -R "$USERNAME":"$USERNAME" /home/"$USERNAME"/.ssh
sudo chmod 700 /home/"$USERNAME"/.ssh
sudo chmod 600 /home/"$USERNAME"/.ssh/authorized_keys

echo "User $USERNAME created and SSH key added."
