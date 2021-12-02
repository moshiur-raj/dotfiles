# Load env vars if systemd failed to do so
[[ $ENV_CONF_LOADED == "1" ]] || { set -a; source $HOME/.config/environment.d/env.conf; set +a; }

# Fix mpv blank screen in gnome wayland
[[ $WAYLAND_DISPLAY ]] && [[ $XDG_CURRENT_DESKTOP == "GNOME" ]] && alias mpv="gnome-session-inhibit --inhibit idle mpv --gpu-context=x11egl"
# Fix alacritty title bar in gnome wayland
[[ $WAYLAND_DISPLAY ]] && [[ $XDG_CURRENT_DESKTOP == "GNOME" ]] && unset WINIT_UNIX_BACKEND && alias alacritty="env WINIT_UNIX_BACKEND=x11 alacritty"
# VTE Support in tilix
[ $TILIX_ID ] || [ $VTE_VERSION ] && source /etc/profile.d/vte.sh

# Termux Support
[[ $HOSTNAME == "Termux" ]] && [[ $SHELL == "$PREFIX/bin/zsh" ]] && {
	source $PREFIX/share/fzf/completion.zsh
	source $PREFIX/share/fzf/key-bindings.zsh
	source $HOME/.local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source $HOME/.local/share/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
}
[[ $HOSTNAME == "Termux" ]] && clear
