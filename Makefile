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

macOSkeyfix:
	@./vscode/macos-keyfix.sh


.PHONY: dotfiles gitconfig zshrc tmuxconf vimrc macOSkeyfix
