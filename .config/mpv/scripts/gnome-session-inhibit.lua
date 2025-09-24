-- Inhibit GNOME idle/suspend while MPV is playing
-- Works only when gpu-context starts with "x11" (x11, x11vk, x11egl, etc.)

local mp = require 'mp'
local utils = require 'mp.utils'

local inhibit_pid = nil

-- Check if gpu-context is X11-based
local function allow_inhibit()
    local gpu_context = mp.get_property("gpu-context", ""):lower()
    if gpu_context:match("^x11") then
        mp.msg.info("Inhibition allowed (gpu-context=" .. gpu_context .. ")")
        return true
    else
        mp.msg.info("Inhibition skipped (gpu-context=" .. gpu_context .. ")")
        return false
    end
end

-- Start inhibition
local function start_inhibit()
    if not allow_inhibit() then return end
    if inhibit_pid ~= nil then return end

    local args = {
        "gnome-session-inhibit",
        "--inhibit", "idle",
        "--inhibit", "suspend",
        "--reason", "mpv playing",
        "sleep", "infinity"
    }

    local res = utils.subprocess_detached({ args = args })
    inhibit_pid = res
    mp.msg.info("Inhibition started (PID " .. tostring(res) .. ")")
end

-- Stop inhibition
local function stop_inhibit()
    if inhibit_pid ~= nil then
        -- Kill child (sleep) first, then parent (gnome-session-inhibit)
        pcall(function()
            utils.subprocess({ args = {"pkill", "-P", tostring(inhibit_pid)} })
        end)
        pcall(function()
            utils.subprocess({ args = {"kill", "-TERM", tostring(inhibit_pid)} })
        end)
        inhibit_pid = nil
        mp.msg.info("Inhibition stopped")
    end
end

-- Watch pause state
mp.observe_property("pause", "bool", function(_, paused)
    if paused == false then
        start_inhibit()
		mp.msg.info("Inhibition started (PID " .. tostring(res) .. ")")
    else
        stop_inhibit()
        mp.msg.info("Inhibition stopped")
    end
end)

-- Ensure cleanup on quit
mp.register_event("shutdown", stop_inhibit)
