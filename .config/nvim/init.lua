----------------
-- Load Plugins
----------------
require('plugins')


--------------------
-- Vim Options
--------------------
--
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.pumheight = 8
vim.opt.pumwidth = 16
--
local startup_augroup = vim.api.nvim_create_augroup('startup_augroup', {clear = true})
local autocmd = vim.api.nvim_create_autocmd
autocmd('BufEnter', { pattern = '*', group = startup_augroup,
	callback = function() vim.opt.formatoptions:remove('r'); vim.opt.formatoptions:remove('o') end,
})
autocmd('FileType', { pattern = {'c', 'python', 'sh'}, group = startup_augroup,
	callback = function() vim.opt.colorcolumn = "100" end,
})
autocmd('FileType', { pattern = {'text', 'tex', 'markdown', 'html'}, group = startup_augroup,
	callback = function() vim.opt.spell.spellang = 'en_us' end,
})
vim.cmd('autocmd FileType text,tex,markdown,html setlocal spell spelllang=en_us')
-- filetype of header files should be c
autocmd('BufEnter', { pattern = '*.h', group = startup_augroup,
	callback = function() vim.opt.filetype = 'c' end,
})


---------------
-- Keybindings
---------------
--
local function inoremap(key, map)
	return vim.keymap.set('i', key, map, {expr = false, noremap=true, silent = true})
end
local function nnoremap(key, map)
	return vim.keymap.set('n', key, map, {expr = false, noremap=true, silent = true})
end
local function vnoremap(key, map)
	return vim.keymap.set('v', key, map, {expr = false, noremap=true, silent = true})
end
local function cnoremap(key, map)
	return vim.keymap.set('c', key, map, {expr = false, noremap=true})
end
local function tnoremap(key, map)
	return vim.keymap.set('t', key, map, {expr = false, noremap=true, silent = true})
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

-- Onedark
require('onedark').load()

-- Lualine
require('lualine').setup()

-- Bufferline
require('bufferline').setup({
	options = {
		numbers = 'ordinal',
		right_mouse_command = nil,
		-- do not show terminals in bufferline
		custom_filter = function(bufn)
			if not string.match(vim.fn.bufname(bufn), 'term://') then
				return true
			end
		end,
	}
})
-- move between buffers
nnoremap('<a-j>', '<cmd>BufferLineCycleNext<cr>')
nnoremap('<a-k>', '<cmd>BufferLineCyclePrev<cr>')
tnoremap('<a-j>', '<cmd><c-\\><c-N>BufferLineCycleNext<cr>')
tnoremap('<a-k>', '<cmd><c-\\><c-N>BufferLineCyclePrev<cr>')
-- reorder buffer
nnoremap('<a-J>', '<cmd>BufferLineMoveNext<cr>')
nnoremap('<a-K>', '<cmd>BufferLineMovePrev<cr>')

-- Telescope
nnoremap('<leader>td', '<cmd>Telescope diagnostics<cr>')
nnoremap('<leader>tr', '<cmd>Telescope lsp_references<cr>')
nnoremap('<leader>tf', '<cmd>Telescope find_files<cr>')
nnoremap('<leader>tF', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
nnoremap('<leader>tg', '<cmd>Telescope live_grep<cr>')
nnoremap('<leader>tb', '<cmd>Telescope buffers<cr>')
nnoremap('<leader>th', '<cmd>Telescope help_tags<cr>')

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
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {
		['<cr>'] = cmp.mapping.confirm({ select = false }),
		['<c-y>'] = cmp.mapping.close(),
		['<tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
		['<s-tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'snippy', keyword_length = 2 },
		{ name = 'buffer', keyword_length = 5 },
		{ name = 'path' },
	}
})

-- Lspconfig
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = 'rounded'}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = 'rounded'}),
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
    flags = lsp_flags,
	handlers = handlers,
}
require('lspconfig')['clangd'].setup{
    on_attach = on_attach,
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
    flags = lsp_flags,
	handlers = handlers,
}

-- Treesitter
require('nvim-treesitter.configs').setup({
	ensure_installed = {'c', 'python', 'latex', 'bibtex', 'bash', 'lua', 'cpp', 'css', 'html', 'make', 'markdown', 'meson', 'sql', 'json', 'json5'},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = {'latex'},
		additional_vim_regex_highlighting = false,
	},
})

-- Indent-blankline
require('indent_blankline').setup({
    show_current_context = true,
    show_current_context_start = false,
	show_trailing_blankline_indent = false,
	strict_tabs = true,
	char = '┊',
	use_treesitter = true,
	context_patterns = { "declaration", "expression", "pattern", "primary_expression", "statement", "switch_body", "function" }
})

-- Comment.nvim
require('Comment').setup()

-- Surround
require('nvim-surround').setup()

-- Autopairs
require('nvim-autopairs').setup({
	disable_filetype = { "TelescopePrompt", "tex" },
	fast_wrap = {},
})
cmp.event:on( 'confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done() )

-- Snippy
require('snippy').setup({
	mappings = {
		is = {
			["<tab>"] = "expand_or_advance",
			["<s-tab>"] = "previous",
		},
	},
})

-- Leap
require('leap').set_default_keymaps()

-- Neoscroll
require('neoscroll').setup()

-- Vimtex
vim.g.tex_flavor = 'latex'

local vimtex_augroup = vim.api.nvim_create_augroup('vimtex_augroup', {clear = true})
autocmd('FileType', { pattern = 'tex', group = vimtex_augroup,
callback = function() require('cmp').setup.buffer {
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
				buffer = "[Buffer]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = 'snippy', keyword_length = 2 },
		{ name = 'nvim_lsp' },
		{ name = 'omni' },
		{ name = 'buffer', keyword_length = 5 },
		{ name = 'path' },
	}
} end,
})
