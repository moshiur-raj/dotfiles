# Prompt
PS1=" \e[32m\W >>> "

#History
HISTFILE=$HOME/.cache/.histfile

# Use nvim for man
MANPAGER='nvim +Man!'

#Source aliases
source $HOME/.local/share/shell/alias.sh

# VTE Support
[ $TILIX_ID ] || [ $VTE_VERSION ] && source /etc/profile.d/vte.sh
