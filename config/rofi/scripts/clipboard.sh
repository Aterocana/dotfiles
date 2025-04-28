#!/usr/bin/env bash
# Author: Aterocana
# Description: tmux session selector based on rofi
# Version: 0.1.0

rofi_cmd() {
	case "$1" in
		pick)
			clipman $1 \
				--tool=CUSTOM \
				--tool-args='rofi -theme-str "window {width:900px;}" -theme-str "listview {columns: 1; lines: 7;}" -dmenu -p "󰅇 Pick" -markup-rows -theme '"${HOME}/.config/rofi/styles/clipboard.rasi"
			;;
		clear)
			clipman $1 \
				--tool=CUSTOM \
				--tool-args='rofi -theme-str "window {width:900px;}" -theme-str "listview {columns: 1; lines: 7;}" -dmenu -p "󱘜 Clear" -markup-rows -theme '"$HOME/.config/rofi/styles/clipboard.rasi"
			;;
		*)
			echo "invalid option $1"
			;;
	esac
}

rofi_cmd $1
