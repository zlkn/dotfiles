MiniDeps.add("HiPhish/rainbow-delimiters.nvim")
MiniDeps.later(function()
    local suite_rainbow = {
        "RainbowDelimiterBlack",
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
    }

    require("rainbow-delimiters.setup").setup({
        highlight = suite_rainbow,
        condition = function()
            return false
        end,
    })
    -- vim.g.rainbow_delimiters = { highlight = suite_rainbow }
    vim.g.rainbow_delimiters_enabled = false

    local toggle_rainbow_delimiter = function()
        vim.g.rainbow_delimiters_enabled = not vim.g.rainbow_delimiters_enabled
        require("rainbow-delimiters").toggle(0)
        print((vim.g.rainbow_delimiters_enabled and "Enable" or "Disable") .. " rainbow delimiters")
    end
    -- Toogle rainbow_delimiters
    vim.keymap.set("n", "<leader>tr", toggle_rainbow_delimiter, { desc = "toggle rainbow delimiters" })
end)
