# © 2023 Liam Coombs <LCCoombs@hotmail.co.uk>

# Uninstall Neovim
choco uninstall neovim -y

# Uninstall Dependencies
choco uninstall ripgrep -y
choco uninstall fzf -y
choco uninstall nodejs -y

# Delete the Neovim folder and coc folder
# Check if nvim folder exists first
if (Test-Path $env:LOCALAPPDATA\nvim) {
    Remove-Item -Path $env:LOCALAPPDATA\nvim -Recurse -Force
    Remove-Item -Path $env:LOCALAPPDATA\nvim-data -Recurse -Force
    Remove-Item -Path $env:LOCALAPPDATA\coc -Recurse -Force
}

