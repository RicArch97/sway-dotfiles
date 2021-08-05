#!/bin/sh

. "${HOME}/.cache/wal/colors.sh"

wal1=$HOME/.cache/wal/wal-3440x1440.jpg
wal2=$HOME/.cache/wal/wal-2560x1440.jpg

if [[ -f "$wal1" && -f $wal2 ]]; then
	swaymsg output 'DP-1 background '$wal1' fill'
	swaymsg output 'DP-2 background '$wal2' fill'
else
	swaymsg output '* background $wallpaper fill'
fi
