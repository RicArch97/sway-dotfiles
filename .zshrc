# ZSH config by Ricardo Steijn

# Pywal load colours async
(cat ~/.cache/wal/sequences &)

# Launch fastfetch
# fastfetch

# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Terminal
export TERM=alacritty
export EDITOR=nvim

# Ruby envs
# eval "$(rbenv init -)"

# Path
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="/home/ricardo/.oh-my-zsh"

# Functions
#
# Extract any file type from cmd
function extract {
	if [ -z "$1" ]; then
		# display usage if no parameters given
		echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
		echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
	else
		for n in "$@"
		do
			if [ -f "$n" ] ; then
				case "${n%,}" in
					*.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
						tar xvf "$n"       ;;
					*.lzma)      unlzma ./"$n"      ;;
					*.bz2)       bunzip2 ./"$n"     ;;
					*.cbr|*.rar)       unrar x -ad ./"$n" ;;
					*.gz)        gunzip ./"$n"      ;;
					*.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
					*.z)         uncompress ./"$n"  ;;
					*.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
						7z x ./"$n"        ;;
					*.xz)        unxz ./"$n"        ;;
					*.exe)       cabextract ./"$n"  ;;
					*.cpio)      cpio -id < ./"$n"  ;;
					*.cba|*.ace)      unace x ./"$n"      ;;
					*)
						echo "extract: '$n' - unknown archive method"
						return 1
						;;
				esac
			else
				echo "'$n' - file does not exist"
				return 1
			fi
		done
	fi
}

# Theming
#
# Oh-My-ZSH
#
# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# ZSH plugins
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

# Load the oh my zsh config
source $ZSH/oh-my-zsh.sh

# User configuration
#
# Aliases
#
# System
alias update="trizen -Syu"
alias install="trizen -S"
alias uninstall="trizen -R"
alias cleanup="sudo paccache -r"
alias findpkg="trizen"

# Filemanager
alias dc="cd"
alias sl="ls"
alias la="ls -a"
alias rmdir="sudo rm -rf"
alias mkexe="sudo chmod +x"
alias open="nvim"
alias sopen="sudo nvim"
alias config='/usr/bin/git --git-dir=/home/ricardo/.cfg/ --work-tree=/home/ricardo'

# Python
alias pyact="source venv/bin/activate"
alias pydeact="deactivate"

# Configs
# ZSH
alias zshconfig="nvim ~/.zshrc"
# Alacritty
alias alaconfig="nvim ~/.config/wal/templates/alacritty.conf"
# Sway
alias swayconfig="nvim ~/.config/sway/config"
alias swayoutputs="nvim ~/.config/sway/config.d/output"
alias swayinputs="nvim ~/.config/sway/config.d/input"
alias swaykeybinds="nvim ~/.config/sway/config.d/keybinds"
alias swayvars="nvim ~/.config/sway/config.d/variables"
alias swaywindows="nvim ~/.config/sway/config.d/windows"
alias swaythemes="nvim ~/.config/sway/config.d/theming"
alias swayautostart="nvim ~/.config/sway/config.d/autostart"
# Waybar
alias waybarstyle="nvim ~/.config/waybar/style.css"
alias waybarconfig="nvim ~/.config/waybar/config"
# Neovim
alias nvimconfig="nvim ~/.config/nvim/init.vim"

# Themes
alias powerlevelupdate="git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull"

# Keys
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
