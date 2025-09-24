local mp = require 'mp'

mp.register_event("file-loaded", function()
    local fps = mp.get_property_number("container-fps")

    if not fps then
        mp.msg.warn("Could not detect container-fps.")
        return
    end

    if fps < 48 then
        local new_fps = fps * 3
        mp.msg.info(string.format("container-fps is %.2f < 48, changing to %.2f", fps, new_fps))
        mp.set_property("vf", string.format("fps=%.3f", new_fps))
    else
        mp.msg.info(string.format("container-fps is %.2f, no change needed.", fps))
    end
end)
