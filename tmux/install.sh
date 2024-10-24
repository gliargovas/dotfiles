#!/bin/bash

usage() {
    echo "Usage: $0 <tmux-config-file>"
    echo "Example: $0 /path/to/.tmux.conf"
    exit 1
}

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

install_tmux_mac() {
    if command -v tmux >/dev/null 2>&1; then
        echo "tmux is already installed."
    else
        echo "Installing tmux on macOS..."
        brew install tmux
    fi
}

install_tmux_linux() {
    if command -v tmux >/dev/null 2>&1; then
        echo "tmux is already installed."
    else
        echo "Installing tmux on Linux..."
        sudo apt update
        sudo apt install -y tmux
    fi
}

install_tpm() {
    # Ensure TPM (tmux plugin manager) is installed
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        echo "Installing tmux plugin manager (TPM)..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    else
        echo "tmux plugin manager (TPM) is already installed."
    fi
}

apply_tmux_config() {
    local config_file="$1"

    if [[ ! -f "$config_file" ]]; then
        echo "tmux configuration file not found: $config_file"
        exit 1
    fi

    if [[ -f "$HOME/.tmux.conf" ]]; then
        echo "Backing up existing ~/.tmux.conf to ~/.tmux.conf.bak"
        mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
    fi

    echo "Applying tmux configuration from $config_file to ~/.tmux.conf"
    cp "$config_file" "$HOME/.tmux.conf"

    # Automatically source the new configuration if tmux is running
    if tmux info >/dev/null 2>&1; then
        tmux source-file "$HOME/.tmux.conf"
        echo "tmux configuration reloaded in active session."
    else
        echo "tmux is not running. Configuration will be applied to new sessions."
    fi
}

# Main script execution
if [[ $# -ne 1 ]]; then
    usage
fi

TMUX_CONFIG_FILE=$1

detect_os

if [ "$OS" == "mac" ]; then
    install_tmux_mac
elif [ "$OS" == "linux" ]; then
    install_tmux_linux
fi

# Install TPM (tmux plugin manager)
install_tpm

# Apply tmux configuration
apply_tmux_config "$TMUX_CONFIG_FILE"

echo "tmux installation and configuration complete. You can start tmux with 'tmux'."
echo "If tmux is running, press 'Prefix + I' to install the plugins."
