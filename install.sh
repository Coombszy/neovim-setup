#!/bin/bash

# Copy neovim folders to ~/.config, If .config folder does not exist, create it
if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

rm -rf ~/.config/nvim*

# Copy any "nvim" prefixed folders to .config
cp -rf ./nvim* ~/.config/


