#!/usr/bin/env bash
# Author: Aterocana
# Description: tmux session selector based on rofi
# Version: 0.1.0

TERM=kitty
NEW="Create a NEW session"

rofi_cmd() {
	rofi \
		-theme-str "listview {columns: 1; lines: 7;}" \
		-theme-str 'textbox-prompt-colon {str: " ";}' \
		-dmenu \
		-p " " \
		-markup-rows \
		-theme "$HOME/.config/rofi/styles/style.rasi"
}

tmux_sessions() {
    tmux list-session -F '#S'
}

run_rofi() {
	local tsessions=$(tmux_sessions)
	local session=$( echo -e "$NEW\n$tsessions" | rofi_cmd)

	if [[ x"$NEW" = x"${session}" ]]; then
		$TERM -e tmux new-session &
	elif [[ -z "${session}" ]]; then
		echo "Cancel"
	else
		$TERM -e tmux attach -t "${session}" &
	fi
}

run_rofi
