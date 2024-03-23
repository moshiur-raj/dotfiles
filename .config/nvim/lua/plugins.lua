return require('lazy').setup({
	-- Icons
	'nvim-tree/nvim-web-devicons',
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
		dependencies = 'nvim-tree/nvim-web-devicons'
	},
	-- Fuzzy Finder
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	},
	-- Scroll View
	'dstein64/nvim-scrollview',
	-- Completion Plugin
	{
		'hrsh7th/nvim-cmp',
		dependencies = {{'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'}, {'hrsh7th/cmp-nvim-lsp'}, {'quangnguyen30192/cmp-nvim-ultisnips'}}
	},
	-- Snippet Support
	'dcampos/nvim-snippy',
	'dcampos/cmp-snippy',
	-- Lsp
	'neovim/nvim-lspconfig',
	-- Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate'
	},
	-- Indentaion Guide
	'lukas-reineke/indent-blankline.nvim',
	-- Commenting
	'numToStr/Comment.nvim',
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
	'lervag/vimtex',
})
