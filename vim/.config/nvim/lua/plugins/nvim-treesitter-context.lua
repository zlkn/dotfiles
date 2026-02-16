MiniDeps.add("nvim-treesitter/nvim-treesitter-context")
MiniDeps.later(function()
    local treesitter_context = require("treesitter-context")
    treesitter_context.setup({
        max_lines = 0,
        min_window_height = 30,
        mode = "topline",
    })

    -- Set the highlight for TreesitterContext after the plugin is loaded
    -- vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#e9e9e9" })
end)
