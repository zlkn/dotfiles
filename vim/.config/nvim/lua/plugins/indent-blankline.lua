MiniDeps.add("lukas-reineke/indent-blankline.nvim")
MiniDeps.later(function()
    local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
    }

    local hooks = require("ibl.hooks")
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        -- vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        -- vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        -- vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        -- vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        -- vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        -- vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        -- vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })

        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#d1d1d1" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#d1d1d1" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#d1d1d1" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#d1d1d1" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#d1d1d1" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#d1d1d1" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#d1d1d1" })
    end)

    require("ibl").setup({
        indent = {
            highlight = highlight,
            char = "▏",
            tab_char = "▏",
        },
        scope = {
            enabled = true,
            show_start = false,
            show_end = false,
        },
        whitespace = {
            remove_blankline_trail = true,
        },
        exclude = {
            filetypes = {
                "NvimTree",
                "Trouble",
                "dashboard",
                "git",
                "help",
                "markdown",
                "notify",
                "packer",
                "sagahover",
                "terminal",
                "undotree",
            },
            buftypes = { "terminal", "nofile", "prompt", "quickfix" },
        },
    })
end)
