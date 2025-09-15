MiniDeps.add({
    source = "projekt0n/github-nvim-theme",
    name = "github-nvim-theme",
})

MiniDeps.now(function()
    local palette = require("palette")

    require("github-theme").setup({
        options = {
            -- Compiled file's destination location
            compile_path = "/tmp/github-theme",
            transparent = true,
            styles = {
                comments = "italic",
                -- keyword = "bold",
                -- operators = "bold",
                -- numbers = "bold",
                -- constants = "bold",
                -- builtins = "bold",
            },
        },
        specs = {
            github_light = {
                syntax = {
                    bracket = palette.brights.black,
                    builtin0 = palette.ansi.magenta,
                    builtin1 = palette.ansi.blue,
                    builtin2 = palette.ansi.magenta,
                    comment = palette.brights.white,
                    conditional = palette.brights.red,
                    const = palette.extra.darkBlue,
                    dep = palette.brights.cyan,
                    field = palette.extra.teal,
                    func = palette.brights.magenta,
                    ident = palette.ansi.black,
                    keyword = palette.brights.blue,
                    number = palette.ansi.black,
                    operator = palette.brights.black,
                    param = palette.extra.tirquose,
                    preproc = palette.ansi.red,
                    regex = palette.ansi.yellow,
                    statement = palette.brights.red,
                    string = palette.ansi.green,
                    tag = palette.ansi.blue,
                    type = palette.brights.black,
                    variable = palette.ansi.black,
                },
            },
        },
    })

    vim.cmd([[ colorscheme github_light ]])

    vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.extra.gray0 })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = palette.extra.gray0 })
    vim.api.nvim_set_hl(0, "CursorLineSign", { bg = palette.extra.gray0 })

    vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bg = palette.extra.cornflowerBlue })
    -- vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = true, sp = palette.brights.cyan })
    -- vim.api.nvim_set_hl(0, "MiniCursorword", { underline = true, sp = palette.brights.cyan })

    -- Transparent/“inherit terminal” bg for builtin tabline
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = none })
    -- vim.api.nvim_set_hl(0, "TabLine", { bg = none, fg = "#888888" })
    -- vim.api.nvim_set_hl(0, "TabLineSel", { bg = none, fg = "#ffffff", bold = true })

    -- Minipick
    vim.api.nvim_set_hl(0, "MiniPickMatchRanges", { fg = palette.brights.magenta })
    vim.api.nvim_set_hl(0, "MiniPickPromptCaret", { fg = palette.extra.gray2 })
    vim.api.nvim_set_hl(0, "MiniPickPromptPrefix", { fg = palette.extra.gray2 })
    vim.api.nvim_set_hl(0, "MiniPickPrompt", { fg = palette.ansi.black })

    -- All floating window border
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.extra.gray2, bg = none })

    -- -- force transparent background for all themes
    -- vim.cmd([[
    --     highlight Normal guibg=none
    --     highlight NonText guibg=none
    --     highlight Normal ctermbg=none
    --     highlight NonText ctermbg=none
    -- ]])

    vim.api.nvim_set_hl(0, "@constructor", { fg = palette.extra.cherry })
    vim.api.nvim_set_hl(0, "@string.escape", { fg = palette.ansi.yellow })

    --  ansible_semantic_highlight
    vim.api.nvim_set_hl(0, "@lsp.type.class", { fg = palette.extra.cherry })
    vim.api.nvim_set_hl(0, "@lsp.type.method.yaml.ansible", { fg = palette.extra.tirquose })

    -- terraform semantic highlight
    vim.api.nvim_set_hl(0, "@boolean.terraform", { bold = true })

    -- golang semantic highlight
    vim.api.nvim_set_hl(0, "@keyword.function", { fg = palette.ansi.blue, bold = true })

    -- lua semantic highlight
    vim.api.nvim_set_hl(0, "@lsp.mod.global.lua", { bold = true })
end)
