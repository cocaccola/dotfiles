# https://rpmfusion.org/Configuration
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

# https://rpmfusion.org/Howto/Multimedia
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

# https://developer.fyralabs.com/terra/installing
sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

sudo dnf install bat \
        eza \
        fd \
        fzf \
        tree \
        zoxide \
        gnupg \
        starship \
        direnv \
        k9s \
        ripgrep \
        jq \
        yq \
        ipcalc \
        git-delta \
        gum \
        cowsay \
        gh \
        lolcat \
        zellij \
        entr \
        glow \
        dive \
        pandoc \
        go-task \
        ykman \
        ghostty \
        uv \
        fx \
        luarocks \
        tree-sitter \
        tree-sitter-cli \
        node \
        tmux \
	zsh \
	firacode-nerd-fonts

# Install the latest neovim
# https://neovim.io/doc/install/
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
