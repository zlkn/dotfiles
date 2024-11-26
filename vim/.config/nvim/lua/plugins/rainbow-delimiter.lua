return {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
        require("rainbow-delimiters.setup").setup({
            highlight = {
                "RainbowDelimiterBlack",
                "RainbowDelimiterRed",
                "RainbowDelimiterYellow",
                "RainbowDelimiterBlue",
                "RainbowDelimiterOrange",
                "RainbowDelimiterGreen",
                "RainbowDelimiterViolet",
                "RainbowDelimiterCyan",
            },
        })
    end,
}
