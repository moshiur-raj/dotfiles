# Load env vars if systemd failed to do so
[[ $ENV_CONF_LOADED == "1" ]] || { set -a; source $HOME/.config/environment.d/env.conf; set +a; }
# Assign HOSTNAME if it is not set
[[ $HOSTNAME ]] || export HOSTNAME=$HOST

# Fix mpv blank screen and hw decode in gnome wayland
[[ $HOSTNAME == "archlinux" ]] && [[ $WAYLAND_DISPLAY ]] && [[ $XDG_CURRENT_DESKTOP == "GNOME" ]] && alias mpv="gnome-session-inhibit --inhibit idle mpv"
# Set Terminal Title in Gnome-Console
[ $(ps -p $PPID -o comm= ) = "kgx" ] && echo -ne "\033]0;Terminal\007"

# Termux Support
[[ $HOSTNAME == "Termux" ]] && [[ $SHELL == "$PREFIX/bin/zsh" ]] && {
	source $PREFIX/share/fzf/completion.zsh
	source $PREFIX/share/fzf/key-bindings.zsh
	source $HOME/.local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source $HOME/.local/share/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
}
