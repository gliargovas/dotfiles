#!/bin/bash

usage() {
    echo "Usage: $0 [--full | --basic]"
    echo "Example: $0 --full"
    echo "Example: $0 --basic"
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

install_texlive_full_mac() {
    echo "Installing TeX Live (full) on macOS..."
    brew install --cask mactex
    echo "Full installation of TeX Live complete on macOS."
}

# Function to install TeX Live (basic) on macOS
install_texlive_basic_mac() {
    echo "Installing TeX Live (basic) on macOS..."
    brew install texlive
    sudo tlmgr install \
        collection-latex \
        collection-fontsrecommended \
        collection-latexrecommended \
        collection-langgreek \
        xetex \
        biblatex \
        algorithms \
        listings \
        minted \
        amsmath \
        hyperref
    echo "Basic installation of TeX Live complete on macOS."
}

install_texlive_full_linux() {
    echo "Installing TeX Live (full) on Linux..."
    sudo apt update
    sudo apt install -y texlive-full
    echo "Full installation of TeX Live complete on Linux."
}

install_texlive_basic_linux() {
    echo "Installing TeX Live (basic) on Linux..."
    sudo apt update
    sudo apt install -y texlive texlive-latex-recommended texlive-fonts-recommended texlive-xetex

    sudo apt install -y \
        texlive-bibtex-extra \
        texlive-science \
        texlive-latex-extra \
        texlive-lang-greek \
        texlive-fonts-extra \
        latexmk \
        biber \
        minted

    echo "Basic installation of TeX Live complete on Linux."
}

install_latex() {
    local mode=$1

    if [[ "$mode" == "--full" ]]; then
        if [[ "$OS" == "mac" ]]; then
            install_texlive_full_mac
        elif [[ "$OS" == "linux" ]]; then
            install_texlive_full_linux
        fi
    elif [[ "$mode" == "--basic" ]]; then
        if [[ "$OS" == "mac" ]]; then
            install_texlive_basic_mac
        elif [[ "$OS" == "linux" ]]; then
            install_texlive_basic_linux
        fi
    else
        usage
    fi
}

# Main script execution
if [[ $# -ne 1 ]]; then
    usage
fi

MODE=$1

detect_os

install_latex "$MODE"

echo "LaTeX installation and XeLaTeX configuration complete."
