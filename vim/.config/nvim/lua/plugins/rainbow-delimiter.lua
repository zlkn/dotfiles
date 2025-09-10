MiniDeps.add("HiPhish/rainbow-delimiters.nvim")
MiniDeps.later(function()
    local suite_all_black = {

        "RainbowDelimiterBlack",
        "RainbowDelimiterBlack",
        "RainbowDelimiterBlack",
        "RainbowDelimiterBlack",
        "RainbowDelimiterBlack",
        "RainbowDelimiterBlack",
        "RainbowDelimiterBlack",
        "RainbowDelimiterBlack",
    }
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
    local rd = require("rainbow-delimiters.setup")

    function _G.ToogleRainbowDelimiters()
        if vim.g.rainbow_delimiters_enabled then
            rd.setup({ highlight = suite_all_black })
            vim.g.rainbow_delimiters_enabled = false
        else
            rd.setup({ highlight = suite_rainbow })
            vim.g.rainbow_delimiters_enabled = true
        end
    end
end)
