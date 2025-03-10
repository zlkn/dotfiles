local wezterm = require("wezterm")
local mod = {}

local function gsettings(key)
    return wezterm.run_child_process({ "gsettings", "get", "org.gnome.desktop.interface", key })
end

function mod.apply_to_config(config)
    if wezterm.target_triple ~= "x86_64-unknown-linux-gnu" then
        -- skip if not running on linux
        return
    end
    local success, stdout, stderr = gsettings("cursor-theme")
    if success then
        config.xcursor_theme = stdout:gsub("'(.+)'\n", "%1")
    end

    local success, stdout, stderr = gsettings("cursor-size")
    if success then
        config.xcursor_size = tonumber(stdout)
    end

    config.enable_wayland = true
    config.integrated_title_button_style = "Gnome"

    if config.enable_wayland and os.getenv("WAYLAND_DISPLAY") then
        local success, stdout, stderr = gsettings("text-scaling-factor")
        if success then
            config.font_size = (config.font_size or 10.0) * tonumber(stdout)
        end
    end
end

return mod
