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
-- filetype of header files should be c
vim.cmd('autocmd BufEnter *.h set filetype=c')
-- use // for commenting in c code
vim.cmd('autocmd BufEnter *.c,*.h setlocal commentstring=//%s')
-- run current python script
vim.cmd('autocmd FileType python nnoremap <buffer> <f10> <cmd>!python "%"<cr>')


---------------
-- Keybindings
---------------
--
local function tcode(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local function keymap(mode, key, map, arg)
	return vim.api.nvim_set_keymap(mode, key, map, arg)
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
	return vim.api.nvim_set_keymap('c', key, map, {expr = false, noremap = true})
end
local function tnoremap(key, map)
	return vim.api.nvim_set_keymap('t', key, map, {expr = false, noremap = true, silent = true})
end
-- use ctrl + s to save, ctrl + c to copy, ctrl + x to cut, ctl + v to paste
inoremap('<c-s>', '<c-o><cmd>update<cr>')
nnoremap('<c-s>', '<cmd>update<cr>')
vnoremap('<c-c>', '"+y')
vnoremap('<c-x>', '"+x')
inoremap('<c-v>', '<esc>"+pa')
nnoremap('<c-v>', '"+p')
vnoremap('<c-v>', '"+p')
nnoremap('<a-v>', '<c-v>') -- visual block mode compatibility
-- use esc to cancel search highlights
nnoremap('<esc>', '<esc><cmd>nohlsearch<cr>')
-- move between windows
nnoremap('<c-h>', '<c-w>h')
nnoremap('<c-j>', '<c-w>j')
nnoremap('<c-k>', '<c-w>k')
nnoremap('<c-l>', '<c-w>l')
tnoremap('<c-h>', '<c-\\><c-N><c-w>h')
tnoremap('<c-j>', '<c-\\><c-N><c-w>j')
tnoremap('<c-k>', '<c-\\><c-N><c-w>k')
tnoremap('<c-l>', '<c-\\><c-N><c-w>l')
-- close window
nnoremap('<c-q>', '<cmd>:quit<cr>')
-- resize window
nnoremap('<c-left>', '<cmd>vertical resize -1<cr>')
nnoremap('<c-down>', '<cmd>resize -1<cr>')
nnoremap('<c-up>', '<cmd>resize +1<cr>')
nnoremap('<c-right>', '<cmd>vertical resize +1<cr>')
tnoremap('<c-left>', '<c-\\><c-N><c-w>h')
tnoremap('<c-down>', '<c-\\><c-N><c-w>j')
tnoremap('<c-up>', '<c-\\><c-N><c-w>k')
tnoremap('<c-right>', '<c-\\><c-N><c-w>l')
-- move between tabs
nnoremap('<a-h>', '<cmd>tabprev<cr>')
nnoremap('<a-l>', '<cmd>tabnext<cr>')
tnoremap('<a-h>', '<c-\\><c-N><cmd>tabprev<cr>')
tnoremap('<a-l>', '<c-\\><c-N><cmd>tabnext<cr>')
-- reorder tabs
nnoremap('<a-L>', '<cmd>tabmove +1<cr>')
nnoremap('<a-H>', '<cmd>tabmove -1<cr>')
-- delete buffer but do not ruin the window layout
nnoremap('<leader>bd', '<cmd>bp|bd #<cr>')
-- change directory to the current file
nnoremap('<leader>cd', '<cmd>lcd %:p:h<cr><cmd>pwd<cr>')
-- navigation in command mode
cnoremap('<a-h>', '<left>')
cnoremap('<a-j>', '<down>')
cnoremap('<a-k>', '<up>')
cnoremap('<a-l>', '<right>')
-- opening terminal
nnoremap('<c-t>', '<cmd>rightbelow 55 vsplit +terminal<cr>')
nnoremap('<a-t>', '<cmd>rightbelow 15 split +terminal<cr>')
--


-----------
-- Plugins
-----------
--
-- Packer

-- Onedark
require('onedark').setup()

-- Lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = {left = '|', right = '|'},
    section_separators = {left = '', right = ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {{'location'}, {'diagnostics', sources = {'nvim_lsp'}}}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive', 'nvim-tree'}
}

-- Bufferline
require('bufferline').setup({
  options = {
	numbers = 'ordinal',
	right_mouse_command = nil,
    diagnostics = 'nvim_lsp',
	diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return '('..count..')'
    end,
	offsets = {{filetype = 'NvimTree', text = 'File Explorer', text_align = 'left'}},
	-- do not show terminals in bufferline
	custom_filter = function(bufn)
		if not string.match(vim.fn.bufname(bufn), 'term://') then
			return true
		end
	end,
  }
})
-- pick a buffer
nnoremap('gb', '<cmd>BufferLinePick<cr>')
-- move between buffers
nnoremap('<a-j>', '<cmd>BufferLineCycleNext<cr>')
nnoremap('<a-k>', '<cmd>BufferLineCyclePrev<cr>')
tnoremap('<a-j>', '<cmd><c-\\><c-N>BufferLineCycleNext<cr>')
tnoremap('<a-k>', '<cmd><c-\\><c-N>BufferLineCyclePrev<cr>')
-- reorder buffer
nnoremap('<a-J>', '<cmd>BufferLineMoveNext<cr>')
nnoremap('<a-K>', '<cmd>BufferLineMovePrev<cr>')

-- Web-devicons
require'nvim-web-devicons'.setup {
 default = true;
}

-- Nvim-tree
require'nvim-tree'.setup {
	disable_netrw       = true,
	hijack_netrw        = true,
	open_on_setup       = false,
	ignore_ft_on_setup  = {},
	update_to_buf_dir   = {
		enable = true,
		auto_open = true,
	},
	auto_close          = false,
	open_on_tab         = false,
	hijack_cursor       = false,
	update_cwd          = false,
	diagnostics     	= {enable = true},
	update_focused_file = {
		enable      = false,
		update_cwd  = false,
		ignore_list = {}
	},
	system_open = {
		cmd  = nil,
		args = {}
	},
	view = {
		width = 40,
		height = 30,
		side = 'left',
		auto_resize = false,
		mappings = {
			custom_only = false,
			list = {}
		}
	}
}
nnoremap('<c-n>', '<cmd>NvimTreeToggle<cr>')

-- Telescope
nnoremap('<leader>tf', '<cmd>Telescope find_files<cr>')
nnoremap('<leader>tF', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
nnoremap('<leader>tg', '<cmd>Telescope live_grep<cr>')
nnoremap('<leader>tb', '<cmd>Telescope buffers<cr>')
nnoremap('<leader>th', '<cmd>Telescope help_tags<cr>')

-- Scrollview

-- Nvim-cmp
vim.o.completeopt = 'menu,menuone,noselect'
 -- Setup nvim-cmp.
local cmp = require('cmp')
cmp.setup({
 snippet = {
	 expand = function(args)
		 -- For `vsnip` user.
		 -- vim.fn["vsnip#anonymous"](args.body)

		 -- For `luasnip` user.
		 -- require('luasnip').lsp_expand(args.body)

		 -- For `ultisnips` user.
		 vim.fn["UltiSnips#Anon"](args.body)
	 end,
 },
 mapping = {
	 -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
	 -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
	 -- ['<C-Space>'] = cmp.mapping.complete(),
	 -- ['<C-e>'] = cmp.mapping.close(),
	 ['<CR>'] = cmp.mapping.confirm({ select = true }),
	 ['<ESC>'] = cmp.mapping.close(),
	 ['<TAB>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
	 ['<S-TAB>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
 },
 sources = {
	 { name = 'ultisnips', keyword_length = 3 },
	 { name = 'nvim_lsp' },
	 -- { name = 'omni', keyword_length = 0},
	 { name = 'buffer', keyword_length = 7 },
	 { name = 'path' },
	 { name = 'spell', keyword_length = 7 },
 }
})
-- vimtex integration
vim.cmd(string.gsub([[
autocmd FileType tex lua require('cmp').setup.buffer{
sources = {
{ name = 'ultisnips', keyword_length = 3 },
{ name = 'nvim_lsp' },
{ name = 'omni', keyword_length = 0},
{ name = 'buffer', keyword_length = 7 },
{ name = 'path' },
{ name = 'spell', keyword_length = 7 },
}
}
]], '\n', ''))
-- lsp integration
require('lspconfig')['clangd'].setup {
	capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
require('lspconfig')['pyright'].setup {
	capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
-- autopairs integration
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done())

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
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

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
local servers = {'pyright', 'clangd'}
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
require('nvim-treesitter.configs').setup{
  highlight = {enable = true},
  -- indent = {enable = true}
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

-- Ultisnips
-- custom snippets directory
vim.g.UltiSnipsSnippetDirectories ={'Ultisnips', vim.env.HOME .. '/.local/share/nvim/mysnippets'}
-- keymaps
vim.g.UltiSnipsExpandTrigger = '<plug>(ultisnips_expand)'
vim.g.UltiSnipsJumpForwardTrigger = '<TAB>'
vim.g.UltiSnipsJumpBackwardTrigger = '<S-TAB>'

-- Sneak

-- Neoscroll
require('neoscroll').setup()
-- Vimtex
vim.g.tex_flavor = 'latex'

-- Fugitive
