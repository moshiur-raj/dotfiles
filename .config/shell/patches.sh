# add .local/bin to path
export PATH="$HOME/.local/bin:$PATH"
# Load env vars if systemd failed to do so
[[ $ENV_CONF_LOADED == "1" ]] || { set -a; source $HOME/.config/environment.d/env.conf; set +a; }
# Assign HOSTNAME if it is not set
[[ $HOSTNAME ]] || export HOSTNAME=$HOST

# Fix mpv blank screen and hw decode in gnome wayland
[[ $HOSTNAME == "archlinux" ]] && [[ $WAYLAND_DISPLAY ]] && [[ $XDG_CURRENT_DESKTOP == "GNOME" ]] && alias mpv="gnome-session-inhibit --inhibit idle mpv"
# VTE Support in tilix
[ $TILIX_ID ] || [ $VTE_VERSION ] && source /etc/profile.d/vte.sh
# Set Terminal Title in Gnome-Console
[ $(ps -p $PPID -o comm= ) = "kgx" ] && echo -ne "\033]0;Terminal\007"

# Fix pytorch on rocm
[[ $HOSTNAME == "archlinux" ]] && export HSA_OVERRIDE_GFX_VERSION=10.3.0

# Python venv
source $HOME/.local/python-venv/default/bin/activate

# Termux Support
[[ $HOSTNAME == "Termux" ]] && [[ $SHELL == "$PREFIX/bin/zsh" ]] && {
	source $PREFIX/share/fzf/completion.zsh
	source $PREFIX/share/fzf/key-bindings.zsh
	source $HOME/.local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source $HOME/.local/share/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
}

# Use hyperthreading in OpenMPI
alias mpirun="mpirun --use-hwthread-cpus"
alias mpiexec="mpiexec --use-hwthread-cpus"
