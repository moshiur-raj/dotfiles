#Enable colors and change prompt
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History
HISTFILE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000

# vi mode
bindkey -v

# The following lines were added by compinstall
zstyle :compinstall filename '/home/moshiur/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias git-dotfiles='git --git-dir=/home/moshiur/dotfiles/ --work-tree=/home/moshiur'
alias ls='ls --color=auto'
alias rm='rm -I'
