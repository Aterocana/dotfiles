#!/usr/bin/env bash
set -euo pipefail

TERM=kitty
NOTIFY="notify-send -t 2000"
ROFI_THEME="$HOME/.config/rofi/styles/style.rasi"

NEW="󰐕  New session"
NEW_NAMED="󰐕  New named session"

rofi_cmd() {
  rofi \
    -dmenu \
    -markup-rows \
    -p " tmux" \
    -theme "$ROFI_THEME"
}

rofi_prompt() {
  rofi \
    -dmenu \
    -p " name:" \
    -theme "$ROFI_THEME" \
    -theme-str 'entry { placeholder: "session-name"; }'
}

# sesh sessions (configured + discovered)
sesh_sessions() {
  sesh list 2>/dev/null | awk '{print $1}'
}

# tmux live sessions (fallback / safety)
tmux_sessions() {
  tmux list-sessions -F '#S' 2>/dev/null || true
}

run() {
  local sessions
  sessions=$(
    {
      echo "$NEW"
      echo "$NEW_NAMED"
      sesh_sessions
      tmux_sessions
    } | awk '!seen[$0]++'
  )

  local choice
  choice=$(echo "$sessions" | rofi_cmd)

  [[ -z "$choice" ]] && exit 0

  case "$choice" in
    "$NEW")
      $TERM -e sesh new &
      $NOTIFY "tmux" "new session"
      ;;
    "$NEW_NAMED")
      name=$(rofi_prompt)
      [[ -z "$name" ]] && exit 1
      $TERM -e sesh new "$name" &
      $NOTIFY "tmux" "created session $name"
      ;;
    *)
      $TERM -e sesh connect "$choice" &
      $NOTIFY "tmux" "attached to $choice"
      ;;
  esac
}

run

