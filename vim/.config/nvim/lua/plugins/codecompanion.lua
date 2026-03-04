-- install codecompanion.nvim
MiniDeps.add({
    source = "olimorris/codecompanion.nvim",
    depends = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
})
MiniDeps.later(function()
    require("codecompanion").setup({
        adapters = {
            anthropic = function()
                return require("codecompanion.adapters").extend("anthropic", {
                    env = {
                        api_key = "ANTHROPIC_API_KEY",
                    },
                })
            end,
        },
        strategies = {
            chat = { adapter = "anthropic" },
            inline = { adapter = "anthropic" },
            agent = { adapter = "anthropic" },
        },
        opts = {
            log_level = "DEBUG",
        },
    })
end)
