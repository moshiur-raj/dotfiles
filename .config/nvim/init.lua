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
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_lsp', 'coc'}}},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
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
})

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
require('nvim-web-devicons').setup({
 default = true;
})

-- Nvim-tree
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require('nvim-tree').setup({
	disable_netrw       = true,
	hijack_netrw        = true,
	open_on_setup       = false,
	ignore_ft_on_setup  = {},
	auto_close          = false,
	open_on_tab         = false,
	hijack_cursor       = false,
	update_cwd          = false,
	update_to_buf_dir   = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		}
	},
	update_focused_file = {
		enable      = false,
		update_cwd  = false,
		ignore_list = {}
	},
	system_open = {
		cmd  = nil,
		args = {}
	},
	filters = {
		dotfiles = false,
		custom = {}
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = 'left',
		auto_resize = false,
		mappings = {
			custom_only = false,
			list = {}
		},
		number = false,
		relativenumber = false
	},
	trash = {
		cmd = "trash",
		require_confirm = true
	}
})
nnoremap('<c-n>', '<cmd>NvimTreeToggle<cr>')

-- Telescope
nnoremap('<leader>tf', '<cmd>Telescope find_files<cr>')
nnoremap('<leader>tF', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
nnoremap('<leader>tg', '<cmd>Telescope live_grep<cr>')
nnoremap('<leader>tb', '<cmd>Telescope buffers<cr>')
nnoremap('<leader>th', '<cmd>Telescope help_tags<cr>')

-- Scrollview

-- Cmp
vim.o.completeopt = 'menu,menuone,noselect'
 -- Setup nvim-cmp.
local cmp = require('cmp')
cmp.setup({
 snippet = {
	 expand = function(args)
		 require('snippy').expand_snippet(args.body)
	 end,
 },
 mapping = {
	 ['<cr>'] = cmp.mapping.confirm({ select = false }),
	 ['<c-y>'] = cmp.mapping.close(),
	 ['<tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
	 ['<s-tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
 },
 sources = {
	 { name = 'snippy', keyword_length = 2 },
	 { name = 'nvim_lsp' },
	 { name = 'buffer', keyword_length = 7 },
	 { name = 'path' },
	 { name = 'spell', keyword_length = 7 },
 }
})
-- vimtex integration
vim.cmd(string.gsub([[
autocmd FileType tex lua require('cmp').setup.buffer{
sources = {
{ name = 'snippy', keyword_length = 2 },
{ name = 'nvim_lsp' },
{ name = 'omni' },
{ name = 'buffer', keyword_length = 7 },
{ name = 'path' },
{ name = 'spell', keyword_length = 7 },
}
}
]], '\n', ' '))
-- lsp integration
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['clangd'].setup({
	capabilities = capabilities
})
require('lspconfig')['pyright'].setup({
	capabilities = capabilities
})
-- autopairs integration
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done())

-- Lspconfig
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

end
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {'pyright', 'clangd'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
	capabilities = capabilities,
  })
end

-- Treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = "maintained",
  sync_install = false,
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {'latex'},  -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
  indent = {enable = true},
})

-- Indent-blankline
require('indent_blankline').setup({
    show_current_context = true,
    show_current_context_start = false,
	show_trailing_blankline_indent = false,
	strict_tabs = true,
	char = '┊',
	use_treesitter = true,
	filetype = {'c', 'python', 'sh'},
	context_patterns = {
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
	},
})

-- Commentary

-- Surround

-- Autopairs
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

-- Snippy
require('snippy').setup({
	mappings = {
		is = {
			["<tab>"] = "expand_or_advance",
			["<s-tab>"] = "previous",
		},
	},
})

-- Sneak

-- Neoscroll
require('neoscroll').setup()

-- Vimtex
vim.g.tex_flavor = 'latex'

-- Fugitive
