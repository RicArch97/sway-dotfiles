#!/bin/bash

. "${HOME}/.cache/wal/colors.sh"

wal1=$HOME/.cache/wal/wal-3440x1440.jpg
wal2=$HOME/.cache/wal/wal-2560x1440.jpg

if [[ -f "$wal1" && -f $wal2 ]]; then
	swaymsg output 'DP-1 background '$wal1' stretch'
	swaymsg output 'DP-2 background '$wal2' stretch'
else
	swaymsg output '* background $wallpaper stretch'
fi
