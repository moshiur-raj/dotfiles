-- Inhibit GNOME idle/suspend while MPV is playing
-- Only works when gpu-context starts with "x11*"

local mp = require 'mp'
local utils = require 'mp.utils'

local inhibit_pid = nil
local mpv_pid = mp.get_property_native("pid")
local pidfile = "/tmp/mpv-gnome-inhibit-" .. mpv_pid .. ".pid"

local allow_inhibit

-- Check if gpu-context is X11-based
local gpu_context = mp.get_property("gpu-context", ""):lower()
if gpu_context:match("^x11") then
	mp.msg.info("Inhibition allowed (gpu-context=" .. gpu_context .. ")")
	allow_inhibit = true
else
	mp.msg.info("Inhibition skipped (gpu-context=" .. gpu_context .. ")")
	allow_inhibit = false
end

-- Start inhibition
local function start_inhibit()
    if not allow_inhibit then return end
    if inhibit_pid ~= nil then return end

    local cmd = string.format(
        "echo $$ > %s; sync; exec gnome-session-inhibit --inhibit idle --inhibit suspend --reason \"mpv playing\" $HOME/.config/mpv/bin/pidwait-custom %s",
        pidfile,
		mpv_pid
    )
    local res = utils.subprocess_detached({ args = { "bash", "-c", cmd } })
    -- detached mode returns immediately; read PID from file
    local f = io.open(pidfile, "r")
    if f then
        inhibit_pid = f:read("*n")
        f:close()
    end

    if inhibit_pid then
        mp.msg.info("Inhibition started (PID " .. tostring(inhibit_pid) .. ")")
    else
        mp.msg.error("Failed to get inhibition PID")
    end
end

-- Stop inhibition
local function stop_inhibit()
    if inhibit_pid ~= nil then
        -- Kill child (pidwait), which makes parent (gnome-session-inhibit) exit
        pcall(function()
            utils.subprocess({ args = {"pkill", "-P", tostring(inhibit_pid)} })
        end)
        inhibit_pid = nil
        mp.msg.info("Inhibition stopped")
    end
end

-- Watch pause state
mp.observe_property("pause", "bool", function(_, paused)
    if paused == false then
        start_inhibit()
    else
        stop_inhibit()
    end
end)

-- Ensure cleanup on quit
mp.register_event("shutdown", stop_inhibit)
mp.register_event("shutdown", function() os.remove(pidfile) end)
mp.register_event("shutdown", function() os.remove("/tmp/mpv-" .. mpv_pid .. ".pid") end)
