#!/bin/bash/


# Installing Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' > ~/.bashrc
source ~/.bashrc

# Installing Lua 5.1.0
sudo apt install build-essential libreadline-dev unzip libssl-dev -y
curl -LO https://www.lua.org/ftp/lua-5.1.5.tar.gz
tar xzvf lua-5.1.5.tar.gz
cd lua-5.1.5
make linux
sudo make install


# Step 2 Creating the directory
mkdir -p ~/.config/nvim/ && cd ~/.config/
mv nvim_config/* nvim/

