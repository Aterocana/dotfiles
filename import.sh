#!/bin/bash

# Copyleft (C) 2024 github.com/Aterocana
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.

read -p "import files from home folder into the repository? [y/N] " -n 1 -r
echo    # (optional) move to a new line

commit=`git rev-parse HEAD`

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # copy from home folder all configurations
	cp -r ~/.zsh .
	echo "" > .zsh/secrets.zsh
	cp ~/.zshrc .
	cp ~/.gitconfig .
	mkdir -p config/tmux/
	cp -r ~/.config/tmux/tmux.conf config/tmux/tmux.conf
	cp -r ~/.config/tmux/tmux.d config/tmux/
	cp -r ~/.config/xdg-desktop-portal config/
	cp -r ~/.config/nvim config/
	cp -r ~/.config/kitty config/
	cp -r ~/.config/alacritty config/
	cp -r ~/.config/dlv config/
	cp -r ~/.config/i3status-rust config/
	cp -r ~/.config/sway config/
	cp -r ~/.config/mako config/
	cp -r ~/.config/rofi config/
	cp -r ~/.config/tmuxinator config/
	mkdir -p local
	cp -r ~/.local/scripts local/
fi
