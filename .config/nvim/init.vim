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
Plug 'lukas-reineke/indent-blankline.nvim'

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
nmap <a-k> <Plug>AirlineSelectPrevTab
nmap <a-j> <Plug>AirlineSelectNextTab
nnoremap <a-h> :bp<cr>
nnoremap <a-l> :bn<cr>

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
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "clangd" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" Vim-Commentary
autocmd FileType c setlocal commentstring=//%s

" Indent-blankline
lua << EOF
vim.g.indent_blankline_strict_tabs = true
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indentLine_fileType = {'c', 'python', 'sh'}
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
	"abstract_class_declaration", "abstract_method_signature",
	"accessibility_modifier", "ambient_declaration", "arguments", "array",
	"array_pattern", "array_type", "arrow_function", "as_expression",
	"asserts", "assignment_expression", "assignment_pattern",
	"augmented_assignment_expression", "await_expression",
	"binary_expression", "break_statement", "call_expression",
	"call_signature", "catch_clause", "class", "class_body",
	"class_declaration", "class_heritage", "computed_property_name",
	"conditional_type", "constraint", "construct_signature",
	"constructor_type", "continue_statement", "debugger_statement",
	"declaration", "decorator", "default_type", "do_statement",
	"else_clause", "empty_statement", "enum_assignment", "enum_body",
	"enum_declaration", "existential_type", "export_clause",
	"export_specifier", "export_statement", "expression",
	"expression_statement", "extends_clause", "finally_clause",
	"flow_maybe_type", "for_in_statement", "for_statement",
	"formal_parameters", "function", "function_declaration",
	"function_signature", "function_type", "generator_function",
	"generator_function_declaration", "generic_type", "if_statement",
	"implements_clause", "import", "import_alias", "import_clause",
	"import_require_clause", "import_specifier", "import_statement",
	"index_signature", "index_type_query", "infer_type",
	"interface_declaration", "internal_module", "intersection_type",
	"jsx_attribute", "jsx_closing_element", "jsx_element", "jsx_expression",
	"jsx_fragment", "jsx_namespace_name", "jsx_opening_element",
	"jsx_self_closing_element", "labeled_statement", "lexical_declaration",
	"literal_type", "lookup_type", "mapped_type_clause",
	"member_expression", "meta_property", "method_definition",
	"method_signature", "module", "named_imports", "namespace_import",
	"nested_identifier", "nested_type_identifier", "new_expression",
	"non_null_expression", "object", "object_assignment_pattern",
	"object_pattern", "object_type", "omitting_type_annotation",
	"opting_type_annotation", "optional_parameter", "optional_type", "pair",
	"pair_pattern", "parenthesized_expression", "parenthesized_type",
	"pattern", "predefined_type", "primary_expression", "program",
	"property_signature", "public_field_definition", "readonly_type",
	"regex", "required_parameter", "rest_pattern", "rest_type",
	"return_statement", "sequence_expression", "spread_element",
	"statement", "statement_block", "string", "subscript_expression",
	"switch_body", "switch_case", "switch_default", "switch_statement",
	"template_string", "template_substitution", "ternary_expression",
	"throw_statement", "try_statement", "tuple_type",
	"type_alias_declaration", "type_annotation", "type_arguments",
	"type_parameter", "type_parameters", "type_predicate",
	"type_predicate_annotation", "type_query", "unary_expression",
	"union_type", "update_expression", "variable_declaration",
	"variable_declarator", "while_statement", "with_statement",
	"yield_expression"
}
EOF


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
autocmd BufEnter *.h set filetype=c

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
