# Fix alacritty title bar in gnome wayland
[[ $WAYLAND_DISPLAY ]] && [[ $XDG_CURRENT_DESKTOP == "GNOME" ]] && unset WINIT_UNIX_BACKEND && alias alacritty="env WINIT_UNIX_BACKEND=x11 alacritty"
# VTE Support in tilix
[ $TILIX_ID ] || [ $VTE_VERSION ] && source /etc/profile.d/vte.sh
