# add all of ~/.local/bin's immediate subdirectories to PATH.
localpaths="$(find "$HOME/.local/bin" -mindepth 1 -maxdepth 1 -printf ":%p")"
export PATH="${PATH}${localpaths}"

# xdg dirs
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export TMPDIR=/tmp

# default programs
export TERMINAL=kitty
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export BROWSER=firefox
export READER=zathura
export TERMFILE=lfrun
export FILE=termopen
export OPENER=opener
export TERMCMD="$TERMINAL"

# ~/ clean-up
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export NVIM_COC_LOG_FILE="$XDG_RUNTIME_DIR/coc-nvim-log/coc-nvim.log"
export STALONETRAYRC="$XDG_CONFIG_HOME/stalonetray/stalonetrayrc"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export BOOKMARKS_FILE="$XDG_CONFIG_HOME/zshmarks/bookmarks"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"
export TS3_CONFIG_DIR="$XDG_DATA_HOME/ts3client"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export KEYCHAIN_DIR="$XDG_DATA_HOME/keychain"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export PYLINTHOME="$XDG_DATA_HOME/pylint"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export HISTFILE="$XDG_DATA_HOME/history"
export GRIPHOME="$XDG_CONFIG_HOME/grip"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export KODI_DATA="$XDG_DATA_HOME/kodi"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export UNISON="$XDG_DATA_HOME/unison"
export GEM_HOME="$XDG_DATA_HOME/gem"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export LESSHISTFILE="-"

# pipx settings
export PIPX_BIN_DIR=~/.local/bin/pipx
mkdir -p "$PIPX_BIN_DIR"

# have sudo ask for a password via dmenu
export SUDO_ASKPASS="$HOME/.local/bin/dmenu/dmenu-askpass"

# stuff used in my scripts
export USVDIR="$HOME/.local/sv/run" # user services
export PSOCKS='localhost:9050' # tor's socks proxy
export IPLOOKUP_FILE="$XDG_CONFIG_HOME/iplookup/site"
export IPLOOKUP="$(head -n1 "$IPLOOKUP_FILE")"

# aria2
export ARIA2_CONF="$XDG_CONFIG_HOME/aria2/server.conf"
export ARIA2_SECRET="$(grep ^rpc-secret "$ARIA2_CONF" | cut -d= -f2-)"

# fzf settings
export FZF_DEFAULT_OPTS="
--layout=reverse --height=40% --border=sharp
--bind=ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-g:top
--color=dark
--color=fg:244,bg:-1,hl:#a07f32,fg+:#dedede,bg+:-1,hl+:#fabd2f
--color=info:#83a598,prompt:#bdae93,spinner:#fabd2f
--color=pointer:#83a598,marker:#fe8019,header:#665c54
"

# tuir settings
export TUIR_EDITOR="$EDITOR"
export TUIR_BROWSER="$BROWSER"
export TUIR_URLVIEWER="urlscan"

# bat theme
export BAT_THEME='Nord'
export LF_BAT_OPTS='-p'
export LF_IMG_REGEX='.*\.(jpe?g|png|gif|bmp|ico|svg|webp)$'

# less colors
export LESS='-RSmci'
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_us=$'\E[1;32m' # begin underline
export LESS_TERMCAP_mb=$'\E[1;31m' # begin blink
export LESS_TERMCAP_md=$'\E[1;36m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # reset bold/blink
export LESS_TERMCAP_se=$'\E[0m' # reset reverse video
export LESS_TERMCAP_ue=$'\E[0m' # reset underline
export LESSOPEN='| bat -fppn -- %s 2>/dev/null' # colorize less using bat

# ls settings
ls_colors="$XDG_CONFIG_HOME/lscolors/lscolors"
test -r "$ls_colors" && source "$ls_colors"
export TIME_STYLE="+%F %T"

# other stuff
export MPD_HOST=localhost
export MOZ_USE_XINPUT2="1" # Mozilla smooth scrolling/touchpads.
export _JAVA_AWT_WM_NONREPARENTING=1 # fix for java applications in dwm
export QT_QPA_PLATFORMTHEME=gtk2 # have qt use gtk2 theme.

# run keychain (an ssh-agent manager)
keychain --dir "$KEYCHAIN_DIR" >/dev/null 2>&1
eval "$(cat "$KEYCHAIN_DIR"/*-sh)" >/dev/null 2>&1

# clear tty on exit
trap reset EXIT

# start X
[ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ] &&
    startx "$XINITRC" -- "$XSERVERRC" vt1 -keeptty >/dev/null 2>&1
