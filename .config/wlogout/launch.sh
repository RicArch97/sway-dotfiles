#!/bin/bash
# Script that launches wlogout based on the focused output

# Get the focused output
output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused)' | jq -r '.name')

if [[ $output == "DP-1" ]]; then
	wlogout --margin-right 1100 \
		--margin-left 1100 \
		--margin-top 350 \
		--margin-bottom 350 \
		--column-spacing 100 \
		--row-spacing 100 \
		--protocol layer-shell
elif [[ $output == "DP-2" ]]; then
	wlogout --margin-right 700 \
		--margin-left 700 \
		--margin-top 380 \
		--margin-bottom 380 \
		--column-spacing 100 \
		--row-spacing 100 \
		--protocol layer-shell
else
	echo "Error getting focused display"
fi
