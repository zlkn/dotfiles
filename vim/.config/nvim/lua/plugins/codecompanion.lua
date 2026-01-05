-- install codecompanion.nvim
MiniDeps.add({
    source = "olimorris/codecompanion.nvim",
    depends = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
})
MiniDeps.later(function()
    -- Other package managers
    require("codecompanion").setup({
        opts = {
            log_level = "DEBUG", -- or "TRACE"
        },
    })
end)
