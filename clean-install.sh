#!/bin/bash

# Delete cache/state
rm -rf ~/.local/state/nvim*
rm -rf ~/.local/share/nvim*

sh install.sh
