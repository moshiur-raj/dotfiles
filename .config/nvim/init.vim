"""""""""""""""""""""""
" ININIALIZING CONFIGS
"""""""""""""""""""""""
if !filereadable(system('echo -n "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall
endif


"""""""""""""
" Vim-Plug
"""""""""""""

call plug#begin(system('echo -n "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/plugged"'))

" Neovim Completion Manager 2
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-ultisnips'

" Themes
Plug 'rakr/vim-one'

" Statusline
Plug 'vim-airline/vim-airline'

" Syntax highlighting enhancement
" Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'bfrg/vim-cpp-modern'

" Latex support
Plug 'lervag/vimtex'

" Jump to locations
Plug 'justinmk/vim-sneak'

" Syntax checker
Plug 'dense-analysis/ale'

" Snippet support
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Bracket, quotation completion
Plug 'jiangmiao/auto-pairs'

" Commenting
Plug 'tpope/vim-commentary'

" Git support
Plug 'tpope/vim-fugitive'

" Tree viewer
Plug 'preservim/nerdtree'

call plug#end()


"""""""""""
" PlugIns
"""""""""""

" Neovim Completion Manager 2
" Enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
" Vim-Tex integration
augroup my_cm_setup
	autocmd!
	autocmd Filetype tex call ncm2#register_source({
				\ 'name': 'vimtex',
				\ 'priority': 8,
				\ 'scope': ['tex'],
				\ 'mark': 'tex',
				\ 'word_pattern': '\w+',
				\ 'complete_pattern': g:vimtex#re#ncm2,
				\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
				\ })
augroup END
" Make it fast
" let g:ncm2#popup_delay = 5
" Fuzzy matcher
" let g:ncm2#matcher = 'substrfuzzy'
let g:ncm2_pyclang#Library_path = '/usr/lib/libclang.so'
let g:ncm2_pyclang#database_path = ['compile_commands.json']

" Ultisnips
let g:UltiSnipsSnippetDirectories=["UltiSnips", system('echo -n "$HOME/.local/share/nvim/mysnippets"')]
let g:UltiSnipsExpandTrigger="<Plug>(ultisnips_expand)"
" let g:UltiSnipsJumpForwardTrigger="<TAB>"
" let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"

" Themes
colorscheme one

" Cpp enhanced highlighting
let g:cpp_posix_standard = 1

" Vim airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
" Use patched fonts
" let g:airline_powerline_fonts = 1

" For ALE
let g:ale_c_cc_executable='clang'
let g:ale_c_cc_options='-std=gnu11 -Wall'
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_lint_on_text_changed = '0'
let g:ale_lint_on_enter = '0'
let g:ale_lint_on_insert_leave = '0'
" nmap <C-e>k <Plug>(ale_previous_wrap)
" nmap <C-e>j <Plug>(ale_next_wrap)
" imap <C-e>k <Esc><Plug>(ale_previous_wrap)
" imap <C-e>j <Esc><Plug>(ale_next_wrap)

" Vim-Commentary
autocmd FileType c setlocal commentstring=//%s

" AutoPairs
" Disabled due to compalitibility issues with ncm2, made custom map for cr below
let g:AutoPairsMapCR = 0
let g:AutoPairsFlyMode = 0
let g:AutoPairsMapCh = 0
let g:AutoPairsCenterLine = 0
let g:AutoPairsMapSpace = 0
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''

" Vimtex
let g:tex_flavor = 'latex'

" Nerd Tree
nnoremap <C-n> :NERDTreeToggle<CR>


""""""""""""""""""
" OTHER SETTINGS
""""""""""""""""""

" Basics
set tabstop=4		" width of a tab character
set shiftwidth=4	" width of a tab character in auto indentation
set mouse=a			" using mouse in all modes
set number			" show line number
set relativenumber	" show relative number
set termguicolors
" Popup menu height and width
set pumheight=5
" set pumwidth=15
" Enable Buffer History Even After Switching buffers
set hidden
" Disables automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Spell-check set to <leader>o, 'o' for 'orthography'
nmap <leader>o :setlocal spell! spelllang=en_us<CR>
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %
" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

" Use Enter to select suggestions, expand snippet or execute autopairs cr
inoremap <silent> <Plug>(MyCR) <CR><C-R>=AutoPairsReturn()<CR>
imap <expr> <CR> pumvisible() ? ((complete_info()["selected"] == "-1") ? "\<C-n>\<C-y>\<Plug>(ultisnips_expand)" : "\<C-y>\<Plug>(ultisnips_expand)") : "\<Plug>(MyCR)"
" Makes arrow keys behave as usual when pum is visible
inoremap <expr> <up> pumvisible() ? "<C-y><up>":"<up>"
inoremap <expr> <down> pumvisible() ? "<C-y><down>":"<down>"
inoremap <expr> <left> pumvisible() ? "<C-y><left>":"<left>"
inoremap <expr> <right> pumvisible() ? "<C-y><right>":"<right>"

" Using Tab for selecting suggestions and jumping to locations in snippets
let g:ulti_jump_forwards_res = 0
function! s:ulti_jump_forwards()
    call UltiSnips#JumpForwards()
    return g:ulti_jump_forwards_res
endfunction

function! s:i_tab()
    return pumvisible() ? "\<C-n>" : <SID>ulti_jump_forwards() ? "" : "\<Tab>"
endfunction
inoremap <silent> <TAB> <C-R>=(<SID>i_tab())<CR>

let g:ulti_jump_backwards_res = 0
function! s:ulti_jump_backwards()
    call UltiSnips#JumpBackwards()
    return g:ulti_jump_backwards_res
endfunction

function! s:i_shift_tab()
    return pumvisible() ? "\<C-p>" : <SID>ulti_jump_backwards() ? "" : "\<S-Tab>"
endfunction
inoremap <silent> <S-TAB> <C-R>=(<SID>i_shift_tab())<CR>

"""""""""""""""
" Keybindings
"""""""""""""""
" Copying to + register in visual mode
vnoremap <C-c> "+y
" Cutting to + register visual mode
vnoremap <C-x> "+d
" Pasting from + register in normal, insert and visual mode
nnoremap <C-v> "+p
nnoremap <A-v> <C-v>
vnoremap <C-v> "+p
inoremap <C-v> <Esc>"+pa
" Enabling ctrl+s in normal and insert mode
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Higlights
set cursorline
" Disable highlights on pressing ESC
nnoremap <Esc> <Esc>:nohlsearch<CR>

" Opening the terminal
nnoremap <C-t> :lcd %:p:h<CR>:rightbelow 65vs<CR>:terminal<CR>
inoremap <C-t> <Esc>:lcd %:p:h<CR>:rightbelow 65vs<CR>:terminal<CR>
nnoremap <A-t> :lcd %:p:h<CR>:rightbelow 15sp<CR>:terminal<CR>
inoremap <A-t> <Esc>:lcd %:p:h<CR>:rightbelow 15sp<CR>:terminal<CR>

" Changing directory to current file directory
nnoremap cd :lcd %:p:h<CR>

" Makefile integration
nmap <f9> :make<CR>

""""""""""""""""
" Split Settings
""""""""""""""""
" set splitright
" set splitbelow
" Switching windows
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
inoremap <A-h> <Esc><C-w>h
inoremap <A-j> <Esc><C-w>j
inoremap <A-k> <Esc><C-w>k
inoremap <A-l> <Esc><C-w>l
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
" Command mode mappings
cnoremap <C-h> <LEFT>
cnoremap <C-j> <DOWN>
cnoremap <C-k> <UP>
cnoremap <C-l> <RIGHT>
" Resizing windows
nnoremap <C-h> :vertical resize -1<CR>
nnoremap <C-j> :resize -1<CR>
nnoremap <C-k> :resize +1<CR>
nnoremap <C-l> :vertical resize +1<CR>
tnoremap <C-h> <C-\><C-n>:vertical resize -1<CR>a
tnoremap <C-j> <C-\><C-n>:resize -1<CR>a
tnoremap <C-k> <C-\><C-n>:resize +1<CR>a
tnoremap <C-l> <C-\><C-n>:vertical resize +1<CR>a
