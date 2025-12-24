#!/usr/bin/env bash
# Author: Aterocana
# Description: tmux session selector based on rofi
# Version: 0.2.0

set -euo pipefail

TERM=kitty
ROFI_THEME="$HOME/.config/rofi/styles/style.rasi"
NOTIFY="notify-send -t 2000"

NEW="+ New session"

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

# ---------- SESSION LIST ----------
list_sessions() {
  sesh list --json | jq -r '
    map(
      . + {
        prio:
          if .Src == "tmux" and .Attached == 1 then 0
          elif .Src == "tmuxinator" then 1
          elif .Src == "tmux" then 2
          elif .Src == "zoxide" then 3
          else 9
          end,
        score: (.Score // 0)
      }
    )
    | sort_by(
        .prio,
        (if .Src == "zoxide" then -.score else 0 end),
        .Name
      )
    | (
        map(select(.Src == "tmux" or .Src == "tmuxinator"))
        | unique_by(.Name)
      )
      +
      (
        map(select(.Src == "zoxide"))
      )
    | .[]
    | "\(.Name)|\(.Src)|\(.Attached)|\(.score)"
  ' | while IFS='|' read -r name src attached score; do

    case "$src" in
      tmux)
        # icon="●"
        icon=""
        [[ "$attached" != "1" ]] && icon=""
        ;;
      tmuxinator)
        icon=""
        ;;
      zoxide)
        icon=""
        ;;
    esac

    # echo "$icon|$src|$name"
    echo "$icon $name"
  done
}

run() {
  local choice retv src session name

  choice=$(
    {
      echo "$NEW"
      list_sessions
    } | rofi_cmd
  )
  retv=$?

  IFS=' ' read -r icon session <<<"$choice"
  echo "return value: $retv, choice: $icon $session"

  [[ -z "$choice" ]] && exit 0

  case "$retv" in
    0) # Return
      echo "Return"
      case "$choice" in
        "$NEW")
          name=$(rofi_prompt)
          [[ -z "$name" ]] && exit 1
          $TERM -e tmux new-session -s "$name" &
          $NOTIFY "tmux" "created session $name"
          ;;
        *)
          $TERM -e sesh connect "$session" &
          $NOTIFY "tmux" "attached to $icon $session"
          ;;
      esac
      ;;

    -1) # Ctrl+Return: force attach/create
      echo "Ctrl + Return"
      case "$choice" in
        "$NEW")
          $TERM -e tmux new-session &
          $NOTIFY "tmux" "new session"
          ;;
        *)
          $TERM -e tmux new-session -A -s "$session" &
          $NOTIFY "tmux" "forced attach/create $icon $session"
          ;;
      esac
      ;;

    -2) # Ctrl+Shift+Return: recreate
      echo "Ctrl + Shift + Return"
      tmux kill-session -t "$session" 2>/dev/null || true
      $TERM -e tmux new-session -s "$session" &
      $NOTIFY "tmux" "recreated $icon $session"
      ;;

    *)
      exit 0
      ;;
  esac
}

run

