return require('packer').startup(function()
	-- Plugin Manager
	use 'wbthomason/packer.nvim'
	-- Icons
	use 'nvim-tree/nvim-web-devicons'
	-- Theme
	use 'navarasu/onedark.nvim'
	-- Statusline
	use {
		'nvim-lualine/lualine.nvim',
		requires = {'nvim-tree/nvim-web-devicons', opt = true}
	}
	-- Bufferline
	use {
		'akinsho/nvim-bufferline.lua',
		requires = 'nvim-tree/nvim-web-devicons'
	}
	-- Fuzzy Finder
	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}
	-- Scroll View
	use 'dstein64/nvim-scrollview'
	-- Completion Plugin
	use {
		'hrsh7th/nvim-cmp',
		requires = {{'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'}, {'hrsh7th/cmp-nvim-lsp'}, {'hrsh7th/cmp-omni'}, {'dcampos/cmp-snippy'}}
	}
	-- Lsp
	use 'neovim/nvim-lspconfig'
	-- Treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	-- Indentaion Guide
	use 'lukas-reineke/indent-blankline.nvim'
	-- Commenting
	use 'numToStr/Comment.nvim'
	-- Surround Text
	use 'kylechui/nvim-surround'
	-- Auto Pairs
	use 'windwp/nvim-autopairs'
	-- Snippet Support
	use 'dcampos/nvim-snippy'
	-- Sneak Motion
	use {
		'ggandor/leap.nvim',
		requires = {'tpope/vim-repeat'}
	}
	-- Smooth Scroll
	use 'karb94/neoscroll.nvim'
	-- Latex Support
	use 'lervag/vimtex'
end)
