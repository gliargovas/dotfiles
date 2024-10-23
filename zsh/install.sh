#!/bin/bash

usage() {
    echo "Usage: $0 <zsh-config-file>"
    echo "Example: $0 /path/to/zsh-config-file"
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

install_zsh_mac() {
    if command -v zsh >/dev/null 2>&1; then
        echo "zsh is already installed."
    else
        echo "Installing zsh on macOS..."
        brew update
        brew install zsh
    fi
}

install_zsh_linux() {
    if command -v zsh >/dev/null 2>&1; then
        echo "zsh is already installed."
    else
        echo "Installing zsh on Linux..."
        sudo apt update
        sudo apt install -y zsh
    fi
}

set_zsh_default() {
    if [ "$SHELL" != "$(command -v zsh)" ]; then
        echo "Setting zsh as the default shell..."
        chsh -s "$(command -v zsh)"
    else
        echo "zsh is already the default shell."
    fi
}

install_powerlevel10k() {
    if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
        echo "Installing Powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    fi
}

install_oh_my_zsh() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo "Oh My Zsh is already installed."
    else
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
}

apply_zsh_config() {
    local config_file="$1"

    if [[ ! -f "$config_file" ]]; then
        echo "zsh configuration file not found: $config_file"
        exit 1
    fi

    # Backup existing .zshrc if it exists
    if [[ -f "$HOME/.zshrc" ]]; then
        echo "Backing up existing ~/.zshrc to ~/.zshrc.bak"
        mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
    fi

    # Copy the new config file from the repo to the home directory
    echo "Applying zsh configuration from $config_file to ~/.zshrc"
    cp "$config_file" "$HOME/.zshrc"

    # Apply changes immediately
    source "$HOME/.zshrc"
    echo "zsh configuration applied successfully."
}

# Main script execution
if [[ $# -ne 1 ]]; then
    usage
fi

ZSH_CONFIG_FILE=$1

detect_os

if [ "$OS" == "mac" ]; then
    install_zsh_mac
elif [ "$OS" == "linux" ]; then
    install_zsh_linux
fi

set_zsh_default

install_oh_my_zsh

apply_zsh_config "$ZSH_CONFIG_FILE"

echo "Installation complete. Please restart your terminal or open a new terminal window."