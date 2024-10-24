#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 <nvim-config-file>"
    echo "Example: $0 /path/to/init.vim"
    exit 1
}

# Function to detect the OS (Linux or macOS)
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="mac"
    else
        echo "Unsupported operating system: $OSTYPE"
        exit 1
    fi
    echo "Detected OS: $OS"
}

# Function to install Neovim on macOS
install_nvim_mac() {
    if command -v nvim >/dev/null 2>&1; then
        echo "Neovim is already installed."
    else
        echo "Installing Neovim on macOS..."
        brew install neovim
    fi
}

# Function to install Neovim on Linux
install_nvim_linux() {
    if command -v nvim >/dev/null 2>&1; then
        echo "Neovim is already installed."
    else
        echo "Installing Neovim on Linux..."
        sudo apt update
        sudo apt install -y neovim
    fi
}

# Function to apply the Neovim configuration from the repo
apply_nvim_config() {
    local config_file="$1"
    local config_dir="$HOME/.config/nvim"

    if [[ ! -f "$config_file" ]]; then
        echo "Neovim configuration file not found: $config_file"
        exit 1
    fi

    # Backup existing init.vim if it exists
    if [[ -f "$config_dir/init.vim" ]]; then
        echo "Backing up existing init.vim to $config_dir/init.vim.bak"
        mv "$config_dir/init.vim" "$config_dir/init.vim.bak"
    fi

    # Create the config directory if it doesn't exist
    mkdir -p "$config_dir"

    # Copy the new config file from the repo to the Neovim config directory
    echo "Applying Neovim configuration from $config_file to $config_dir/init.vim"
    cp "$config_file" "$config_dir/init.vim"

    echo "Neovim configuration applied successfully."
}

# Main script execution
if [[ $# -ne 1 ]]; then
    usage
fi

NVIM_CONFIG_FILE=$1

# Step 1: Detect the OS
detect_os

# Step 2: Install Neovim based on the detected OS
if [ "$OS" == "mac" ]; then
    install_nvim_mac
elif [ "$OS" == "linux" ]; then
    install_nvim_linux
fi

# Step 3: Apply the Neovim configuration
apply_nvim_config "$NVIM_CONFIG_FILE"

echo "Neovim installation and configuration complete. You can start Neovim with 'nvim'."