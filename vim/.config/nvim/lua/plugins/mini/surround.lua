MiniDeps.add({ source = "nvim-mini/mini.surround", checkout = "stable" })
MiniDeps.later(function()
    local surround = require("mini.surround")
    surround.setup({
        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 500,

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
            add = "sa", -- Add surrounding in Normal and Visual modes
            delete = "sd", -- Delete surrounding
            find = "sf", -- Find surrounding (to the right)
            find_left = "sF", -- Find surrounding (to the left)
            highlight = "sh", -- Highlight surrounding
            replace = "sr", -- Replace surrounding
            update_n_lines = "sn", -- Update `n_lines`

            suffix_last = "l", -- Suffix to search with "prev" method
            suffix_next = "n", -- Suffix to search with "next" method
        },
    })
end)
