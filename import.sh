#!/bin/bash

read -p "import files from home folder into the repository?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # do dangerous stuff
	cp -r ~/.zsh .
	cp ~/.zshrc .
	cp -r ~/.config/tmux .
	cp -r ~/.config/nvim .
fi
