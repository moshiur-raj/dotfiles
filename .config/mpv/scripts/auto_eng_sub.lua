-- auto_eng_sub.lua for MPV
-- Automatically selects English subtitles if none of the audio tracks are in English

function select_english_sub()
    -- Get the list of all tracks
    local tracks = mp.get_property_native("track-list")
    local has_english_audio = false

    -- Check if any audio track is in English
    for _, track in ipairs(tracks) do
        if track["type"] == "audio" and (track["lang"] == "eng" or track["lang"] == "en") then
            has_english_audio = true
            break
        end
    end

    -- If no audio track is in English, select English subtitles
    if not has_english_audio then
        for _, track in ipairs(tracks) do
            if track["type"] == "sub" and (track["lang"] == "eng" or track["lang"] == "en") then
                mp.set_property("sid", track["id"])
                mp.osd_message("English subtitles selected")
                break
            end
        end
    end
end

-- Run the function when a file is loaded
mp.register_event("file-loaded", select_english_sub)
