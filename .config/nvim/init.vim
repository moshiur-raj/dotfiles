""""""""""
" PLUGINS
""""""""""
call plug#begin(system('echo -n $HOME/.local/share/nvim/plugged'))

Plug 'navarasu/onedark.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'hrsh7th/nvim-compe'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lervag/vimtex' 
Plug 'tpope/vim-commentary'

Plug 'SirVer/ultisnips'
Plug 'justinmk/vim-sneak'
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

" One Dark Theme
colorscheme onedark

" Compe
set completeopt=menuone,noselect
lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    omni = {filetypes = {'tex'}};
    path = true;
    buffer = false;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    ultisnips = true;
  };
}
EOF
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
imap <expr> <cr> (complete_info()["selected"] != "-1") ? compe#confirm({'keys': "\<plug>(ultisnips_expand)", 'mode': ''}) : "\<plug>(PearTreeExpand)"
inoremap <expr> <c-y> compe#close('<c-y>')

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
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0
nmap <a-h> <Plug>AirlineSelectPrevTab
nmap <a-l> <Plug>AirlineSelectNextTab

" Vim Sneak
let g:sneak#label = 1

" Ultisnips
let g:UltiSnipsSnippetDirectories=["UltiSnips", system('echo -n $HOME/.local/share/nvim/mysnippets')]
let g:UltiSnipsExpandTrigger="<plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger="<a-j>"
let g:UltiSnipsJumpBackwardTrigger="<a-k>"

" Treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup{
  highlight = {
    enable = true,
  },
}
EOF

" Lsp
lua << EOF
require'lspconfig'.clangd.setup{
root_dir = require('lspconfig/util').root_pattern("compile_commands.json")
}
require'lspconfig'.pyright.setup{}

local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local opts = { noremap=true, silent=true }
buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
EOF

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
" For fzf.vim
tnoremap <a-j> <c-j>
tnoremap <a-k> <c-k>

" Opening Terminal
nnoremap <c-t> :let $TERM_DIR=expand('%:p:h')<cr>:rightbelow 55 vsplit +terminal<cr>icd $TERM_DIR && clear<cr>
nnoremap <a-t> :let $TERM_DIR=expand('%:p:h')<cr>:rightbelow 15 split +terminal<cr>icd $TERM_DIR && clear<cr>

" Run the current file
autocmd FileType python nnoremap <buffer> <f10> :!python "%"<cr>
