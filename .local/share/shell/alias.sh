# doasedit
alias doasedit='doas env NONROOTUSER=$USERNAME EDITOR=$EDITOR $HOME/.local/share/zsh/scripts/doasedit'
# Managing dotfiles
alias gd='git --git-dir=$HOME/.local/share/dotfiles/ --work-tree=$HOME'
# Safe removal ?
alias rm='rm -Iv'
# Group directories first and add colors in ls
alias ls='ls -hN --color=auto --group-directories-first'
# Color support in grep
alias grep="grep --color=auto"
# Ask if overwriting
alias cp="cp -iv"
alias mv="mv -iv"
