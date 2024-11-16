#!/bin/bash
# A script to download and install Neovim and the kickstart.nvim configuration

# Download the latest Neovim AppImage from GitHub
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

# Make the downloaded Neovim AppImage executable
chmod u+x nvim.appimage

# Create a directory at /opt/nvim to store the Neovim AppImage
mkdir -p /opt/nvim

# Move the Neovim AppImage to the /opt/nvim directory and rename it to 'nvim'
mv nvim.appimage /opt/nvim/nvim

# Check if '/opt/nvim' is in PATH and add it to ~/.bashrc if not
grep -qxF 'export PATH="$PATH:/opt/nvim/"' ~/.bashrc || echo 'export PATH="$PATH:/opt/nvim/"' >> ~/.bashrc

# Clone the kickstart.nvim repo into the Neovim configuration directory
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

# Replace "folke/tokyonight.nvim" with "sainnhe/everforest"
sed -i 's/folke\/tokyonight.nvim/sainnhe\/everforest/g' "$HOME/.config/nvim/init.lua"

# Replace "tokyonight-night" with "everforest"
sed -i 's/tokyonight-night/everforest/g' "$HOME/.config/nvim/init.lua"
