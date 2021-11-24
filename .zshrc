# ZSH config by Ricardo Steijn

# Pywal load colours async
(cat ~/.cache/wal/sequences &)

# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Global configuration
#
# Vars
export TERM=alacritty
export EDITOR=nvim 

# Path
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH
export ZSH="/home/$(whoami)/.oh-my-zsh"
export REPOPATH="/home/$(whoami)/void-packages"

# OH-MY-ZSH theming & updates
#
# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
# Updates
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

# Plugins
plugins=(
        git
        zsh-autosuggestions
        zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# PyEnv init
eval "$(pyenv init -)"

# User configuration
#
# Aliases
#
# System
alias update="sudo xbps-install -Su && update-src"
alias install="sudo xbps-install -S"
alias uninstall="sudo xbps-remove -R"
alias findpkg="xbps-query -Rs"
alias cleanup="sudo xbps-remove -O"
alias services="sudo sv status /var/service/*"

# Files
alias dc="cd"
alias ls="ls -l --color=auto"
alias sl="ls -l --color=auto"
alias la="ls -la --color=auto"
alias rmdir="rm -rf"
alias srmdir="sudo rm -rf"
alias mkexe="chmod +x"
alias smkexe="sudo chmod +x"
alias open="vim"
alias sopen="sudo vim"

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
alias vim="nvim"
alias nvimconfig="nvim ~/.config/nvim/init.vim"

# Themes
alias powerlevelupdate="git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull"

# Keys
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# Functions
#
# Runit
#
# Enable service
function runit-enable {
	sudo ln -s /etc/sv/$1 /var/service/
}
# Disable service
function runit-disable {
	sudo rm /var/service/$1
}

# Void packages from source
#
# Build a package
function build-src {
        if test -d "${REPOPATH}"; then
                ${REPOPATH}/xbps-src pkg $1
        else
                echo "Could not find void package repo."
        fi
}

# Install a built package
function install-src {
        BINPATH="/hostdir/binpkgs"
        NONFREE="/nonfree"
        if test -d "${REPOPATH}"; then
                if ! sudo xbps-install --repository ${REPOPATH}${BINPATH} $1 ; then
                        if ! sudo xbps-install --repository ${REPOPATH}${BINPATH}${NONFREE} $1 ; then
                                return 1
                        fi
                fi
        else
                echo "Could not find void package repo."
        fi
}

# Pull src packages and update
function update-src {
        if test -d "${REPOPATH}"; then
                git -C ${REPOPATH} pull
                ${REPOPATH}/xbps-src update-sys
        else
                echo "Could not find void package repo."
        fi
}

# Helpers
#
# Extract
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
