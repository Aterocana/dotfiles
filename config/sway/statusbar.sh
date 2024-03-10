#!/bin/bash
# A custom sway bar to show date and pomodoro duration.
date_formatted=$(date "+%a %F %H:%M")
pomodoro_time=$(pomo.sh clock)
echo $pomodoro_time '|' $date_formatted

