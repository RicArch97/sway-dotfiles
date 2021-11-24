#!/bin/bash

source ~/.cache/wal/colors.sh

# Restart wlclock to implement PyWal theming

# Terminate current instance
killall -q wlclock

# Wait till process has been shut down
while pgrep -u $UID -x wlclock > /dev/null; do sleep 1; done

# Launch wlclock
wlclock 				\
	--output DP-1                   \
	--background-colour "#000000b3"	\
	--corner-radius 200             \
	--border-size 0                 \
	--clock-colour "$foreground"	\
	--layer bottom                  \
	--hand-width 6                  \
	--marking-width 3               \
	--position top-right            \
	--margin 70 60 0 0              \
	--size 300			\
	& disown
