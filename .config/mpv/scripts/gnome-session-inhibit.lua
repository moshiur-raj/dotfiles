-- Inhibit GNOME idle/suspend while MPV is playing
-- Only works when gpu-context starts with "x11*"

local mp  = require 'mp'
local msg = require 'mp.msg'
 
local mpv_pid   = mp.get_property_native("pid")
local inhibitor = nil   -- async-command handle while inhibiting, else nil
 
-- Decide once whether we should act, based on the configured gpu-context.
local gpu_context   = (mp.get_property("gpu-context", "") or ""):lower()
local allow_inhibit = gpu_context:find("^x11") ~= nil
msg.info(("idle inhibition %s (gpu-context=%s)")
    :format(allow_inhibit and "enabled" or "disabled", gpu_context))
 
local function start_inhibit()
    if not allow_inhibit or inhibitor ~= nil then return end
 
    local handle
    handle = mp.command_native_async({
        name          = "subprocess",
        playback_only = false,   -- lifecycle is driven by us, not by mpv
        detach        = false,   -- mpv owns the child, so abort can kill it
        args = {
            "gnome-session-inhibit",
            "--inhibit", "idle",
            "--inhibit", "suspend",
            "--reason",  "mpv playing",
            -- lifetime token: exits the moment mpv (pid) is gone
            "pidwait", "--pid", tostring(mpv_pid),
        },
    }, function(_, result, _)
        -- Fires when the inhibitor ends (paused -> aborted, quit, or failed).
        if inhibitor == handle then inhibitor = nil end
        if result and not result.killed_by_us
           and result.error_string and result.error_string ~= "" then
            msg.warn("gnome-session-inhibit failed: " .. result.error_string)
        end
    end)
 
    inhibitor = handle
    msg.info("inhibition started")
end
 
local function stop_inhibit()
    if inhibitor == nil then return end
    mp.abort_async_command(inhibitor)  -- kills gnome-session-inhibit -> inhibit released
    inhibitor = nil
    msg.info("inhibition stopped")
end
 
-- Inhibit only while playing; release as soon as we pause.
mp.observe_property("pause", "bool", function(_, paused)
    if paused then stop_inhibit() else start_inhibit() end
end)
 
-- Clean shutdown on normal quit. (SIGKILL of mpv is covered by tail --pid.)
mp.register_event("shutdown", stop_inhibit)
