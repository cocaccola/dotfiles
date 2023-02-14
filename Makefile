SHELL=/bin/bash
.ONESHELL:

dotfiles: gitconfig zshrc tmuxconf vimrc

gitconfig:
	@cp -v dotfiles/.gitconfig ~

zshrc: gitconfig
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


.PHONY: dotfiles gitconfig zshrc tmuxconf vimrc neovim macOSkeyfix
