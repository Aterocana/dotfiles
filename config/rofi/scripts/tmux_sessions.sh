#!/usr/bin/env bash
# Author: Aterocana
# Description: tmux session selector based on rofi
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

check_deps rofi tmux sesh jq

TERMINAL="${TERMINAL:-kitty}"
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

abbreviate_path() {
  local full_path="$1"
  local n=2  # Number of trailing components to show
  local short_path
  short_path="$(echo "$full_path" | sed "s|^$HOME|~|")"
  IFS='/' read -ra parts <<< "$short_path"
  local count="${#parts[@]}"
  if [[ "$short_path" == "~" ]]; then
    echo "~"
  elif (( count > n + 1 )); then
    local last_parts=("${parts[@]: -n}")
    local joined
    printf -v joined "/%s" "${last_parts[@]}"
    echo "...${joined}"
  else
    echo "$short_path"
  fi
}

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
    | "\(.Name)|\(.Src)|\(.Attached)|\(.score)|\(.Path // "")"
    ' | while IFS='|' read -r name src attached score path; do

    case "$src" in
      tmux)
        icon=""
        [[ "$attached" != "1" ]] && icon=""
        display="$name"
        real="$name"
        ;;
      tmuxinator)
        icon=""
        display="$name"
        real="$name"
        ;;
      zoxide)
        icon=""
        display="$(abbreviate_path "$path")"
        real="$path"
        ;;
    esac

    # Output: display string<TAB>real value
    echo -e "$icon $display\t$real"
  done
}

run() {
  local choice retv display real_value session name

  choice=$(
    {
      echo "$NEW"
      list_sessions
    } | rofi_cmd
  )
  retv=$?

  [[ -z "$choice" ]] && exit 0

  # Split on tab to get display and real value
  IFS=$'\t' read -r display real_value <<<"$choice"
  # Remove icon from display for session name
  session="${display#* }"

  case "$retv" in
    0) # Return
      case "$choice" in
        "$NEW"*)
          name=$(rofi_prompt)
          [[ -z "$name" ]] && exit 1
          $TERMINAL -e tmux new-session -s "$name" &
          $NOTIFY "tmux" "created session $name"
          ;;
        *)
          # Use real_value for zoxide, session name otherwise
          if [[ -n "$real_value" && "$real_value" != "$session" ]]; then
            $TERMINAL -e sesh connect "$real_value" &
            $NOTIFY "tmux" "attached to $display"
          else
            $TERMINAL -e sesh connect "$session" &
            $NOTIFY "tmux" "attached to $display"
          fi
          ;;
      esac
      ;;
    -1) # Ctrl+Return: force attach/create
      case "$choice" in
        "$NEW"*)
          $TERMINAL -e tmux new-session &
          $NOTIFY "tmux" "new session"
          ;;
        *)
          $TERMINAL -e tmux new-session -A -s "$session" &
          $NOTIFY "tmux" "forced attach/create $display"
          ;;
      esac
      ;;
    -2) # Ctrl+Shift+Return: recreate
      tmux kill-session -t "$session" 2>/dev/null || true
      $TERMINAL -e tmux new-session -s "$session" &
      $NOTIFY "tmux" "recreated $display"
      ;;
    *)
      exit 0
      ;;
  esac
}

run

