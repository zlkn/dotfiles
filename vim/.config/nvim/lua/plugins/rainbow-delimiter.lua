return {
  "HiPhish/rainbow-delimiters.nvim",
  config = function()
    require("rainbow-delimiters.setup").setup({
      strategy = {
        -- ...
      },
      query = {
        -- ...
      },
      highlight = {
        "RainbowDelimiterBlack",
        "RainbowDelimiterCyan",
        "RainbowDelimiterViolet",
        "RainbowDelimiterGreen",
        "RainbowDelimiterOrange",
        "RainbowDelimiterBlue",
        "RainbowDelimiterYellow",
        "RainbowDelimiterRed",
      },
    })
  end,
}
