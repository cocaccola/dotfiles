#!/usr/bin/env bash

# this will require ubuntu 22.04 LTS
# exa is not present in 20.04 LTS
sudo apt update
sudo apt install \
exa \
fd-find \
silversearcher-ag \
bat

sudo ln -s $(which fdfind) /usr/local/bin/fd
sudo chmod +x /usr/local/bin/fd

sudo ln -s /usr/bin/batcat /usr/local/bin/bat
sudo chmod +x /usr/local/bin/bat

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
rm -rf ~/.fzf

# install wsl for bash
# https://www.techtronic.us/pbcopy-pbpaste-for-wsl/
sudo > /usr/local/bin/pbcopy <<EOF
#!/bin/bash
# pbcopy for wsl
tee <&0 | clip.exe
exit 0
EOF

sudo chmod +x /usr/local/bin/pbcopy

# todo
# fonts
# neovim
