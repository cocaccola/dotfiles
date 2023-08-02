SHELL=/bin/bash
.ONESHELL:

dotfiles: gitconfig zshrc tmux_conf vimrc neovim terminal_theme k9s_theme

gitconfig:
	@cp -v dotfiles/.gitconfig ~

zshrc: gitconfig bat_theme zsh_syntax_highlighting glamor_theme
	@cp -v dotfiles/.zshrc ~

tmux_conf:
	@cp -v dotfiles/.tmux.conf ~

vimrc: vim_theme
	@cp -v dotfiles/.vimrc ~

neovim:
	@mkdir -p ~/.config/nvim/ 2>&-
	@cp -v dotfiles/init.vim ~/.config/nvim/init.vim

macOS_vscode_keyfix:
	@./vscode/macos-keyfix.sh

terminal_theme:
	@curl -fsSL https://raw.githubusercontent.com/catppuccin/iterm/main/colors/catppuccin-macchiato.itermcolors -o ~/Desktop/catppuccin-macchiato.itermcolors

bat_theme:
	@git clone git@github.com:catppuccin/bat.git
	@mkdir -p "$(shell bat --config-dir)/themes"
	@cp -v bat/*.tmTheme "$(shell bat --config-dir)/themes"
	@bat cache --build
	@rm -rf bat

k9s_theme:
	@git clone https://github.com/catppuccin/k9s.git ~/Library/Application\ Support/k9s/skins/catppuccin --depth 1
	@cp -v ~/Library/Application\ Support/k9s/skins/catppuccin/dist/macchiato.yml ~/Library/Application\ Support/k9s/skin.yml

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

# might be needed for zoxide
# https://github.com/ajeetdsouza/zoxide
# TODO: this doesn't work when the shell is bash (above)
rebuild_zsh_completion_cache:
	@rm ~/.zcompdump*; compinit

clean:
	@rm -rf bat
	@rm -rf zsh-syntax-highlighting


.PHONY: dotfiles gitconfig zshrc tmuxconf vimrc neovim macOS_vscode_keyfix bat_theme clean zsh_plugin_dir zsh_syntax_highlighting setup_mac setup_wsl terminal_theme install_mac_dev_tools rebuild_zsh_completion_cache k9s_theme vim_theme
