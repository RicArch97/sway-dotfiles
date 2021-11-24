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
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

# shell & terminal
export SHELL=/usr/bin/zsh
export TERM=alacritty

# XDG
# Set the XDG_RUNTIME_DIR variable
#if test -z "${XDG_RUNTIME_DIR}"; then
#        export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
#	if ! test -d "${XDG_RUNTIME_DIR}"; then
#		mkdir "${XDG_RUNTIME_DIR}"
#		chmod 0700 "${XDG_RUNTIME_DIR}"
#	fi
#fi
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway
export DESKTOP_SESSION=sway

# Other Wayland backends
export CLUTTER_BACKEND=wayland
# export SDL_VIDEODRIVER=wayland

# Fix for Java applications in Sway
export _JAVA_AWT_WM_NONREPARENTING=1

# Enable manual Vulkan driver selection
# export DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1
# - RADV 	/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
# - AMDVLK	/usr/share/vulkan/icd.d/amd_icd32.json:/usr/share/vulkan/icd.d/amd_icd64.json
# - AMDGPU-PRO	/usr/share/vulkan/icd.d/amd_pro_icd32.json:/usr/share/vulkan/icd.d/amd_pro_icd64.json
# export VK_ICD_FILENAMES=

# PyEnv init
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Start sway automatically from TTY1
if [[ -z $DISPLAY && $TTY = /dev/tty1 ]]; then
	exec dbus-run-session sway
fi
