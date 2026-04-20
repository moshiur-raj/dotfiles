vim.bo.indentexpr = ""

if not vim.g.tex_ftplugin_loaded then
	vim.g.tex_plugins_loaded = true
	vim.pack.add({"https://github.com/peterbjorgensen/sved"})

	if vim.g.loaded_evinceSync == nil then
	  vim.cmd("source " .. vim.fn.stdpath("data") .. "/site/pack/core/opt/sved/ftplugin/tex_evinceSync.vim")
	end

	require"telescope".load_extension("bibtex")
end

local opts = { buffer = vim.api.nvim_get_current_buf(), silent = true }
vim.keymap.set("n", "<leader>lv", "<cmd>call SVED_Sync()<cr>", opts)
vim.keymap.set("n", "gB", "<cmd>Telescope bibtex<cr>", opts)
