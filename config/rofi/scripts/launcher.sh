#!/usr/bin/env bash
# Author: Aterocana
# Description: Launch an application or a cmd.
# Version: 0.1.0

usage() {
  echo "it displays a launcher"
}
if [[ "$1" = "--help" ]] || [[ "$1" = "-h" ]]; then
	usage
	exit 0
fi

rofi \
	-show drun \
	-theme "$HOME/.config/rofi/styles/launcher.rasi"
