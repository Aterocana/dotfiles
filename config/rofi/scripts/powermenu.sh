#!/usr/bin/env bash
# Author: Aditya Shakya (adi1090x), modified by Aterocana
# Description: Power menu for Sway/Hyprland
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

check_deps rofi systemctl swaylock

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"
host="$(hostname)"

# Options
shutdown='⏻ Shutdown'
reboot=' Reboot'
lock=' Lock'
suspend=' Suspend'
logout='󰗽 Logout'
yes=' Yes'
no='❌ No'

# Rofi CMD
rofi_cmd() {
  rofi -dmenu \
    -p "$host" \
    -mesg "Uptime: $uptime" \
    -theme "$HOME/.config/rofi/styles/powermenu.rasi"
}

# Confirmation CMD
confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
    -theme-str 'mainbox {children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you Sure?' \
    -theme "$HOME/.config/rofi/styles/powermenu.rasi"
}

# Ask for confirmation
confirm_exit() {
  echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

lock() {
  swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --ring-color 98971a --key-hl-color d65d0e
}

# Execute Command
run_cmd() {
  local selected
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    case "$1" in
      --shutdown)
        systemctl poweroff
        ;;
      --reboot)
        systemctl reboot
        ;;
      --suspend)
        command -v mpc &>/dev/null && mpc -q pause
        command -v amixer &>/dev/null && amixer set Master mute
        systemctl suspend
        ;;
      --logout)
        if [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
          hyprctl dispatch exit
        elif [[ -n "${SWAYSOCK:-}" ]]; then
          swaymsg exit
        else
          notify-send -u critical "Error" "Unknown session type"
        fi
        ;;
    esac
  fi
}

# Actions
chosen="$(run_rofi)" || exit 0
case "${chosen}" in
  "$shutdown")
    run_cmd --shutdown
    ;;
  "$reboot")
    run_cmd --reboot
    ;;
  "$lock")
    lock
    ;;
  "$suspend")
    run_cmd --suspend
    ;;
  "$logout")
    run_cmd --logout
    ;;
esac
