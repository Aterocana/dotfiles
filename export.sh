#!/bin/bash

# Copyleft (C) 2024 github.com/Aterocana
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.

read -p "export files from repository to into home folder? [y/Y] "  -n 1 -r
echo

commit=`git rev-parse HEAD`

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # backup current configurations
	fname="backups/`date +"%Y.%m.%d.%H.%M.%S"`"
	mkdir -p $fname
	mv ~/.zsh $fname/
	mv ~/.zshrc $fname/
	mv ~/.gitconfig $fname/
	mkdir -p $fname/.config
	mv ~/.config/tmux $fname/.config/
	mv ~/.config/nvim $fname/.config/
	mv ~/.config/alacritty $fname/.config/
	mv ~/.config/dlv $fname/.config/
	mv ~/.config/i3status-rust $fname/.config/
	mv ~/.config/sway $fname/.config/
	mv ~/.config/mako $fname/.config/

	# deploy current configuration
	cp -r .zsh ~/
	cp $fname/.zsh/secrets.zsh ~/.zsh/
	cp .zshrc ~/
	cp .gitconfig ~
	cp -r config/tmux ~/.config/
	cp -r $fname/.config/tmux/plugins ~/.config/tmux/
	cp -r config/nvim ~/.config/
	cp -r config/alacritty ~/.config/
	cp -r config/dlv ~/.config/
	cp -r config/i3status-rust ~/.config/
	cp -r config/sway ~/.config/
	cp -r config/mako ~/.config/

	echo "$commit">~/.config/dotfile_commit
fi
