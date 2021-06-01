let b:pear_tree_pairs = {
			\ '(': {'closer': ')'},
			\ '[': {'closer': ']'},
			\ '{': {'closer': '}'},
			\ "'": {'closer': "'"},
			\ '"': {'closer': '"'},
			\ '$': {'closer': '$'},
			\ '\\{': {'closer': '\\}'},
			\ '\\[': {'closer': '\\]'},
			\ '\\left(': {'closer': '\\right)'},
			\ '\\left{': {'closer': '\\right}'},
			\ '\\left[': {'closer': '\\right]'}
			\ }

let b:surround_{char2nr('1')} = "\\( \r \\)"
let b:surround_{char2nr('2')} = "\\{ \r \\}"
let b:surround_{char2nr('3')} = "\\[ \r \\]"
let b:surround_{char2nr('!')} = "\\left( \r \\right)"
let b:surround_{char2nr('@')} = "\\left\\{ \r \\right\\}"
let b:surround_{char2nr('#')} = "\\left[ \r \\right]"

" Vim-Tex Integration for ncm2
augroup my_ncm2_vimtex_setup
	autocmd!
	autocmd BufEnter <buffer> call ncm2#register_source({
			\ 'name' : 'vimtex-cmds',
			\ 'priority': 8,
			\ 'complete_length': -1,
			\ 'scope': ['tex'],
			\ 'matcher': {'name': 'prefix', 'key': 'word'},
			\ 'word_pattern': '\w+',
			\ 'complete_pattern': g:vimtex#re#ncm2#cmds,
			\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
			\ })
	autocmd BufEnter <buffer> call ncm2#register_source({
			\ 'name' : 'vimtex-labels',
			\ 'priority': 8,
			\ 'complete_length': -1,
			\ 'scope': ['tex'],
			\ 'matcher': {'name': 'combine',
			\             'matchers': [
			\               {'name': 'substr', 'key': 'word'},
			\               {'name': 'substr', 'key': 'menu'},
			\             ]},
			\ 'word_pattern': '\w+',
			\ 'complete_pattern': g:vimtex#re#ncm2#labels,
			\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
			\ })
	autocmd BufEnter <buffer> call ncm2#register_source({
			\ 'name' : 'vimtex-files',
			\ 'priority': 8,
			\ 'complete_length': -1,
			\ 'scope': ['tex'],
			\ 'matcher': {'name': 'combine',
			\             'matchers': [
			\               {'name': 'abbrfuzzy', 'key': 'word'},
			\               {'name': 'abbrfuzzy', 'key': 'abbr'},
			\             ]},
			\ 'word_pattern': '\w+',
			\ 'complete_pattern': g:vimtex#re#ncm2#files,
			\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
			\ })
	autocmd BufEnter <buffer> call ncm2#register_source({
			\ 'name' : 'bibtex',
			\ 'priority': 8,
			\ 'complete_length': -1,
			\ 'scope': ['tex'],
			\ 'matcher': {'name': 'combine',
			\             'matchers': [
			\               {'name': 'prefix', 'key': 'word'},
			\               {'name': 'abbrfuzzy', 'key': 'abbr'},
			\               {'name': 'abbrfuzzy', 'key': 'menu'},
			\             ]},
			\ 'word_pattern': '\w+',
			\ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
			\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
			\ })
augroup END
