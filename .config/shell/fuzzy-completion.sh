# quick edit
export FUZZY_FINDER=fzf

export FUZZY_COMPLETION_PATHS=(~/.local/bin $XDG_CONFIG_HOME/bashrc ~/Documents $XDG_CONFIG_HOME/{nvim,zsh,mpv,alacritty,environment.d,mimeapps.list,ipython/profile_default,shell} $XDG_DATA_HOME/applications ~/coding ~/todo ~/notes ~/research ~/Nextcloud/Notes ~/Templates)

ef() {
	find ${FUZZY_COMPLETION_PATHS[@]} \( -path "*/.cache" -o -path "*/.clangd" -o -path "*/.git" \) -prune -o -type f -print | $FUZZY_FINDER | xargs -r -d "\n" $EDITOR
}

# fuzzy completion
fuzzy_completion() {
	LBUFFER="${LBUFFER}$(find ${FUZZY_COMPLETION_PATHS[@]} \( -path "*/.cache" -o -path "*/.clangd" -o -path "*/.git" \) -prune -o -print | $FUZZY_FINDER | xargs -d "\n" printf "%q" )"
}
