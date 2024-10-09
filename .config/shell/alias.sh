# yt-dlp
alias yt-dlp='yt-dlp --no-overwrites --merge-output-format mkv --add-metadata --embed-subs --sub-langs "en.*" -f "bestvideo[height<=1080][vcodec^=av01]+bestaudio/bestvideo[height<=1080][vcodec=vp9]+bestaudio/bestvideo[height<=1080]+bestaudio" '
alias yt-playlist='yt-dlp --no-overwrites --merge-output-format mkv --add-metadata --embed-subs --sub-langs "en.*" -f "bestvideo[height<=1080][vcodec^=av01]+bestaudio/bestvideo[height<=1080][vcodec=vp9]+bestaudio/bestvideo[height<=1080]+bestaudio" -o "%(playlist_index)s. %(title)s.%(ext)s" '
# Managing dotfiles
alias gd='git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'
# Safe removal ?
alias rm='rm -Iv'
# Group directories first and add colors in ls
alias ls='ls -hN --color=auto --group-directories-first'
# Color support in grep
alias grep="grep --color=auto"
# Ask if overwriting
alias cp="cp -iv"
alias mv="mv -iv"

# Use hyperthreading in OpenMPI
alias mpirun="mpirun --use-hwthread-cpus"
alias mpiexec="mpiexec --use-hwthread-cpus"

# Activate Python Virtual Environment
pyvenv()
{
	if [ -z "$1" ]; then
		echo "Please provide the name of the virtual environment."
		return 1
	fi

	if [[ $1 == "pytorch" ]]; then
		[[ $HOSTNAME == "archlinux" ]] && export HSA_OVERRIDE_GFX_VERSION=10.3.0
	fi

	VENV_DIR="$HOME/.local/python-venv/$1"
	if [ -d "$VENV_DIR" ]; then
		source "$VENV_DIR/bin/activate"
		echo "Activated virtual environment: $1"
	else
		echo "Virtual environment '$1' not found in $HOME/.virtualenvs/"
		return 1
	fi
}
