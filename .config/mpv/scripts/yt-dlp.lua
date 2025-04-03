local mp = require 'mp'
local utils = require 'mp.utils'

-- Define quality options (modify as needed)
local quality_options = {
    {label = "1440p", format = "bestvideo[height<=1440][vcodec^=av01]+bestaudio/bestvideo[height<=1440][vcodec=vp9]+bestaudio/bestvideo[height<=1440]+bestaudio"},
    {label = "2160p", format = "bestvideo[height<=2160][vcodec^=av01]+bestaudio/bestvideo[height<=2160][vcodec=vp9]+bestaudio/bestvideo[height<=2160]+bestaudio"},
    {label = "Best", format = "bestaudio+bestvideo"},
}

local current_quality_index = 1  -- Start with the first quality option

local function cycle_quality()
    local choice = quality_options[current_quality_index]

    -- Set the new quality
    mp.set_property("ytdl-format", choice.format)
    mp.osd_message("Selected Quality: " .. choice.label, 2)

    -- Reload video with the new quality setting
    local path = mp.get_property("path")
    mp.commandv("loadfile", path, "replace")

    -- Move to the next quality, loop back if at the end
    current_quality_index = (current_quality_index % #quality_options) + 1
end

-- Bind "y" key to cycle through qualities
mp.add_key_binding("y", cycle_quality)

