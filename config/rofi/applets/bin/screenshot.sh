#!/usr/bin/env bash

## Author  : Maurizio Dominici (Aterocana) based on Aditya Shakya (adi1090x)
## Github  : @Aterocana
#
## Applets : Screenshot

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
prompt='Screenshot'
mesg="DIR: `xdg-user-dir PICTURES`/screenshots"

if [[ "$theme" == *'type-1'* ]]; then
	list_col='1'
	list_row='6'
	win_width='400px'
elif [[ "$theme" == *'type-3'* ]]; then
	list_col='1'
	list_row='6'
	win_width='120px'
elif [[ "$theme" == *'type-5'* ]]; then
	list_col='1'
	list_row='6'
	win_width='520px'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='6'
	list_row='1'
	win_width='670px'
fi

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1=" Capture Desktop"
	option_2=" Capture Area"
	option_3=" Capture Window"
	option_4=" Capture in 1s"
	option_5=" Capture in 5s"
	option_6=" Capture in 10s"
else
	option_1=""
	option_2=""
	option_3=""
	option_4=""
	option_5=""
	option_6=""
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

# Screenshot
time=`date +%Y-%m-%d-%H-%M-%S`
geometry=`xrandr | grep 'current' | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current'`
dir="`xdg-user-dir PICTURES`/screenshots"
file=$(date +"%Y-%m-%d_%H:%M:%S.png")

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# notify and view screenshot
notify_view() {
	notify-send -i "${dir}/${file}" "Screenshot save as ${file}"
	echo "Screenshot save as ${file}"
}

# Copy screenshot to clipboard for a single use.
copy_shot () {
	wl-copy --paste-once < "${dir}/${file}"
}

# countdown
countdown () {
	for sec in `seq $1 -1 1`; do
		notify-send -t 1000 "Taking shot in $sec"
		sleep 1
	done
}

# take shots
shot_now () {
	grim "${dir}/${file}"
	notify_view
	copy_shot
}

shot_in_sec () {
	local time
	if [[ -z "$1" ]]; then
		time=0
	else
		time=$1
	fi
	countdown "${time}"
	shot_now
}

shotwin () {
	grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') "${dir}/${file}"
	notify_view
	copy_shot
}

shotarea () {
	grim -g "$(slurp)" "${dir}/${file}"
	notify_view
	copy_shot
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		shot_now
	elif [[ "$1" == '--opt2' ]]; then
		shotarea
	elif [[ "$1" == '--opt3' ]]; then
		shotwin
	elif [[ "$1" == '--opt4' ]]; then
		shot_in_sec '1'
	elif [[ "$1" == '--opt5' ]]; then
		shot_in_sec '5'
	elif [[ "$1" == '--opt6' ]]; then
		shot_in_sec '10'
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
    $option_6)
		run_cmd --opt6
        ;;
esac


