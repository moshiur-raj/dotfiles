return require('lazy').setup({
	-- Theme
	{
		'navarasu/onedark.nvim'
	},
	-- Statusline
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {'nvim-tree/nvim-web-devicons'}
	},
	-- Bufferline
	{
		'akinsho/nvim-bufferline.lua',
		dependencies = {'nvim-tree/nvim-web-devicons'}
	},
	-- Fuzzy Finder
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			{'nvim-lua/plenary.nvim'},
			{'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
		}
	},
	-- Snippet
	{
		'L3MON4D3/LuaSnip',
		version = "v2.*",
		build = "make install_jsregexp"
	},
	-- Completion Plugin
	{
	  'saghen/blink.cmp',
	  -- use a release tag to download pre-built binaries
	  version = '1.*',
	},
	-- Lsp
	{
		'neovim/nvim-lspconfig'
	},
	-- Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		branch = 'main',
		build = ':TSUpdate'
	},
	-- Indentaion Guide
	{
		'lukas-reineke/indent-blankline.nvim'
	},
	-- Surround Text
	{
		'kylechui/nvim-surround'
	},
	-- Sneak Motion
	{
		'ggandor/leap.nvim',
		dependencies = {'tpope/vim-repeat'}
	},
	-- Smooth Scroll
	{
		'karb94/neoscroll.nvim'
	},
	-- Auto Pairs
	{
		'windwp/nvim-autopairs'
	},
	-- Latex Support
	{
		'lervag/vimtex',
		ft = {'latex', 'tex'},
		-- Forward and Inverse sync for evince
		dependencies = {'peterbjorgensen/sved'}
	},
	-- ToggleTerm
	{
		'akinsho/toggleterm.nvim'
	},
	-- Interactive REPL
	{
		'Vigemus/iron.nvim',
		ft = {'python'},
	}
})
