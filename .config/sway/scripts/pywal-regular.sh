#!/bin/bash

# Set a wallpaper with PyWal on both monitors.

wal1=$HOME/.cache/wal/wal-3440x1440.jpg
wal2=$HOME/.cache/wal/wal-2560x1440.jpg

if [[ -f "$wal1" && -f $wal2 ]]; then
        rm $wal1
	rm $wal2
fi

# Wallpaper is set by wallpaper script.
wal -i "${1}" -b "#000000" -n
