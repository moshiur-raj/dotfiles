# quick edit
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

FUZZY_FINDER=("fzf" "--border" "--height" "60%")

CONFIG_FILES=(~/.local/bin $XDG_CONFIG_HOME/{bashrc,nvim,zsh,mpv,alacritty,npm,environment.d,shell} $XDG_DATA_HOME/applications ~/Nextcloud/Notes ~/coding ~/todo ~/notes ~/research ~/Templates)

find_files() {
	find ${CONFIG_FILES[@]} \( -path "*/.cache" -o -path "*/.clangd" -o -path "*/.git" -o -path "*.pdf" -o -path "*.pdf_tex" -o -path "*.mkv" -o -path "*.svg" -o -path "*.glsl" -o -path "*.png" -o -path "*.jpg" \) -prune -o -type f -print
}
# edit config files
edit_config_file() {
	local file
	file=$(find_files | $FUZZY_FINDER)
	zle redisplay

	if [ -n "$file" ]; then
		BUFFER="$EDITOR \"$file\""
		zle accept-line
	else
		echo "No file selected."
	fi
}
zle -N edit_config_file
bindkey "^e" edit_config_file

# fuzzy completion
fuzzy_completion() {
	LBUFFER="${LBUFFER}$(find_files | $FUZZY_FINDER | xargs -d "\n" printf "%q" )"
	zle redisplay
}

zle -N fuzzy_completion
bindkey "^f" fuzzy_completion
