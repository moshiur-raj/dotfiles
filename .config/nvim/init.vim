""""""""""
" PLUGINS
""""""""""
call plug#begin(system('echo -n $HOME/.local/share/nvim/plugged'))

Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-jedi'
let g:ncm2_ultisnips#source = {'priority': 9}
Plug 'ncm2/ncm2-ultisnips' 


Plug 'dense-analysis/ale'
Plug 'lervag/vimtex' 
Plug 'bfrg/vim-cpp-modern'
Plug 'tpope/vim-commentary'

Plug 'SirVer/ultisnips'
Plug 'justinmk/vim-sneak'
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-surround'

call plug#end()

" One Dark Theme
colorscheme one

" Ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
let g:ncm2_pyclang#Library_path = '/usr/lib/libclang.so'
let g:ncm2_pyclang#database_path = ['compile_commands.json']
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
imap <expr> <cr> pumvisible() ? ncm2_ultisnips#expand_or("\<cr>", 'n') : "\<plug>(PearTreeExpand)"

" Vimtex
let g:tex_flavor = 'latex'

" Pear Tree
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
let g:pear_tree_map_special_keys = 0
imap <bs> <plug>(PearTreeBackspace)

" Vim Airlime
let g:airline_section_z = '%p%% ln:%l/%L ☰ cn:%c'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Vim Sneak
let g:sneak#label = 1

" Ultisnips
let g:UltiSnipsSnippetDirectories=["UltiSnips", system('echo -n $HOME/.local/share/nvim/mysnippets')]
let g:UltiSnipsExpandTrigger="<plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger="<a-j>"
let g:UltiSnipsJumpBackwardTrigger="<a-k>"

" Ale
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
nmap <a-j> <plug>(ale_next_wrap)
nmap <a-k> <plug>(ale_previous_wrap)

autocmd FileType c let b:ale_linters=['clang']
autocmd FileType python let b:ale_linters=['flake8']
autocmd FileType tex let b:ale_linters=['chktex']

" Vim-Commentary
autocmd FileType c setlocal commentstring=//%s


""""""""""
" OPTIONS
""""""""""
set tabstop=4
set shiftwidth=4
set mouse=a
set termguicolors
set number
set relativenumber
set cursorline
set hidden
set pumheight=8

autocmd BufEnter * set formatoptions -=r | set formatoptions-=o
autocmd FileType c,python,sh setlocal colorcolumn=100
autocmd FileType text,tex,markdown setlocal spell spelllang=en_us

" Change directory to current file
nnoremap <leader>cd :lcd %:p:h<cr>

" Netrw
let g:netrw_banner=0
let g:netrw_liststyle=3


""""""""""""""
" KEYBINDINGS
""""""""""""""
nnoremap <c-s> :write<cr>
inoremap <c-s> <c-o>:write<cr>
inoremap <c-v> <esc>"+pa
vnoremap <c-c> "+y
vnoremap <c-x> "+x
vnoremap <c-v> "+p
nnoremap <c-v> "+p
nnoremap <a-v> <c-v>

noremap <s-h> 0
noremap <s-l> $
noremap 0	  <s-h>
noremap $	  <s-l>

nnoremap <silent> <esc> <esc>:nohlsearch<cr>

" Navigation in Command Mode
cnoremap <a-h> <left>
cnoremap <a-j> <down>
cnoremap <a-k> <up>
cnoremap <a-l> <right>

" Switching Windows
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
inoremap <c-h> <c-o><c-w>h
inoremap <c-j> <c-o><c-w>j
inoremap <c-k> <c-o><c-w>k
inoremap <c-l> <c-o><c-w>l
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

" Opening Terminal
nnoremap <c-t> :let $TERM_DIR=expand('%:p:h')<cr>:rightbelow 55 vsplit +terminal<cr>icd $TERM_DIR && clear<cr>
nnoremap <a-t> :let $TERM_DIR=expand('%:p:h')<cr>:rightbelow 15 split +terminal<cr>icd $TERM_DIR && clear<cr>
