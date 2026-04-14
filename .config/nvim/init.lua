-- Check if plugins are outdated
local function warn_if_plugins_outdated()
	local lockfile = vim.fn.stdpath('config') .. '/nvim-pack-lock.json'

	local stat = vim.loop.fs_stat(lockfile)
	if not stat then
		vim.notify("Warning! lazy-lock.json not found", vim.log.levels.WARN)
		return
	end

	local last_modified = stat.mtime.sec
	local current_time = os.time()
	local one_week = 7 * 24 * 60 * 60

	if current_time - last_modified > one_week then
		vim.notify("Warning! You have not updated your plugins in at least a week", vim.log.levels.WARN)
	end
end

-- Call the function on startup
warn_if_plugins_outdated()


--------------------
-- Vim Options
--------------------
--
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
--
local startup_augroup = vim.api.nvim_create_augroup('startup_augroup', {clear = true})
local autocmd = vim.api.nvim_create_autocmd
autocmd('BufEnter', { pattern = '*', group = startup_augroup,
	callback = function() vim.opt.formatoptions:remove('r'); vim.opt.formatoptions:remove('o') end,
})
autocmd('BufEnter', { pattern = {'*.h', '*.cl'}, group = startup_augroup,
	callback = function()
		vim.opt.filetype = 'c'
	end,
})
autocmd('FileType', { pattern = {'c', 'cpp', 'typst'}, group = startup_augroup,
	callback = function()
		vim.opt.commentstring = '// %s'
	end,
})
autocmd('FileType', { pattern = {'tex', 'bib'}, group = startup_augroup,
	callback = function()
		vim.bo.indentexpr = ''
	end,
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
-- delete buffer but do not ruin the window layout
nnoremap('<leader>bd', '<cmd>bp|bd #<cr>')
-- change directory to the current file
nnoremap('<leader>cd', '<cmd>lcd %:p:h<cr><cmd>pwd<cr>')
-- navigation in command mode
cnoremap('<a-h>', '<left>')
cnoremap('<a-j>', '<down>')
cnoremap('<a-k>', '<up>')
cnoremap('<a-l>', '<right>')


-----------
-- Plugins
-----------
--

-- Onedark
vim.pack.add({'https://github.com/navarasu/onedark.nvim'})

require('onedark').setup({style = 'darker'})
require('onedark').load()

-- Icons
vim.pack.add({'https://github.com/nvim-tree/nvim-web-devicons'})

-- Lualine
vim.pack.add({'https://github.com/nvim-lualine/lualine.nvim'})
require('lualine').setup()

-- Bufferline
vim.pack.add({'https://github.com/akinsho/nvim-bufferline.lua'})

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
vim.pack.add({{ src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') }})

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

-- Lspconfig
vim.pack.add({'https://github.com/neovim/nvim-lspconfig'})

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
vim.pack.add({'https://github.com/nvim-treesitter/nvim-treesitter'})

local ts_filetypes = {
	'c', 'python', 'tex', 'latex', 'typst', 'bibtex', 'bash', 'lua', 'cpp', 'css', 'html', 'make',
	'markdown', 'meson', 'sql', 'json', 'json5', 'yaml', 'vimdoc'
}
-- require('nvim-treesitter').install(ts_filetypes)
-- filetypes and ts names are different which is why both tex and latex are used. tex causes error
-- with install
autocmd('FileType', { pattern = ts_filetypes, group = startup_augroup,
	callback = function()
		vim.treesitter.start()
	end,
})

-- Indent Guides
vim.pack.add({'https://github.com/saghen/blink.indent'})

require('blink.indent').setup({
	static = {
		char= '│',
	},
	scope = {
		char= '│',
	},
})

-- Telescope
vim.pack.add({'https://github.com/nvim-lua/plenary.nvim',}) -- 'nvim-telescope/telescope-fzf-native.nvim'})
vim.pack.add({{ src = 'https://github.com/nvim-telescope/telescope.nvim', version = vim.version.range('*'), }})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
vim.keymap.set('n', '<leader>tg', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>tG', builtin.live_grep, {})
vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
vim.keymap.set('n', '<leader>td', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>tr', builtin.lsp_references, {})
-- require('telescope').load_extension('fzf')

-- Snippet
vim.pack.add({{ src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range('v2.*') }})

local ls = require("luasnip")
vim.keymap.set({"i", "s"}, "<C-j>", function() ls.expand_or_jump(1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-k>", function() ls.jump(-1) end, {silent = true})
require("luasnip.loaders.from_snipmate").lazy_load()

-- Surround
vim.pack.add({{ src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("4.*"), }})

require('nvim-surround').setup()

-- Autopairs
vim.pack.add({'https://github.com/windwp/nvim-autopairs'})

require('nvim-autopairs').setup()

-- Leap
vim.pack.add({'https://codeberg.org/andyg/leap.nvim'})

vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
vim.keymap.set({'n', 'x', 'o'}, 'S', '<Plug>(leap-backward)')

-- Neoscroll
vim.pack.add({'https://github.com/karb94/neoscroll.nvim'})

require('neoscroll').setup()

-- SVED
autocmd('FileType', { pattern = 'tex', once = true,
	callback = function(args)
		vim.pack.add({'https://github.com/peterbjorgensen/sved'})
		if vim.g.loaded_evinceSync == nil then
		  vim.cmd('source ' .. vim.fn.stdpath('data') .. '/site/pack/core/opt/sved/ftplugin/tex_evinceSync.vim')
		end
		vim.keymap.set('n', '<leader>lv', ':call SVED_Sync()<cr>', {})
	end
})


-- ToggleTerm
vim.pack.add({'https://github.com/akinsho/toggleterm.nvim'})

require('toggleterm').setup()
inoremap('<c-t>', '<cmd>ToggleTerm direction=float<cr>')
nnoremap('<c-t>', '<cmd>ToggleTerm direction=float<cr>')
tnoremap('<c-t>', '<cmd>ToggleTerm direction=float<cr>')

-- Iron.nvim
autocmd('FileType', { pattern = 'python', group = startup_augroup,
	callback = function(args)
		vim.pack.add({'https://github.com/Vigemus/iron.nvim'})

		local function get_python_executable_and_change_dir()
			local filepath = vim.api.nvim_buf_get_name(0)

			if filepath ~= "" then
				filedir = vim.fn.fnamemodify(filepath, ":p:h")
			else
				filedir = vim.fn.getcwd()
			end

			local ipython_path = filedir .. "/.ipython"

			if vim.fn.executable(ipython_path) == 1 then
				vim.cmd('cd ' .. filedir)
				return {ipython_path, "--no-autoindent"}
			elseif vim.fn.executable("ipython") == 1 then
				return {"ipython", "--no-autoindent"}
			else
				return {"python", "--no-autoindent"}
			end
		end

		require('iron.core').setup({
			config = {
				highlight_last = '',
				repl_definition = {
					python = {
						command = get_python_executable_and_change_dir(),
						format = require('iron.fts.common').bracketed_paste_python,
						block_dividers = { "# %%", "#%%" },
					},
				},
				repl_open_cmd = require('iron.view').split.vertical.rightbelow("%40")
			},
			keymaps = {
				toggle_repl = "<space>rr",
				restart_repl = "<space>rR",
				send_file = "<space>rf",
			},
		})

		local opts = { buffer = args.buf, silent = true }
		vim.keymap.set( 'n', '<cr>',
			function()
				require('iron.core').send_code_block(true)
			end,
			opts
		)
		vim.keymap.set( 'v', '<cr>',
			function()
				require('iron.core').visual_send()
			end,
			opts
		)
	end
}
)
