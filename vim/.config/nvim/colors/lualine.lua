local palette = require("palette")

local function set_hl(group, options)
    local hl = vim.api.nvim_set_hl
    hl(0, group, options)
end
