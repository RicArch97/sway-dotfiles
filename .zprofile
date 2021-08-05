# Startup script for user login in zsh

# Default editor
export EDITOR=nvim

# Firefox
export MOZ_ENABLE_WAYLAND=1
export MOZ_WEBRENDER=1
export MOZ_DBUS_REMOTE=1
export MOZ_DISABLE_RDD_SANDBOX=1

# GTK
export GTK_CSD=0

# QT Wayland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=gtk2
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

# shell & terminal
export SHELL=/usr/bin/zsh
export TERM=alacritty

# XDG
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

# Other Wayland backends
export CLUTTER_BACKEND=wayland
# export SDL_VIDEODRIVER=wayland

# Fix for Java applications in Sway
export _JAVA_AWT_WM_NONREPARENTING=1

# Start sway automatically from TTY1
if [[ -z $DISPLAY && $TTY = /dev/tty1 ]]; then
	exec sway
fi
