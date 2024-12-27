#!/usr/bin/env bash

if ! command -v brew >&-; then
    echo "please setup homebrew first" >&2
    exit 1
fi

brew update

if [[ "$(uname)" == "Linux" ]]; then
    ulimit -n $(ulimit -Hn)
    brew install zsh keychain
    echo $(which zsh) | sudo tee -a /etc/shells
    sudo chsh -s $(which zsh) caccola

    # install pbcopy shim for wsl
    # https://www.techtronic.us/pbcopy-pbpaste-for-wsl/
    sudo > /usr/local/bin/pbcopy <<EOF
#!/bin/bash
# pbcopy for wsl
tee <&0 | clip.exe
exit 0
EOF

    sudo chmod +x /usr/local/bin/pbcopy
fi

if [[ "$(uname)" == "Darwin" ]]; then
    brew install pinentry-mac
    # fonts, casks only work on macOS
    brew tap homebrew/cask-fonts
    brew install font-fira-code-nerd-font
    brew install 1password-cli
fi

# required packages
brew install \
        bat \
        eza \
        fd \
        fzf \
        tree \
        zoxide \
        pinentry-mac \
        gnupg \
        starship \
        direnv \
        kubectx \
        kubernetes-cli \
        k9s \
        stern \
        neovim \
        ripgrep \
        jq \
        yq \
        terraform \
        terragrunt \
        ipcalc \
        git-delta \
        gum \
        cowsay \
        gh \
        lolcat \
        zellij \
        entr \
        glow \
        gotestsum \
        dive \
        nvm \
        pandoc \
        go-task \
        ykman \
        ghostty

# make dev directory for git repos
#mkdir ~/dev
