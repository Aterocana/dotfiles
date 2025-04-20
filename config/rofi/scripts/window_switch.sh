#!/usr/bin/env bash
# Author: Aterocana
# Description: Launch an application or a cmd.
# Version:

usage() {
  echo "usage: $0 ..."
}
if [[ "$1" = "--help" ]] || [[ "$1" = "-h" ]]; then
	usage
	exit 0
fi

rofi \
	-show window \
	-theme "$HOME/.config/rofi/styles/launcher.rasi"
