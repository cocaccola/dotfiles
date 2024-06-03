SHELL=/bin/bash
.ONESHELL:

dotfiles:       gitconfig zshrc tmux_conf vimrc neovim terminal_theme k9s_theme zellij default_c_formatting wezterm bin gh_config
dotfiles_linux: gitconfig zshrc tmux_conf vimrc neovim k9s_theme_linux zellij default_c_formatting bin gh_config

bin:
	@mkdir ~/bin 2>&- || true
	@cp -rv bin/ ~/bin

gh_config:
	@gh config set editor nvim

delta_theme:
	@mkdir -p ~/.config/delta 2>&- || true
	@curl -fsSL https://raw.githubusercontent.com/catppuccin/delta/main/catppuccin.gitconfig -o ~/.config/delta/catppuccin.gitconfig

gitconfig:
	@mv -v ~/.gitconfig ~/.gitconfig.bak
	@cp -v dotfiles/.gitconfig ~
	@cp -v dotfiles/.gitignore_global ~
	@nvim -O ~/.gitconfig ~/.gitconfig.bak
	@rm ~/.gitconfig.bak

only_zshrc:
	@cp -v dotfiles/.zshrc ~

starship:
	@mkdir ~/.config 2>&- || true
	@cp -v dotfiles/starship.toml ~/.config/starship.toml

wezterm:
	@cp -v wezterm/wezterm.lua ~/.wezterm.lua


zshrc: gitconfig bat_theme zsh_syntax_highlighting glamor_theme starship
	@mkdir ~/.zsh/user 2>&- || true
	@cp -v dotfiles/.zshrc ~
	@$(brew --prefix)/opt/fzf/install

tmux_conf:
	@cp -v dotfiles/.tmux.conf ~

vimrc: vim_theme
	@cp -v dotfiles/.vimrc ~

default_c_formatting:
	@curl -fsSL https://raw.githubusercontent.com/torvalds/linux/master/.clang-format -o ~/.clang-format

neovim:
	@test -d ~/.config/nvim && rm -rf ~/.config/nvim
	@mkdir -p ~/.config/nvim
	@cp -vr neovim/* ~/.config/nvim/

zellij:
	@mkdir -p ~/.config/zellij 2>&- || true
	@mkdir -p ~/.config/zellij/layouts 2>&- || true
	@cp -v dotfiles/zellij.kdl ~/.config/zellij/config.kdl

macOS_keyfix:
	@./vscode/macos-keyfix.sh

terminal_theme:
	@curl -fsSL https://raw.githubusercontent.com/catppuccin/iterm/main/colors/catppuccin-macchiato.itermcolors -o ~/Desktop/catppuccin-macchiato.itermcolors

bat_theme:
	@git clone https://github.com/catppuccin/bat.git
	@mkdir -p "$(shell bat --config-dir)/themes"
	@cp -v bat/*.tmTheme "$(shell bat --config-dir)/themes"
	@bat cache --build
	@rm -rf bat

k9s_theme_linux:
	@git clone https://github.com/catppuccin/k9s.git ~/.config/k9s/skins/catppuccin --depth 1
	@cp -v ~/.config/k9s/skins/catppuccin/dist/catppuccin-macchiato-transparent.yaml ~/.config/k9s/skins/catppuccin.yaml
	@yq -i '.k9s.ui.skin = "catppuccin"' ~/.config/k9s/config.yaml
	@rm -rf ~/.config/k9s/skins/catppuccin

k9s_theme:
	@git clone https://github.com/catppuccin/k9s.git ~/Library/Application\ Support/k9s/skins/catppuccin --depth 1
	@cp -v ~/Library/Application\ Support/k9s/skins/catppuccin/dist/macchiato.yml ~/Library/Application\ Support/k9s/skins/catppuccin.yaml

	@# from https://github.com/derailed/k9s/blob/master/skins/transparent.yml
	@yq -i ' \
	  .k9s.body.bgColor = "default" | \
	  .k9s.prompt.bgColor = "default" | \
	  .k9s.info.sectionColor = "default" | \
	  .k9s.dialog.bgColor = "default" | \
	  .k9s.dialog.labelFgColor = "default" | \
	  .k9s.dialog.fieldFgColor = "default" | \
	  .k9s.frame.title.bgColor = "default" | \
	  .k9s.frame.title.counterColor = "default" | \
	  .k9s.frame.menu.fgColor = "default" | \
	  .k9s.views.charts.bgColor = "default" | \
	  .k9s.views.table.bgColor = "default" | \
	  .k9s.views.table.header.fgColor = "default" | \
	  .k9s.views.table.header.bgColor = "default" | \
	  .k9s.views.xray.bgColor = "default" | \
	  .k9s.views.logs.bgColor = "default" | \
	  .k9s.views.logs.indicator.bgColor = "default" | \
	  .k9s.views.logs.indicator.toggleOnColor = "default" | \
	  .k9s.views.logs.indicator.toggleOffColor = "default" | \
	  .k9s.views.yaml.colonColor = "default" | \
	  .k9s.views.yaml.valueColor = "default" \
	' ~/Library/Application\ Support/k9s/skins/catppuccin.yaml

	@yq -i '.k9s.ui.skin = "catppuccin"' ~/Library/Application\ Support/k9s/config.yaml
	@rm -rf ~/Library/Application\ Support/k9s/skins/catppuccin

glamor_theme:
	@mkdir -p ~/.config/glamour/catppuccin
	@curl -L https://github.com/catppuccin/glamour/releases/download/v1.0.0/macchiato.json -o ~/.config/glamour/catppuccin/macchiato.json

vim_theme:
	@mkdir ~/.vim 2>&- || true
	@git clone https://github.com/catppuccin/vim.git
	@cp -rv vim/colors ~/.vim
	@rm -rf vim

zsh_plugin_dir:
	@mkdir ~/.zsh 2>&- || true

zsh_user_config_dir: zsh_plugin_dir
	@mkdir ~/.zsh/user 2>&- || true

zsh_syntax_highlighting: zsh_plugin_dir
	@git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
	@rm -rf zsh-syntax-highlighting/.git
	@cp -r zsh-syntax-highlighting ~/.zsh
	@rm -rf zsh-syntax-highlighting

	@git clone https://github.com/catppuccin/zsh-syntax-highlighting.git
	@mkdir ~/.zsh/catppuccin 2>&- || true
	@cp -v zsh-syntax-highlighting/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh ~/.zsh/catppuccin
	@rm -rf zsh-syntax-highlighting

setup_mac:
	@./scripts/setup_mac.sh

setup_wsl:
	@./scripts/setup_wsl.sh

install_mac_dev_tools:
	@xcode-select --install

setup_gpg:
	@mkdir ~/.gnupg
	@echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
	@killall gpg-agent

# might be needed for zoxide
# https://github.com/ajeetdsouza/zoxide
# TODO: this doesn't work when the shell is bash (above)
rebuild_zsh_completion_cache:
	@rm ~/.zcompdump*; compinit

clean:
	@rm -rf bat
	@rm -rf zsh-syntax-highlighting


.PHONY: dotfiles gitconfig zshrc tmuxconf vimrc neovim macOS_keyfix bat_theme clean zsh_plugin_dir
.PHONY:	zsh_syntax_highlighting setup_mac setup_wsl terminal_theme install_mac_dev_tools rebuild_zsh_completion_cache
.PHONY:	k9s_theme vim_theme zsh_user_config_dir setup_gpg zellij only_zshrc k9s_theme_linux default_c_formatting
.PHONY:	starship wezterm bin delta_theme gh_config
