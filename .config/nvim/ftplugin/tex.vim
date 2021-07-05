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
			\ '\\left[': {'closer': '\\right]'},
			\ '\\left|': {'closer': '\\right|'},
			\ }

let b:surround_{char2nr('1')} = "\\( \r \\)"
let b:surround_{char2nr('2')} = "\\{ \r \\}"
let b:surround_{char2nr('3')} = "\\[ \r \\]"
let b:surround_{char2nr('!')} = "\\left( \r \\right)"
let b:surround_{char2nr('@')} = "\\left\\{ \r \\right\\}"
let b:surround_{char2nr('#')} = "\\left[ \r \\right]"
