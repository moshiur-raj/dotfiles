""""""""""
" PLUGINS
""""""""""
call plug#begin(system('echo -n $HOME/.local/share/nvim/plugged'))

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-jedi'
let g:ncm2_ultisnips#source = {'priority': 9}
Plug 'ncm2/ncm2-ultisnips' 

Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline'

Plug 'justinmk/vim-sneak'

Plug 'dense-analysis/ale'
Plug 'bfrg/vim-cpp-modern'

Plug 'lervag/vimtex' 
Plug 'SirVer/ultisnips'

Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

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
inoremap <expr> <cr> ncm2_ultisnips#expand_or("\<cr>", 'n')

" Vimtex
let g:tex_flavor = 'latex'

" Pear Tree
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_map_special_keys = 0

" Vim Airlime
let g:airline_section_z = '%p%% ln:%l/%L ☰ cn:%c'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Vim Sneak
map s <plug>Sneak_s
" map S <plug>Sneak_S
omap s <plug>Sneak_s
omap S <plug>Sneak_S

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
let g:ale_tex_lacheck_executable = v:null

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
set iskeyword-=_

autocmd BufEnter * set formatoptions -=r | set formatoptions-=o
autocmd FileType c,python,shell setlocal colorcolumn=100
autocmd FileType text,tex,markdown setlocal spell spelllang=en_us

" Change directory to current file
nnoremap <leader>cd :lcd %:p:h<cr>

" Netrw
let g:netrw_banner=0
let g:netrw_liststyle=3


""""""""""""""
" KEYBINDINGS
""""""""""""""
nnoremap <c-s> :update<cr>
inoremap <c-s> <c-o>:update<cr>
inoremap <c-v> <esc>"+pa
vnoremap <c-c> "+y
vnoremap <c-x> "+x
vnoremap <c-v> "+p
nnoremap <c-v> "+p
nnoremap <a-v> <c-v>

nnoremap <esc> <esc>:nohlsearch<cr>

" Navigation in Command Mode
cnoremap <C-h> <left>
cnoremap <C-j> <down>
cnoremap <C-k> <up>
cnoremap <C-l> <right>

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
nnoremap <c-t> :rightbelow 55 vsplit<cr>:terminal<cr>
nnoremap <a-t> :rightbelow 15 split<cr>:terminal<cr>
