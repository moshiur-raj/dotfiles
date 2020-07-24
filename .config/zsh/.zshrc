#Enable colors and change prompt
# loading colors
autoload -U colors && colors
# cool colorscheme in prompt
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# making backspace work properly in vi mode
bindkey "^?" backward-delete-char

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

# managing dotfiles
alias git-dotfiles='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
#safe removal ?
alias rm='rm -I'
# color in ls
alias ls='ls --color=auto'
