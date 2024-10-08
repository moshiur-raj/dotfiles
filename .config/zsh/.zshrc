# Load pathces
source $HOME/.config/shell/patches.sh
# Add .local/bin to path
export PATH="$PATH:$HOME/.local/bin"

#Enable colors and change prompt
autoload -U colors && colors
PS1="%B%F{magenta} %2~ %B%F{red}＞ %b%f"

# Disable ctrl-s to freeze terminal
stty stop undef

# History Size
HISTSIZE=1000
SAVEHIST=1000

# Autocompletion
zstyle ':completion:*' menu select
# Case insensitive matchinng
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files
setopt COMPLETE_ALIASES	# completion for alisases

# Use cd as a replacement for pushd
setopt autopushd

# vi mode
bindkey -v
bindkey -v '^?' backward-delete-char
export KEYTIMEOUT=1 # Wait 0.1s for key sequences
# bindkey "^?" backward-delete-char # Making backspace work properly in vi mode
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
bindkey -M vicmd j history-substring-search-down
bindkey -M vicmd k history-substring-search-up

# Fuzzy completion
source $XDG_CONFIG_HOME/shell/fuzzy-completion.sh

# Souce aliases
source $XDG_CONFIG_HOME/shell/alias.sh

# Clear output in termux
[[ $HOSTNAME == "Termux" ]] && clear
