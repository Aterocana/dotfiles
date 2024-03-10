#!/bin/bash

read -p "import files from home folder into the repository?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # copy from home folder all configurations
	cp -r ~/.zsh .
	echo "" > .zsh/secrets.zsh
	cp ~/.zshrc .
	cp ~/.gitconfig .
	mkdir -p .config/tmux/
	cp -r ~/.config/tmux/tmux.conf ./config/tmux.conf
	cp -r ~/.config/nvim .
	cp -r ~/.config/alacritty config/
	cp -r ~/.config/dlv config/
	cp -r ~/.config/i3status-rust config/
	cp -r ~/.config/sway config/
	cp -r ~/.config/mako config/
fi
