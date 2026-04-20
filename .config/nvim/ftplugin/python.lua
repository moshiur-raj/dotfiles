local function get_python_executable()
	local python = vim.fn.executable("ipython") == 1 and "ipython" or "python"

	local filepath = vim.api.nvim_buf_get_name(0)
	local filedir = filepath ~= "" and vim.fs.dirname(filepath) or vim.fn.getcwd()

	-- Walk up from the file's directory toward $HOME looking for ty.toml
	local ty_toml = vim.fs.find("ty.toml", {
		upward = true,
		path = filedir,
		stop = vim.env.HOME,
		type = "file",
	})[1]

	if ty_toml then
		-- Pull python = "..." (or single-quoted) out of the config
		local content = table.concat(vim.fn.readfile(ty_toml), "\n")
		local venv = content:match([[python%s*=%s*"([^"]+)"]])
		          or content:match([[python%s*=%s*'([^']+)']])

		if venv then
			-- Accept either a venv root or a python-binary path,
			-- and resolve relative paths against the project root.
			venv = venv:gsub("/bin/python[%d.]*$", "")
			if not vim.startswith(venv, "/") then
				venv = vim.fs.joinpath(vim.fs.dirname(ty_toml), venv)
			end

			local ipython = vim.fs.joinpath(venv, "bin", "ipython")
			if vim.fn.executable(ipython) == 1 then
				python = ipython
			else
				vim.notify("ipython not found at venv", vim.log.levels.WARN)
			end
		else
			vim.notify("venv not specified at ty.toml", vim.log.levels.WARN)
		end
	end

	return {python, "--no-autoindent"}
end

if not vim.g.python_ftplugin_loaded then
	vim.g.python_plugins_loaded = true
	vim.pack.add({"https://github.com/Vigemus/iron.nvim"})
	require("iron.core").setup({
		config = {
			highlight_last = "",
			repl_definition = {
				python = {
					command = get_python_executable(),
					format = require("iron.fts.common").bracketed_paste_python,
					block_dividers = { "# %%", "#%%" },
				},
			},
			repl_open_cmd = require("iron.view").split.vertical.rightbelow("%40")
		},
		keymaps = {
			toggle_repl = "<space>rr",
			restart_repl = "<space>rR",
			send_file = "<space>rf",
		},
	})
end

local opts = { buffer = vim.api.nvim_get_current_buf(), silent = true }
vim.keymap.set( "n", "<cr>",
	function()
		require("iron.core").send_code_block(true)
	end,
	opts
)
vim.keymap.set( "v", "<cr>",
	function()
		require("iron.core").visual_send()
	end,
	opts
)
