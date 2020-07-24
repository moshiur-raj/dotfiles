"""""""""""""""""""""""
" ININIALIZING CONFIGS
"""""""""""""""""""""""
if ! filereadable(system('echo -n "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"'))
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

" Deoplete
" Plug 'Shougo/deoplete.nvim'
" Plug 'Shougo/deoplete-clangx'
" Plug 'deoplete-plugins/deoplete-jedi'

" Themes
Plug 'rakr/vim-one'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'joshdick/onedark.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'dracula/vim', { 'as': 'dracula' }

" Vim Airline
Plug 'vim-airline/vim-airline'

"Syntax Highlighting Enhancement
Plug 'octol/vim-cpp-enhanced-highlight'

"latex Support
Plug 'lervag/vimtex'

" NerdTree
Plug 'preservim/nerdtree'

" Jump to locations
Plug 'justinmk/vim-sneak'

" Syntax Checker
Plug 'dense-analysis/ale'

"Snippet Support
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"Bracket, quotation Completion
Plug 'jiangmiao/auto-pairs'

"Commenting
Plug 'tpope/vim-commentary'

"git Support
Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()


"""""""""""
" PlugIns
"""""""""""

" Neovim Completion Manager 2
" enable ncm2 for all buffers
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
let g:ncm2#popup_delay = 5
" Fuzzy matcher
" let g:ncm2#matcher = 'substrfuzzy'

"Deoplete
" let g:deoplete#enable_at_startup = 1
" set completeopt-=preview
" call deoplete#custom#option({
" 			\ 'auto_refresh_delay': 0,
" 			\ 'num_processes': 0,
" 			\ 'refresh_always': v:false,
" 			\ 'smart_case': v:true,
" 			\ })
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#source('_', 'sorters', ['sorter_word'])
" call deoplete#custom#var('omni', 'input_patterns', {
" 			\ 'tex': g:vimtex#re#deoplete
" 			\})

"Ultisnips
let g:UltiSnipsSnippetDirectories=["UltiSnips", system('echo -n "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/mysnippets"')]
let g:UltiSnipsExpandTrigger="<Plug>(ultisnips_expand)"
" let g:UltiSnipsJumpForwardTrigger="<TAB>"

" Themes
colorscheme one

"Syntax Highlighting
let g:cpp_posix_standard = 1

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
" Use patched fonts
let g:airline_powerline_fonts = 1

" For ALE
let g:ale_c_gcc_options='-std=gnu17 -Wall'
let g:ale_c_clang_options='-std=c17 -Wall'
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_lint_on_text_changed = '0'
let g:ale_lint_on_enter = '0'
let g:ale_lint_on_insert_leave = '0'
"nmap <C-e>k <Plug>(ale_previous_wrap)
"nmap <C-e>j <Plug>(ale_next_wrap)
"imap <C-e>k <Esc><Plug>(ale_previous_wrap)
"imap <C-e>j <Esc><Plug>(ale_next_wrap)

" NerdTree Toggle
nnoremap <C-n> :NERDTreeToggle<CR>

"Vim-Commentary
autocmd FileType c setlocal commentstring=//%s

"AutoPairs
"let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsMapBS = 1
let g:AutoPairsMapCR = 1
let g:AutoPairsFlyMode = 0
let g:AutoPairsMapCh = 0
let g:AutoPairsCenterLine = 0
let g:AutoPairsMapSpace = 0
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''


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
" popup menu height and width
set pumheight=5
"set pumwidth=15
" Enable Buffer History Even After Switching buffers
set hidden
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %
" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e
" Caps Lock Mapped to Esc
"autocmd VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
"autocmd VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" Use Enter to select suggestions
imap <expr> <CR> pumvisible() ? ((complete_info()["selected"] == "-1") ? "\<C-n>\<C-y>\<Plug>(ultisnips_expand)" : "\<C-y>\<Plug>(ultisnips_expand)") : "\<CR>"
"disable arrow keys
inoremap <expr> <up> pumvisible() ? "<C-y><up>":"<up>"
inoremap <expr> <down> pumvisible() ? "<C-y><down>":"<down>"
inoremap <expr> <left> pumvisible() ? "<C-y><left>":"<left>"
inoremap <expr> <right> pumvisible() ? "<C-y><right>":"<right>"

"Using Tab for selecting suggestions and jumping to locations in snippets
let g:ulti_jump_forwards_res = 0
function! s:ulti_jump_forwards()
	call UltiSnips#JumpForwards()
	return g:ulti_jump_forwards_res
endfunction

function! s:i_tab()
	return pumvisible() ? "\<C-n>" : (<SID>ulti_jump_forwards() ? "" : "\<Tab>")
endfunction
inoremap <silent> <TAB> <C-R>=(<SID>i_tab())<CR>

let g:ulti_jump_backwards_res = 0
function! s:ulti_jump_backwards()
    call UltiSnips#JumpBackwards()
    return g:ulti_jump_backwards_res
endfunction

function! s:i_stab()
	return pumvisible() ? "\<C-p>" : (<SID>ulti_jump_backwards() ? "" : "\<S-Tab>")
endfunction
inoremap <silent> <S-TAB> <C-R>=(<SID>i_stab())<CR>

"""""""""""""""
" Keybindings
"""""""""""""""
" copying to + register in normal and visual mode
vnoremap <C-c> "+y
" cutting to + register in normal and visual mode
vnoremap <C-x> "+d
" pasting from + register in normal, insert and visual mode
nnoremap <C-v> "+p
vnoremap <C-v> "+p
inoremap <C-v> <Esc>"+pa
" enabling ctrl+s in normal and insert mode
nnoremap <C-s> :w<Esc>
inoremap <C-s> <Esc>:w<Esc>a

" disabling higlight with Esc
nnoremap <Esc> <Esc>:nohlsearch<CR>

"opening the terminal
nnoremap <C-t> :lcd %:p:h<CR>:65vs<CR>:terminal<CR>
inoremap <C-t> <Esc>:lcd %:p:h<CR>:65vs<CR>:terminal<CR>
nnoremap <A-t> :lcd %:p:h<CR>:15sp<CR>:terminal<CR>
inoremap <A-t> <Esc>:lcd %:p:h<CR>:15sp<CR>:terminal<CR>

" Terminal mappings
tnoremap <Esc> <C-\><C-N>
tnoremap <C-\><C-N> <Esc>

"changing directory to current file directory
nnoremap cd :lcd %:p:h<CR>

"makefile integration
nmap <f9> :lcd %:p:h<CR>:make<CR>

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

"bracket completion for {<CR>}
"inoremap <silent> {<CR> {<CR>}<ESC>O
