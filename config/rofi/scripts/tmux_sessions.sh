#!/usr/bin/env bash
# Author: Aterocana
# Description: tmux session selector based on rofi
# Version: 0.1.0

TERM=kitty
NEW="Create a NEW session"
NOTIFY=notify-send

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

# Prompt to ask for a new session name
rofi_prompt() {
	rofi \
		-dmenu \
		-p " name:" \
		-theme-str 'entry { placeholder: "session-name"; }' \
		-theme "$HOME/.config/rofi/styles/style.rasi"
	}

run_rofi() {
	local tsessions=$(tmux_sessions)
	local session=$( echo -e "$NEW\n$tsessions" | rofi_cmd)

	if [[ x"$NEW" = x"${session}" ]]; then
		local name=$( rofi_prompt )
		if [[ -z "$name" ]]; then
			$NOTIFY "tmux" "No session name provided"
			exit 0
		fi
		$TERM -e tmux new-session -s "$name" &
		$NOTIFY "tmux" "created session $name"
	elif [[ -z "${session}" ]]; then
		echo "Cancel"
	else
		$TERM -e tmux attach -t "${session}" &
		$NOTIFY "tmux" "attached to session $session"
	fi
}

run_rofi
