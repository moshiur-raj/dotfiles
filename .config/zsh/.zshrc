#Enable colors and change prompt
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Disable ctrl-s to freeze terminal
stty stop undef

# History
HISTFILE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Autocompletion
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files
setopt COMPLETE_ALIASES	# completion for alisases

# vi mode
bindkey -v
export KEYTIMEOUT=1 # Wait 0.1s for key sequences
bindkey "^?" backward-delete-char # Making backspace work properly in vi mode
# Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
# Change cursor shape for different vi modes
function zle-keymap-select
{
	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} == '' ]] || [[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select
zle-line-init()
{
	zle -K viins # Initiate 'vi insert' as keymap (can be removed if 'bindkey -V' has benn set elsewhere)
	echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup
preexec() { echo -ne '\e[5 q'; } # Use beam shape cursor for each new prompt

# Format the output for time command
TIMEFMT=$'\n%J\ntxt\t%XKB\ndata\t%DKB\nmax\t%MKB\ncpu\t%P\nuser\t%U\nsys\t%S\nreal\t%*Es'

# PLUGINS
# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# History Substring Search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
bindkey -M vicmd j history-substring-search-down
bindkey -M vicmd k history-substring-search-up

# Managing dotfiles
alias git-dotfiles='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
# Safe removal ?
alias rm='rm -I'
# Adding Colors
alias ls='ls -hN --color=auto --group-directories-first'
alias grep='grep --color=auto'
