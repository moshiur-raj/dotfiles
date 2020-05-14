#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias rm='rm -I'

PS1='\[\033[1;31m\][\[\033[1;32m\]\u@\h \[\033[1;37m\]\W\[\033[1;31m\]]\[\033[1;36m\]\$\[\033[0;37m\]'
