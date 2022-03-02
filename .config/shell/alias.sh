# Emacs
alias emacs="emacsclient -nc"
# yt-dlp
alias yt-dlp="yt-dlp --merge-output-format mkv --add-metadata --embed-subs --sub-langs en.\* -f bestvideo\[height\<\=1080\]\[vcodec\=vp9\]\+bestaudio"
# doasedit
alias doasedit='doas env XDG_RUNTIME_DIR_NONROOT=$XDG_RUNTIME_DIR NONROOTUSER=$USERNAME EDITOR=$EDITOR $HOME/.local/share/shell/scripts/doasedit'
# Managing dotfiles
alias gd='git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'
# Managing notes
alias gn='git --git-dir=$HOME/.local/share/notes/ --work-tree=$HOME/Documents/Notes'
# Safe removal ?
alias rm='rm -Iv'
# Group directories first and add colors in ls
alias ls='ls -hN --color=auto --group-directories-first'
# Color support in grep
alias grep="grep --color=auto"
# Ask if overwriting
alias cp="cp -iv"
alias mv="mv -iv"
