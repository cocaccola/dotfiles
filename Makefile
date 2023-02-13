SHELL=/bin/bash
.ONESHELL:

dotfiles: gitconfig zshrc tmuxconf vimrc

gitconfig:
	@cp dotfiles/.gitconfig ~

zshrc: gitconfig
	@cp dotfiles/.zshrc ~

tmuxconf:
	@cp dotfiles/.tmux.conf ~

vimrc:
	@cp dotfiles/.vimrc ~

macOSkeyfix:
	@./vscode/macos-keyfix.sh


.PHONY: dotfiles gitconfig zshrc tmuxconf vimrc macOSkeyfix
