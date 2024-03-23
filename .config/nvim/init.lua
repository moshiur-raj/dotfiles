----------------
-- Load Plugins
----------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
require('plugins')


--------------------
-- Vim Options
--------------------
--
vim.opt.backupcopy = 'yes'
vim.opt.foldenable = false
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
autocmd('FileType', { pattern = {'text', 'latex', 'markdown', 'html'}, group = startup_augroup,
	callback = function() vim.opt.spell.spellang = 'en_us' end,
})
vim.cmd('autocmd FileType text,tex,markdown,html setlocal spell spelllang=en_us')
-- filetype changes
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
--disable middle mouse paste
inoremap('<MiddleMouse>', '<nop>')
nnoremap('<MiddleMouse>', '<nop>')
vnoremap('<MiddleMouse>', '<nop>')
cnoremap('<MiddleMouse>', '<nop>')
tnoremap('<MiddleMouse>', '<nop>')
-- disable omni completion when pression ctrl+n or ctrl+p
inoremap('<c-n>', '<nop>')
inoremap('<c-p>', '<nop>')
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
require('onedark').setup {
    style = 'cool'
}
require('onedark').load()

-- Lualine
require('lualine').setup({
	-- options = {
	-- 	component_separators={left='|', right='|'},
	-- 	section_separators = {},
	-- }
})

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
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fF', builtin.current_buffer_fuzzy_find, {})

-- Cmp
vim.o.completeopt = 'menu,menuone,noselect'
local cmp = require('cmp')
cmp.setup({
	snippet = {
		expand = function(args)
			require 'snippy'.expand_snippet(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	sources = {
		{ name = 'snippy', keyword_length = 2 },
		{ name = 'nvim_lsp' },
		{ name = 'buffer', keyword_length = 5 },
		{ name = 'path' },
	},
	mapping = {
		['<cr>'] = cmp.mapping.confirm({ select = false }),
		['<tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
		['<s-tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
	}
})

-- Snippy
require('snippy').setup({
    mappings = {
        is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
        },
        nx = {
            ['<leader>x'] = 'cut_text',
        },
    },
})

-- Lspconfig
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = false
servers = {'pyright', 'clangd', 'texlab'}
for i = 1, #servers do
	require('lspconfig')[servers[i]].setup{ capabilities = capabilities }
end

-- Treesitter
require('nvim-treesitter.configs').setup({
	ensure_installed = {'c', 'python', 'latex', 'bibtex', 'bash', 'lua', 'cpp', 'css', 'html', 'make', 'markdown', 'meson', 'sql', 'json', 'json5', 'yaml', 'vimdoc'},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = {'latex'},
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
		disable = {'latex'},
	}
})

-- Indent-blankline
require('ibl').setup({
	indent = {
		char = '│',
		smart_indent_cap = true,
		-- highlight = { "declaration", "expression", "pattern", "primary_expression", "statement", "switch_body", "function" }
	},
	whitespace = {
		remove_blankline_trail = true,
	},
	scope = {
		enabled = true,
		char = '│',
		show_start = false,
		show_end = false,
	}
})

-- Comment.nvim
require('Comment').setup()

-- Surround
require('nvim-surround').setup()

-- Autopairs
local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
npairs.setup({
	disable_filetype = { "TelescopePrompt" },
	-- fast_wrap = {},
})
cmp.event:on( 'confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done() )
npairs.add_rules({
	Rule("\'","","tex"),
	Rule("\\(","\\)","tex"),
	Rule("\\{","\\}","tex"),
	Rule("\\[","\\]","tex"),
	Rule("\\left(","\\right)","tex"),
	Rule("\\left\\{","\\right\\}","tex"),
	Rule("\\left[","\\right]","tex"),
	Rule("\\left|","\\right|","tex"),
})

-- Leap
require('leap').set_default_keymaps()

-- Neoscroll
require('neoscroll').setup()

--- Vimtex
vim.g.vimtex_matchparen_enabled = 0
vim.g.vimtex_indent_enabled = 0
vim.g.vimtex_motion_enabled = 0
vim.g.vimtex_imaps_enabled = 0
vim.g.tex_flavor = 'latex'
vim.g.vimtex_complete_enabled = 0
-- vim.g.vimtex_quickfix_ignore_filters = {'Underfull \\\\hbox (badness 10000)', '`h\' float specifier changed to `ht\''}
