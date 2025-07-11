#!/usr/bin/env bash
# Author: Aterocana
# Description: print memory usage in waybar format
# Version: 1.0.0

# Get memory usage using the free command
memory_info=$(free -h | awk '/^Mem:/ {print $3 "B"}')

# Output JSON format for Waybar
echo "{\"text\": \"$memory_info\"}"
