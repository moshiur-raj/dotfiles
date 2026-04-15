-- Check if plugins are outdated
local function warn_if_plugins_outdated()
	local lockfile = vim.fn.stdpath('config') .. '/nvim-pack-lock.json'

	local stat = vim.loop.fs_stat(lockfile)
	if not stat then
		vim.notify("Warning! lazy-lock.json not found", vim.log.levels.WARN)
		return
	end

	local last_modified = stat.mtime.sec
	local current_time = os.time()
	local one_week = 7 * 24 * 60 * 60

	if current_time - last_modified > one_week then
		vim.notify("Warning! You have not updated your plugins in at least a week", vim.log.levels.WARN)
	end
end

-- Call the function on startup
warn_if_plugins_outdated()
