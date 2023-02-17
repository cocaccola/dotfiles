SHELL=/bin/bash
.ONESHELL:

dotfiles: gitconfig zshrc tmuxconf vimrc neovim batTheme

gitconfig:
	@cp -v dotfiles/.gitconfig ~

zshrc: gitconfig batTheme
	@cp -v dotfiles/.zshrc ~

tmuxconf:
	@cp -v dotfiles/.tmux.conf ~

vimrc:
	@cp -v dotfiles/.vimrc ~

neovim:
	@mkdir -p ~/.config/nvim/ 2>&-
	@cp -v dotfiles/init.vim ~/.config/nvim/init.vim

macOSkeyfix:
	@./vscode/macos-keyfix.sh

batTheme:
	@git clone git@github.com:catppuccin/bat.git
	@mkdir -p "$(shell bat --config-dir)/themes"
	@cp -v bat/*.tmTheme "$(shell bat --config-dir)/themes"
	@bat cache --build
	@rm -rf bat

clean:
	@rm -rf bat

.PHONY: dotfiles gitconfig zshrc tmuxconf vimrc neovim macOSkeyfix batTheme clean
