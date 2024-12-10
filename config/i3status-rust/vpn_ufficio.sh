#!/usr/bin/env bash

st=`ip a | grep jekyll-ufficio`
vpn_folder=/home/mauri/Documents/Programming/tools/vpn/xps-cloudbeta-identity

if [[ "${1}" == "status" ]]; then
  if [ -z $st ]; then
	STATE="Critical"
  else
	STATE="Good"
  fi
  echo "{\"icon\":\"\",\"state\":\"${STATE}\",\"text\":\" \"}"

elif [[ "${1}" == "toggle" ]]; then
  if [[ -z $st ]]; then
	sudo $vpn_folder/connect.sh --interface jekyll-ufficio --conf_file $vpn_folder/jekyll-ufficio.conf
	if [[ $? -ne 0 ]]; then
		notify-send "failed to start VPN"
	fi
  else
	sudo wg-quick down $vpn_folder/jekyll-ufficio.conf
	notify-send "VPN Down"
  fi

elif [[ "${1}" == "up" ]]; then
	sudo $vpn_folder/connect.sh --interface jekyll-ufficio --conf_file $vpn_folder/jekyll-ufficio.conf
	if [[ $? -ne 0 ]]; then
		notify-send "failed to start VPN"
	else
		notify-send "VPN started"
	fi
elif [[ "${1}" == "down" ]]; then
	sudo wg-quick down $vpn_folder/jekyll-ufficio.conf
	notify-send "VPN Down"
else
	echo "invalid command $1"
fi
