----------------
-- Load Plugins
----------------
require('plugins')


--------------------
-- Vim Options
--------------------
--
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.mouse = 'a'
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.hidden = true
vim.o.pumheight = 8
vim.o.pumwidth = 16
--
vim.cmd('autocmd BufEnter * set formatoptions -=r | set formatoptions-=o')
vim.cmd('autocmd FileType c,python,sh setlocal colorcolumn=100')
vim.cmd('autocmd FileType text,tex,markdown setlocal spell spelllang=en_us')
vim.cmd('autocmd BufEnter *.h set filetype=c')
vim.cmd('autocmd FileType c setlocal commentstring=//%s')


---------------
-- Keybindings
---------------
--
local function termcode(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local function inoremap(key, map)
	return vim.api.nvim_set_keymap('i', key, map, {expr = false, noremap = true, silent = true})
end
local function nnoremap(key, map)
	return vim.api.nvim_set_keymap('n', key, map, {expr = false, noremap = true, silent = true})
end
local function vnoremap(key, map)
	return vim.api.nvim_set_keymap('v', key, map, {expr = false, noremap = true, silent = true})
end
local function cnoremap(key, map)
	return vim.api.nvim_set_keymap('c', key, map, {expr = false, noremap = true, silent = true})
end
local function tnoremap(key, map)
	return vim.api.nvim_set_keymap('t', key, map, {expr = false, noremap = true, silent = true})
end
-- use ctrl + s to save, ctrl + c to copy, ctrl + x to cut, ctl + v to paste
inoremap('<c-s>', '<c-o>:update<cr>')
nnoremap('<c-s>', ':update<cr>')
vnoremap('<c-c>', '"+y')
vnoremap('<c-x>', '"+x')
inoremap('<c-v>', '<esc>"+pa')
nnoremap('<c-v>', '"+p')
vnoremap('<c-v>', '"+p')
nnoremap('<a-v>', '<c-v>') -- visual block mode compatibility
-- use esc to cancel search highlights
nnoremap('<esc>', '<esc>:nohlsearch<cr>')
-- move between windows
nnoremap('<c-h>', '<c-w>h')
nnoremap('<c-j>', '<c-w>j')
nnoremap('<c-k>', '<c-w>k')
nnoremap('<c-l>', '<c-w>l')
tnoremap('<c-h>', '<c-\\><c-N><c-w>h')
tnoremap('<c-j>', '<c-\\><c-N><c-w>j')
tnoremap('<c-k>', '<c-\\><c-N><c-w>k')
tnoremap('<c-l>', '<c-\\><c-N><c-w>l')
-- move between tabs
nnoremap('<a-h>', ':tabprev<cr>')
nnoremap('<a-l>', ':tabnext<cr>')
tnoremap('<a-h>', '<c-\\><c-N>:tabprev<cr>')
tnoremap('<a-l>', '<c-\\><c-N>:tabnext<cr>')
-- reorder tabs
nnoremap(']t', ':tabmove +1<cr>')
nnoremap('[t', ':tabmove -1<cr>')
-- delete buffer but do not ruin the window layout
nnoremap('<leader>bd', ':bp|bd #<cr>')
-- change directory to the current file
nnoremap('<leader>cd', 'cd :lcd %:p:h<cr>')
-- navigation in command mode
cnoremap('<c-h>', '<left>')
cnoremap('<c-j>', '<down>')
cnoremap('<c-k>', '<up>')
cnoremap('<c-l>', '<right>')
-- opening terminal
nnoremap('<c-t>', ':let $TERM_DIR=expand(\'%:p:h\')<cr>:rightbelow 55 vsplit +terminal<cr>icd $TERM_DIR && clear<cr>')
nnoremap('<a-t>', ':let $TERM_DIR=expand(\'%:p:h\')<cr>:rightbelow 15 split +terminal<cr>icd $TERM_DIR && clear<cr>')
-- run current python script
vim.cmd('autocmd FileType python nnoremap <buffer> <f10> :!python "%"<cr>')
--
-- plugin-specific
--
-- move between buffers
nnoremap('<a-j>', ':BufferLineCycleNext<cr>')
nnoremap('<a-k>', ':BufferLineCyclePrev<cr>')
tnoremap('<a-j>', ':<c-\\><c-N>BufferLineCycleNext<cr>')
tnoremap('<a-k>', ':<c-\\><c-N>BufferLineCyclePrev<cr>')
-- reorder buffer
nnoremap(']b', ':BufferLineMoveNext')
nnoremap('[b', ':BufferLineMovePrev')
-- toggle nvim-tree
nnoremap('<c-n>', ':NvimTreeToggle<cr>')
-- Telescope
nnoremap('<leader>tf', '<cmd>Telescope find_files<cr>')
nnoremap('<leader>tF', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
nnoremap('<leader>tg', '<cmd>Telescope live_grep<cr>')
nnoremap('<leader>tb', '<cmd>Telescope buffers<cr>')
nnoremap('<leader>th', '<cmd>Telescope help_tags<cr>')
-- Compe
vim.cmd('inoremap <expr> <tab> pumvisible() ? "<c-n>" : "<tab>"')
vim.cmd('inoremap <expr> <s-tab> pumvisible() ? "<c-p>" : "<s-tab>"')
vim.cmd('inoremap <expr> <c-y> compe#close(\'<c-y>\')')

-----------
-- Plugins
-----------
--
-- Packer

-- Onedark
require('onedark').setup()

-- Lualine
require('lualine').setup({
	options = {
		theme = 'onedark'
	}
})

-- Bufferline
require('bufferline').setup({
  options = {
	numbers = "ordinal",
	number_style = "",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
	offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left"}}
  }
})

-- Web-devicons
require'nvim-web-devicons'.setup {
 default = true;
}

-- Nvim-tree
vim.g.nvim_tree_width = 50

-- Telescope

-- Scrollview

-- Compe
require('compe').setup {
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
		path = true;
		buffer = false;
		calc = true;
		nvim_lsp = true;
		nvim_lua = true;
		ultisnips = true;
	};
}

-- Lspconfig
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
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "clangd" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
	capabilities = capabilities,
  }
end

-- Treesitter
require'nvim-treesitter.configs'.setup{
  highlight = {
    enable = true,
  },
}

-- Indent-blankline
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

-- Commentary

-- Surround

-- Autopairs
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true -- it will auto insert `(` after select function or method item
})

-- Ultisnips
vim.cmd('let g:UltiSnipsSnippetDirectories=["UltiSnips", system(\'echo -n $HOME/.local/share/nvim/mysnippets\')]')
vim.g.UltiSnipsExpandTrigger = '<plug>(ultisnips_expand)'
vim.g.UltiSnipsJumpForwardTrigger = '<a-j>'
vim.g.UltiSnipsJumpBackwardTrigger = '<a-k>'

-- Sneak

-- Neoscroll
require('neoscroll').setup()
-- Vimtex
vim.g.tex_flavor = 'latex'

-- Fugitive
