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
vim.cmd('autocmd FileType text,tex,markdown,html setlocal spell spelllang=en_us')
-- filetype of header files should be c
vim.cmd('autocmd BufEnter *.h set filetype=c')
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

-- Onedark
require('onedark').load()

-- Lualine
require('lualine').setup({
  extensions = {'nvim-tree'}
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
cmp.event:on( 'confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())

-- Lspconfig
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local servers = {'pyright', 'clangd'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
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
  indent = {enable = false},
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

-- Lightspeed
require('lightspeed').setup({
  limit_ft_matches = 32,
})

-- Neoscroll
require('neoscroll').setup()

-- Vimtex
vim.g.tex_flavor = 'latex'

-- Autotag
require('nvim-ts-autotag').setup()
