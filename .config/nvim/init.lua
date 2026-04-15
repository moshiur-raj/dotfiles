require('check_last_update')
require('plugins')

----------------------------------------------------------------------------------------------------
-- Vim Options
----------------------------------------------------------------------------------------------------
vim.opt.backupcopy = 'yes'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = false
vim.opt.foldenable = false
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "100"
vim.opt.tw = 100
vim.g.tex_flavor = 'latex'
--
vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('formatoptions', { clear = true }),
	callback = function()
		vim.opt_local.formatoptions:remove({ 'r', 'o' })
	end,
})

----------------------------------------------------------------------------------------------------
-- Keybindings
----------------------------------------------------------------------------------------------------
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
-- delete buffer but do not ruin the window layout
nnoremap('<leader>bd', '<cmd>bp|bd #<cr>')
-- change directory to the current file
nnoremap('<leader>cd', '<cmd>lcd %:p:h<cr><cmd>pwd<cr>')
-- navigation in command mode
cnoremap('<a-h>', '<left>')
cnoremap('<a-j>', '<down>')
cnoremap('<a-k>', '<up>')
cnoremap('<a-l>', '<right>')


----------------------------------------------------------------------------------------------------
-- Plugins
----------------------------------------------------------------------------------------------------

-- Theme
----------------------------------------------------------------------------------------------------
require('onedark').setup({style = 'darker'})
require('onedark').load()

-- Statusline
----------------------------------------------------------------------------------------------------
require('lualine').setup()

-- Bufferline
----------------------------------------------------------------------------------------------------
require('bufferline').setup({
	options = {
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return level:match('error') and " " .. " " .. count or ""
		end,
		right_mouse_command = '',
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

-- Completion
----------------------------------------------------------------------------------------------------
require('blink.cmp').setup({
	keymap = {
		preset = 'none',
		['<cr>'] = {'accept', 'fallback'},
		['<s-tab>'] = {'select_prev', 'fallback'},
		['<tab>'] = {'select_next', 'fallback'},
	},
	completion = {
		list = {
			selection = {
				preselect = false,
				auto_insert = true,
			}
		}
	},
	sources = {
		default = { 'lsp', 'buffer', 'snippets', 'path' },
		providers = {
			buffer = {
				min_keyword_length = 2,
			},
			snippets = {
				min_keyword_length = 2,
				score_offset = 6,
			},
		}
	},
	snippets = {
		preset = 'luasnip',
	}
})

-- Lsp
----------------------------------------------------------------------------------------------------
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
--
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	end,
})

vim.lsp.config('texlab', {
	settings = { texlab = { build = { onSave = true } } },
	filetypes = {'tex', 'bib'}
})

vim.lsp.config('harper_ls', {
    capabilities = { textDocument = { semanticTokens = { multilineTokenSupport = true } } },
	filetypes = {'markdown', 'text', 'tex', 'typst'},
})

vim.lsp.enable({'ty', 'clangd', 'texlab', 'harper_ls'})

-- Treesitter
----------------------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
	pattern = require('nvim-treesitter.config').get_available(),
	callback = function(arg)
		local lang = vim.treesitter.language.get_lang(arg.match)
		if not vim.treesitter.language.add(lang) then
			require('nvim-treesitter').install(lang):wait()
		end
		vim.treesitter.start()
	end,
})

-- Indent Guides
----------------------------------------------------------------------------------------------------
require('blink.indent').setup({
	static = {
		char= '│',
	},
	scope = {
		char= '│',
	},
})

-- Telescope
----------------------------------------------------------------------------------------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
vim.keymap.set('n', '<leader>tg', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>tG', builtin.live_grep, {})
vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
vim.keymap.set('n', '<leader>td', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>tr', builtin.lsp_references, {})

-- Snippet
----------------------------------------------------------------------------------------------------
local ls = require("luasnip")
vim.keymap.set({"i", "s"}, "<C-j>", function() ls.expand_or_jump(1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-k>", function() ls.jump(-1) end, {silent = true})
require("luasnip.loaders.from_snipmate").lazy_load()

-- Surround
----------------------------------------------------------------------------------------------------
require('nvim-surround').setup()

-- Autopairs
----------------------------------------------------------------------------------------------------
require('nvim-autopairs').setup()

-- Motion
----------------------------------------------------------------------------------------------------
vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
vim.keymap.set({'n', 'x', 'o'}, 'S', '<Plug>(leap-backward)')

-- Neoscroll
----------------------------------------------------------------------------------------------------
require('neoscroll').setup()

-- ToggleTerm
----------------------------------------------------------------------------------------------------
require('toggleterm').setup()
inoremap('<c-t>', '<cmd>ToggleTerm direction=float<cr>')
nnoremap('<c-t>', '<cmd>ToggleTerm direction=float<cr>')
tnoremap('<c-t>', '<cmd>ToggleTerm direction=float<cr>')
