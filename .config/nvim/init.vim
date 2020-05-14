"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes\

" Neovim Completion Manager 2
" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-ultisnips'

" OneDark Theme
Plug 'rakr/vim-one'

" Vim Airline
Plug 'vim-airline/vim-airline'

" C Syntax Highlighting Enhancement
Plug 'octol/vim-cpp-enhanced-highlight'

" NerdTree
Plug 'preservim/nerdtree'

" Easymotion
Plug 'easymotion/vim-easymotion'

" Syntax Checker
Plug 'dense-analysis/ale'

"Snippet Support
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"Commenting
Plug 'preservim/nerdcommenter'

"Bracket, quotation Completion
Plug 'jiangmiao/auto-pairs'

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" USER DEFINED SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Enable Buffer History Even After Switching buffers
set hidden

" Caps Lock Mapped to Esc
"autocmd VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
"autocmd VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

"""""""""
" PlugIns
"""""""""
" For Neovim Completion Manager
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
" Use Enter to select suggestions
imap <expr> <CR> pumvisible() ? ((complete_info()["selected"] == "-1") ? "\<C-n>\<C-y>\<Plug>(ultisnips_expand)" : "\<C-y>\<Plug>(ultisnips_expand)") : "\<CR>"
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"disable arrow keys
inoremap <expr> <up> pumvisible() ? "<C-y><up>":"<up>"
inoremap <expr> <down> pumvisible() ? "<C-y><down>":"<down>"
inoremap <expr> <left> pumvisible() ? "<C-y><left>":"<left>"
inoremap <expr> <right> pumvisible() ? "<C-y><right>":"<right>"
" popup menu height and width
set pumheight=5
"set pumwidth=15

"Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsSnippetDirectories=["UltiSnips", "/home/moshiur/.local/share/nvim/mysnippets"]
let g:UltiSnipsExpandTrigger="<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" For Themes
colorscheme one
set termguicolors

"For vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tab_nr = 0

" For ALE
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_lint_on_text_changed = '0'
let g:ale_lint_on_insert_leave = '0'
nmap <C-e>k <Plug>(ale_previous_wrap)
nmap <C-e>j <Plug>(ale_next_wrap)
imap <C-e>k <Esc><Plug>(ale_previous_wrap)
imap <C-e>j <Esc><Plug>(ale_next_wrap)

" NerdTree Toggle
nnoremap <C-n> :NERDTreeToggle<CR>

"Nerdcommenter
let g:NERDCustomDelimiters = { 'c': { 'left': '//','right': '' } }
imap <C-\> <Esc><leader>c<space>a
nmap <C-\> <leader>c<space>
vmap <C-\> <leader>c<space>

""""""""""""
" UI changes
""""""""""""
set tabstop=4		" width of a tab character
set shiftwidth=4	" width of a tab character in auto indentation
set mouse=a			" using mouse in all modes
set number			" show line number
set relativenumber	" show relative number

"""""""""""""
" Keybindings
"""""""""""""
" copying to + register in normal and visual mode
nnoremap <C-c> "+y
vnoremap <C-c> "+y
" cutting to + register in normal and visual mode
nnoremap <C-x> "+d
vnoremap <C-x> "+d
" pasting from + register in normal, insert and visual mode
nnoremap <C-v> "+p
vnoremap <C-v> "+p
inoremap <C-v> <Esc>"+pa
" enabling ctrl+s in normal and insert mode
nnoremap <C-s> :w<Esc>
inoremap <C-s> <Esc>:w<Esc>a
" selecting all in normal, insert and visual mode
nnoremap <C-a> ggVG$
vnoremap <C-a> <Esc>ggVG$
inoremap <C-a> <Esc>ggVG$

" disabling higlight with Esc
nnoremap <Esc> <Esc>:nohlsearch<CR><Esc>

"cursor movement in insert mode
inoremap <C-h> <Esc>bi
inoremap <C-j> <Esc>j$a
inoremap <C-k> <Esc>k$a
inoremap <C-l> <Esc>ea

"opening the terminal
nnoremap <C-t> :65vs<CR>:terminal bash<CR>
inoremap <C-t> <Esc>:65vs<CR>:terminal bash<CR>
nnoremap <A-t> :15sp<CR>:terminal bash<CR>
inoremap <A-t> <Esc>:15sp<CR>:terminal bash<CR>


""""""""""""""""
" Split Settings
""""""""""""""""
set splitright
set splitbelow
" split Keybindings
" switching windows
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
inoremap <A-h> <Esc><C-w>ha
inoremap <A-j> <Esc><C-w>ja
inoremap <A-k> <Esc><C-w>ka
inoremap <A-l> <Esc><C-w>la
tnoremap <A-h> <C-\><C-n><C-w>ha
tnoremap <A-j> <C-\><C-n><C-w>ja
tnoremap <A-k> <C-\><C-n><C-w>ka
tnoremap <A-l> <C-\><C-n><C-w>la
" resizing windows
nnoremap <C-Left> :vertical resize -1<CR>
nnoremap <C-Down> :resize -1<CR>
nnoremap <C-Up> :resize +1<CR>
nnoremap <C-Right> :vertical resize +1<CR>
inoremap <C-Left> <Esc>:vertical resize -1<CR>a
inoremap <C-Down> <Esc>:resize -1<CR>a
inoremap <C-Up> <Esc>:resize +1<CR>a
tnoremap <C-Right> <C-\><C-n>:vertical resize +1<CR>a
tnoremap <C-Left> <C-\><C-n>:vertical resize -1<CR>a
tnoremap <C-Down> <C-\><C-n>:resize -1<CR>a
tnoremap <C-Up> <C-\><C-n>:resize +1<CR>a
tnoremap <C-Right> <C-\><C-n>:vertical resize +1<CR>a

