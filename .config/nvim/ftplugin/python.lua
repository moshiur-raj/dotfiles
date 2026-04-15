local function get_python_executable_and_change_dir()
    local filepath = vim.api.nvim_buf_get_name(0)
    local filedir = filepath ~= ""
        and vim.fn.fnamemodify(filepath, ":p:h")
        or vim.fn.getcwd()

    local function fallback()
        local cmd = vim.fn.executable("ipython") == 1 and "ipython" or "python"
        return { cmd, "--no-autoindent" }
    end

    -- Walk up from the file's directory toward $HOME looking for ty.toml
    local ty_toml = vim.fs.find("ty.toml", {
        upward = true,
        path = filedir,
        stop = vim.env.HOME,
        type = "file",
    })[1]
    if not ty_toml then return fallback() end

    -- Pull `python = "..."` out of the config
    local content = table.concat(vim.fn.readfile(ty_toml), "\n")
    local venv = content:match('python%s*=%s*"([^"]+)"')
               or content:match("python%s*=%s*'([^']+)'")
    if not venv then return fallback() end

    -- Normalize: accept either a venv root or a python-binary path
    venv = venv:gsub("/bin/python[%d.]*$", "")
    local project_root = vim.fs.dirname(ty_toml)
    if not vim.startswith(venv, "/") then
        venv = vim.fs.joinpath(project_root, venv)
    end

    local ipython = vim.fs.joinpath(venv, "bin", "ipython")
    if vim.fn.executable(ipython) == 1 then
        vim.cmd("cd " .. vim.fn.fnameescape(project_root))
        return { ipython, "--no-autoindent" }
    end

    return fallback()
end

if not vim.g.python_ftplugin_loaded then
	vim.g.python_plugins_loaded = true
	vim.pack.add({'https://github.com/Vigemus/iron.nvim'})
	require('iron.core').setup({
		config = {
			highlight_last = '',
			repl_definition = {
				python = {
					command = get_python_executable_and_change_dir(),
					format = require('iron.fts.common').bracketed_paste_python,
					block_dividers = { "# %%", "#%%" },
				},
			},
			repl_open_cmd = require('iron.view').split.vertical.rightbelow("%40")
		},
		keymaps = {
			toggle_repl = "<space>rr",
			restart_repl = "<space>rR",
			send_file = "<space>rf",
		},
	})
end

local opts = { buffer = vim.api.nvim_get_current_buf(), silent = true }
vim.keymap.set( 'n', '<cr>',
	function()
		require('iron.core').send_code_block(true)
	end,
	opts
)
vim.keymap.set( 'v', '<cr>',
	function()
		require('iron.core').visual_send()
	end,
	opts
)
