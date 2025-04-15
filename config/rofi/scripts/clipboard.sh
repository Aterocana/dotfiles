#!/usr/bin/env bash
# Author: Aterocana
# Description: tmux session selector based on rofi
# Version: 0.1.0

rofi_cmd() {
#	clipman $1 \
#		--tool=CUSTOM \
#		--tool-args='rofi -theme-str "textbox-prompt-colon {str: \"\";}" -theme-str "listview {columns: 1; lines: 7;}" -dmenu -p "Clipboard" -markup-rows -theme ~/.config/rofi/scripts/style.rasi'
	clipman $1 \
		--tool=CUSTOM \
		--tool-args='rofi -theme-str "window {width:900px;}" -theme-str "listview {columns: 1; lines: 7;}" -dmenu -p " " -markup-rows -theme ~/.config/rofi/scripts/clipboard.rasi'
}

rofi_cmd $1
