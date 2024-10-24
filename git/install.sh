#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 <gitconfig-file>"
    echo "Example: $0 /path/to/.gitconfig"
    exit 1
}

# Function to install git
install_git() {
    if command -v git >/dev/null 2>&1; then
        echo "Git is already installed."
    else
        echo "Installing Git..."

        # Detect the OS and install git
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo apt update
            sudo apt install -y git
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install git
        else
            echo "Unsupported operating system."
            exit 1
        fi
    fi
}

# Function to apply the .gitconfig
apply_gitconfig() {
    local config_file="$1"

    if [[ ! -f "$config_file" ]]; then
        echo "Git configuration file not found: $config_file"
        exit 1
    fi

    # Backup existing .gitconfig if it exists
    if [[ -f "$HOME/.gitconfig" ]]; then
        echo "Backing up existing ~/.gitconfig to ~/.gitconfig.bak"
        mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
    fi

    # Copy the provided .gitconfig file to the home directory
    echo "Applying Git configuration from $config_file to ~/.gitconfig"
    cp "$config_file" "$HOME/.gitconfig"
}

# Main script execution
if [[ $# -ne 1 ]]; then
    usage
fi

GIT_CONFIG_FILE=$1

# Step 1: Install Git
install_git

# Step 2: Apply Git configuration
apply_gitconfig "$GIT_CONFIG_FILE"

echo "Git installation and configuration complete."