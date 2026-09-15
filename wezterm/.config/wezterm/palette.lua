local wezterm = require("wezterm")

-- M.variant = {
--     palette = "day",
--     font = {
--         weight = "Regular"
--     }
-- }

local appearance = "Dark"
if wezterm.gui then
    appearance = wezterm.gui.get_appearance()
end

if appearance:find("Dark") then
    return require( "palette_aqua_night")
end
return require("palette_aqua_day")

-- return M.variant

