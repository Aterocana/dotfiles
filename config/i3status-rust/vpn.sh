#!/usr/bin/env bash

st=`ip a | grep ppp0`
vpn_folder=/home/mauri/Documents/VPN

if [[ "${1}" == "status" ]]; then
  if [ -z $st ]; then
	STATE="Critical"
  else
	STATE="Good"
  fi
  echo "{\"icon\":\"\",\"state\":\"${STATE}\",\"text\":\" \"}"

elif [[ "${1}" == "toggle" ]]; then
  if [ -z $st ]; then
	cat "$vpn_folder/sudopwd" | sudo -S "$vpn_folder/vpn.sh"
	if [[ $? -ne 0 ]]; then
		notify-send "failed to start VPN"
	fi
  else
	cat "$vpn_folder/sudopwd" | sudo -S pkill openfortivpn
	notify-send "VPN Down"
  fi
fi
