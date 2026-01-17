#!/usr/bin/env bash
# Author: Maurizio Dominici (Aterocana) based on Aditya Shakya (adi1090x)
# Description: Screenshot utility with OCR support
# Version: 0.2.0

set -euo pipefail

# Pre-flight checks
check_deps() {
  for cmd in "$@"; do
    if ! command -v "$cmd" &>/dev/null; then
      notify-send -u critical "Error" "$cmd not installed"
      exit 1
    fi
  done
}

check_deps rofi grim slurp wl-copy notify-send

# Theme Elements
prompt='Screenshot'
dir="$(xdg-user-dir PICTURES)/screenshots"
mesg="DIR: $dir"

list_col='1'
list_row='7'
win_width='400px'

# Options
option_1=" Capture Desktop"
option_2=" Capture Area"
option_3=" Capture Window"
option_4="󱄽 transcribe from screen"
option_5=" Capture in 1s"
option_6=" Capture in 5s"
option_7=" Capture in 10s"

# Rofi CMD
rofi_cmd() {
  rofi -theme-str "window {width: $win_width;}" \
    -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows \
    -theme "$HOME/.config/rofi/styles/screenshot.rasi"
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6\n$option_7" | rofi_cmd
}

# Screenshot
file="$(date +"%Y-%m-%d_%H:%M:%S.png")"

if [[ ! -d "$dir" ]]; then
  mkdir -p "$dir"
fi

# notify and view screenshot
notify_view() {
  notify-send -t 2000 -i "${dir}/${file}" "Screenshot save as ${file}"
  echo "Screenshot save as ${file}"
}

# Copy screenshot to clipboard for a single use.
copy_shot() {
  wl-copy --paste-once < "${dir}/${file}"
}

# countdown
countdown() {
  for sec in $(seq "$1" -1 1); do
    notify-send -t 1000 "Taking shot in $sec"
    sleep 1
  done
}

# take shots
shot_now() {
  grim "${dir}/${file}"
  notify_view
  copy_shot
}

shot_in_sec() {
  local time="${1:-0}"
  countdown "${time}"
  shot_now
}

shotwin() {
  local output
  output="$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')" || {
    # Fallback for Hyprland
    output="$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')"
  }
  grim -o "$output" "${dir}/${file}"
  notify_view
  copy_shot
}

shotarea() {
  local geometry
  geometry="$(slurp)" || exit 0
  grim -g "$geometry" "${dir}/${file}"
  notify_view
  copy_shot
}

transcribe() {
  check_deps tesseract
  local geometry
  geometry="$(slurp)" || exit 0
  grim -g "$geometry" - | tesseract - stdout 2>/dev/null | wl-copy
  notify-send -t 2000 "Text copied to clipboard"
}

# Execute Command
run_cmd() {
  case "$1" in
    --opt1) shot_now ;;
    --opt2) shotarea ;;
    --opt3) shotwin ;;
    --opt4) transcribe ;;
    --opt5) shot_in_sec '1' ;;
    --opt6) shot_in_sec '5' ;;
    --opt7) shot_in_sec '10' ;;
  esac
}

run_selection() {
  local chosen
  chosen="$(run_rofi)" || exit 0
  case "${chosen}" in
    "$option_1") run_cmd --opt1 ;;
    "$option_2") run_cmd --opt2 ;;
    "$option_3") run_cmd --opt3 ;;
    "$option_4") run_cmd --opt4 ;;
    "$option_5") run_cmd --opt5 ;;
    "$option_6") run_cmd --opt6 ;;
    "$option_7") run_cmd --opt7 ;;
  esac
}

case "${1:-}" in
  area) shotarea ;;
  window) shotwin ;;
  transcribe) transcribe ;;
  *) run_selection ;;
esac
