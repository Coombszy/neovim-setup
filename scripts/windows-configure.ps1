# © 2023 Liam Coombs <LCCoombs@hotmail.co.uk>

# Create install directory
$nvimDir = "$env:LOCALAPPDATA\nvim"
if (!(Test-Path $nvimDir)) {
    New-Item -ItemType Directory -Force -Path $nvimDir
}

# Copy init.vim
Copy-Item -Path "$PSScriptRoot\..\configuration\init.vim" -Destination "$nvimDir\init.vim" -Force

# Install Vim-Plug
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

# Auto install plugins
nvim +PlugInstall +qall
