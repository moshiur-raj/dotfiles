----------------------------------------------------------------------------------------------------
-- Custom Lua Modules
----------------------------------------------------------------------------------------------------

require("check_last_update")
require("plugins")


----------------------------------------------------------------------------------------------------
-- Vim Options
----------------------------------------------------------------------------------------------------

vim.opt.backupcopy = "yes"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = false
vim.opt.foldenable = false
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "100"
vim.opt.tw = 100
vim.g.tex_flavor = "latex"

----------------------------------------------------------------------------------------------------
-- Autocommands
----------------------------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("formatoptions", { clear = true }),
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local file = vim.api.nvim_buf_get_name(0)
		if file ~= "" and vim.fn.isdirectory(file) == 0 then
			vim.uv.chdir(vim.fs.dirname(file))
		end
	end,
})


----------------------------------------------------------------------------------------------------
-- Keybindings
----------------------------------------------------------------------------------------------------

-- use ctrl + s to save, ctrl + c to copy, ctrl + x to cut, ctl + v to paste
vim.keymap.set({"i", "n"}, "<c-s>", "<cmd>update<cr>")
vim.keymap.set("v", "<c-c>", "\"+y")
vim.keymap.set("v", "<c-x>", "\"+x")
vim.keymap.set("i", "<c-v>", "<c-r>+")
vim.keymap.set({"n", "v"}, "<c-v>", "\"+p")
vim.keymap.set("n", "<a-v>", "<c-v>") -- visual block mode compatibility
-- use esc to cancel search highlights
vim.keymap.set("n", "<esc>", "<esc><cmd>nohlsearch<cr>")
-- move between windows
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")
vim.keymap.set("t", "<c-h>", [[<c-\\><c-N><c-w>h]])
vim.keymap.set("t", "<c-j>", [[<c-\\><c-N><c-w>j]])
vim.keymap.set("t", "<c-k>", [[<c-\\><c-N><c-w>k]])
vim.keymap.set("t", "<c-l>", [[<c-\\><c-N><c-w>l]])
-- close window
vim.keymap.set("n", "<c-q>", "<cmd>quit<cr>")
-- resize window
vim.keymap.set("n", "<c-left>",  "<cmd>vertical resize -1<cr>")
vim.keymap.set("n", "<c-down>",  "<cmd>resize -1<cr>")
vim.keymap.set("n", "<c-up>",    "<cmd>resize +1<cr>")
vim.keymap.set("n", "<c-right>", "<cmd>vertical resize +1<cr>")
vim.keymap.set("t", "<c-left>",  [[<c-\><c-n><cmd>vertical resize -1<cr>i]])
vim.keymap.set("t", "<c-down>",  [[<c-\><c-n><cmd>resize -1<cr>i]])
vim.keymap.set("t", "<c-up>",    [[<c-\><c-n><cmd>resize +1<cr>i]])
vim.keymap.set("t", "<c-right>", [[<c-\><c-n><cmd>vertical resize +1<cr>i]])
-- delete buffer but do not ruin the window layout
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>")
-- change directory to the current file
vim.keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h | pwd<cr>")
-- navigation in command mode
vim.keymap.set("c", "<a-h>", "<left>")
vim.keymap.set("c", "<a-j>", "<down>")
vim.keymap.set("c", "<a-k>", "<up>")
vim.keymap.set("c", "<a-l>", "<right>")


----------------------------------------------------------------------------------------------------
-- Plugins
----------------------------------------------------------------------------------------------------

-- Theme
----------------------------------------------------------------------------------------------------
require("onedark").setup({style = "darker"})
require("onedark").load()

-- Statusline
----------------------------------------------------------------------------------------------------
require("lualine").setup()

-- Bufferline
----------------------------------------------------------------------------------------------------
require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return level:match("error") and " " or ""
		end,
		right_mouse_command = "",
	}
})
-- move between buffers
vim.keymap.set("n", "<a-j>", "<cmd>BufferLineCycleNext<cr>")
vim.keymap.set("n", "<a-k>", "<cmd>BufferLineCyclePrev<cr>")
vim.keymap.set("t", "<a-j>", "<cmd><c-\\><c-N>BufferLineCycleNext<cr>")
vim.keymap.set("t", "<a-k>", "<cmd><c-\\><c-N>BufferLineCyclePrev<cr>")
-- reorder buffer
vim.keymap.set("n", "<a-J>", "<cmd>BufferLineMoveNext<cr>")
vim.keymap.set("n", "<a-K>", "<cmd>BufferLineMovePrev<cr>")

-- Completion
----------------------------------------------------------------------------------------------------
require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<cr>"] = {"accept", "fallback"},
		["<s-tab>"] = {"select_prev", "fallback"},
		["<tab>"] = {"select_next", "fallback"},
	},
	completion = {
		list = {
			selection = {
				preselect = false,
				auto_insert = true,
			}
		}
	},
	cmdline = {
		completion = { 
			list = {
				selection = {
					preselect = false,
					auto_insert = true,
				}
			}
		},
	},
	sources = {
		default = { "lsp", "buffer", "snippets", "path" },
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
		preset = "luasnip",
	}
})

-- Lsp
----------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
--
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	end,
})

vim.lsp.config("texlab", {
	settings = { texlab = { build = { onSave = true } } },
	filetypes = {"tex", "bib"}
})

vim.lsp.config("harper_ls", {
    capabilities = { textDocument = { semanticTokens = { multilineTokenSupport = true } } },
	filetypes = {"markdown", "text", "tex", "typst"},
})

vim.lsp.enable({"ty", "clangd", "texlab", "harper_ls"})

-- Treesitter
----------------------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
	callback = function(arg)
		local lang = vim.treesitter.language.get_lang(arg.match)
		if vim.treesitter.language.add(lang) then
			vim.treesitter.start()
		else
			local parsers = require("nvim-treesitter.config").get_available()
			if vim.tbl_contains(parsers, lang) then
				require("nvim-treesitter").install(lang):wait()
				vim.treesitter.start()
			end
		end
	end,
})

-- Indent Guides
----------------------------------------------------------------------------------------------------
require("blink.indent").setup({
	static = {
		char= "│",
	},
	scope = {
		char= "│",
	},
})

-- Telescope
----------------------------------------------------------------------------------------------------
vim.keymap.set("n", "gf", require("telescope.builtin").find_files)
vim.keymap.set("n", "gb", require("telescope.builtin").buffers)
require("telescope").load_extension("fzf")

-- Snippet
----------------------------------------------------------------------------------------------------
vim.keymap.set({"i", "s"}, "<C-j>", function() require("luasnip").expand_or_jump(1) end)
vim.keymap.set({"i", "s"}, "<C-k>", function() require("luasnip").jump(-1) end)
require("luasnip.loaders.from_snipmate").lazy_load()

-- Surround
----------------------------------------------------------------------------------------------------
require("nvim-surround").setup()

-- Autopairs
----------------------------------------------------------------------------------------------------
require("nvim-autopairs").setup()

-- Motion
----------------------------------------------------------------------------------------------------
vim.keymap.set({"n", "x", "o"}, "s", "<Plug>(leap)")
vim.keymap.set({"n", "x", "o"}, "S", "<Plug>(leap-backward)")

-- Neoscroll
----------------------------------------------------------------------------------------------------
require("neoscroll").setup()

-- ToggleTerm
----------------------------------------------------------------------------------------------------
require("toggleterm").setup()
vim.keymap.set("i", "<c-t>", "<cmd>ToggleTerm direction=float<cr>")
vim.keymap.set("n", "<c-t>", "<cmd>ToggleTerm direction=float<cr>")
vim.keymap.set("t", "<c-t>", "<cmd>ToggleTerm direction=float<cr>")
