#!/usr/bin/env bash
# Author: Aterocana
# Description:
# Version:

#text, alt, tooltip, class, percentage

res=`massctl status | jq .`
#".state, .attributes.media_title, .attributes.media_artist"`
title=`echo ${res} | jq -r .attributes.media_title`
artist=`echo ${res} | jq -r .attributes.media_artist`


state=`echo ${res} | jq .state`
case "${state}" in
	"\"playing\"")
		echo " ${title} - ${artist}"
		;;
	"\"idle\"")
		echo ""
		;;
	*)
		echo "boh"
		;;
esac
