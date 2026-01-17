#!/usr/bin/env bash
# Author: Aterocana
# Description: Clipboard manager using clipman and rofi
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

check_deps rofi clipman

ROFI_THEME="${HOME}/.config/rofi/styles/clipboard.rasi"

rofi_cmd() {
  case "$1" in
    pick)
      clipman "$1" \
        --tool=CUSTOM \
        --tool-args="rofi -theme-str 'window {width:900px;}' -theme-str 'listview {columns: 1; lines: 7;}' -dmenu -p '󰅇 Pick' -markup-rows -theme ${ROFI_THEME}"
      ;;
    clear)
      clipman "$1" \
        --tool=CUSTOM \
        --tool-args="rofi -theme-str 'window {width:900px;}' -theme-str 'listview {columns: 1; lines: 7;}' -dmenu -p '󱘜 Clear' -markup-rows -theme ${ROFI_THEME}"
      ;;
    *)
      echo "Usage: $0 {pick|clear}" >&2
      exit 1
      ;;
  esac
}

rofi_cmd "${1:-pick}"
