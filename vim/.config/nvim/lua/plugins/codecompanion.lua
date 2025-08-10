MiniDeps.add({ source = "olimorris/codecompanion.nvim", depends = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" } })
MiniDeps.later(function()
    require("codecompanion").setup({
        strategies = {
            chat = { adapter = "copilot" },
        },
    })
end)
