#!/bin/env bash

DIR="$HOME/Dotfiles/"
TPM_DIR="$HOME/.tmux/plugins/tpm"
CAT_DIR="$HOME/.config/tmux/plugins/catppuccin/tmux/"
TMXFR_DIR="$HOME/.tmuxifier"

#Clean Install if dir already exist
if [[ -d "$DIR" ]]; then
    rm -rf "$DIR"
fi
# Get Dotfiles config
git clone git@github.com:d-Aome/DotFiles.git $DIR

# Install tpm plugin
if [[ -d "$TPM_DIR" ]]; then
    rm -rf "$TPM_DIR"
fi
git clone https://github.com/tmux-plugins/tpm $TPM_DIR

#Install Catpuuccin for tmux
if  [[ -d "$CAT_DIR" ]]; then
    rm -rf "$CAT_DIR"
fi
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux


# Install tmuxifier
if [[ -d "$TMXFR_DIR" ]]; then
    rm -rf "$TMXFR_DIR"
fi

git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
