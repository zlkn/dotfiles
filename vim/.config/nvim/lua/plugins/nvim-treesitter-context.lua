MiniDeps.add("nvim-treesitter/nvim-treesitter-context")
MiniDeps.later(function()
    local treesitter_context = require("treesitter-context")
    treesitter_context.setup({
        max_lines = 0,
        min_window_height = 30,
        mode = "topline",
    })
end)
