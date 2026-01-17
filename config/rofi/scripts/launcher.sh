#!/usr/bin/env bash
# Author: Aterocana
# Description: Application launcher using rofi
# Version: 0.2.0

set -euo pipefail

if ! command -v rofi &>/dev/null; then
  echo "Error: rofi is not installed" >&2
  exit 1
fi

if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
  echo "Usage: $0"
  echo "Launch applications using rofi drun mode"
  exit 0
fi

rofi \
  -show drun \
  -theme "$HOME/.config/rofi/styles/launcher.rasi"
