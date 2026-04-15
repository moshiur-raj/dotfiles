----------------------------------------------------------------------------------------------------
-- Hooks
----------------------------------------------------------------------------------------------------

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
			local path = vim.fn.stdpath('data') .. '/site/pack/core/opt/' .. name
			vim.notify('Building ' .. name .. '...')
			vim.system({ 'make' }, { cwd = path }, function(obj)
				vim.schedule(function()
					if obj.code == 0 then
						vim.notify(name .. ' built successfully')
					else
						vim.notify(name .. ' build failed:\n' .. (obj.stderr or ''),
						vim.log.levels.ERROR)
					end
				end)
			end)
		end
	end,
})


----------------------------------------------------------------------------------------------------
-- Plugins
----------------------------------------------------------------------------------------------------

vim.pack.add({
	'https://github.com/navarasu/onedark.nvim',

	'https://github.com/nvim-tree/nvim-web-devicons',

	'https://github.com/nvim-lualine/lualine.nvim',

	'https://github.com/akinsho/nvim-bufferline.lua',

	{
		src = 'https://github.com/saghen/blink.cmp',
		version = vim.version.range('1.*')
	},

	'https://github.com/neovim/nvim-lspconfig',

	'https://github.com/nvim-treesitter/nvim-treesitter',

	'https://github.com/saghen/blink.indent',

	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
	'https://github.com/nvim-telescope/telescope-bibtex.nvim',

	{
		src = 'https://github.com/L3MON4D3/LuaSnip',
		version = vim.version.range('2.*'),
	},

	{
		src = "https://github.com/kylechui/nvim-surround",
		version = vim.version.range("4.*"),
	},

	'https://github.com/windwp/nvim-autopairs',

	'https://codeberg.org/andyg/leap.nvim',

	'https://github.com/karb94/neoscroll.nvim',

	'https://github.com/akinsho/toggleterm.nvim',
})
