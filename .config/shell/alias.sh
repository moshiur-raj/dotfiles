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

# Python venv
pytorch()
{
	[[ $HOSTNAME == "archlinux" ]] && export HSA_OVERRIDE_GFX_VERSION=10.3.0
	source $HOME/.local/python-venv/pytorch/bin/activate
}
