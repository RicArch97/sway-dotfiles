#!/bin/bash

# Script that passes a dual monitor wallpaper to PyWal for analyze the colours
# Then cuts the wallpaper according to resolution and saves them.

image=$1
dir=$HOME/.cache/wal

# Get the current resolution for all monitors
resolutions=$(swaymsg -t get_outputs | jq -r '[.[] | .rect]')

# Loop through display properties
for item in $(echo "${resolutions}" | jq -r '.[] | @base64'); do
	get_nested() {
		echo ${item} | base64 --decode | jq -r ${1}
	}

	# Get the widht and height
	width=$(get_nested '.width');
	height=$(get_nested '.height');

	# Get the positions
	x=$(get_nested '.x');
	y=$(get_nested '.y');

	# Crop image using ImageMagick
	convert -crop "${width}x${height}+${x}+${y}" "$image" ${dir}/"wal-${width}x${height}".jpg;
done

# Use wal to scan the image and create color files
# Don't set the wallpaper using Wal
wal -i "${image}" -b "#000000" -n
