return require('lazy').setup({
	-- Theme
	'navarasu/onedark.nvim',
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
			{'nvim-lua/popup.nvim'},
			{'nvim-lua/plenary.nvim'}
		}
	},
	-- Scroll View
	'dstein64/nvim-scrollview',
	-- Snippet Support
	'dcampos/nvim-snippy',
	-- Completion Plugin
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'dcampos/cmp-snippy'}
		}
	},
	-- Lsp
	'neovim/nvim-lspconfig',
	-- Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate'
	},
	-- Indentaion Guide
	'lukas-reineke/indent-blankline.nvim',
	-- Surround Text
	'kylechui/nvim-surround',
	-- Auto Pairs
	'windwp/nvim-autopairs',
	-- Sneak Motion
	{
		'ggandor/leap.nvim',
		dependencies = {'tpope/vim-repeat'}
	},
	-- Smooth Scroll
	'karb94/neoscroll.nvim',
	-- Latex Support
	{
		'lervag/vimtex',
		ft={'latex', 'tex'},
		-- Forward and Inverse sync for evince
		dependencies = {'peterbjorgensen/sved'}
	},
	-- ToggleTerm
	{
		'akinsho/toggleterm.nvim', config = true
	}
})
