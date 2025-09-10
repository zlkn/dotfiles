MiniDeps.add({
    source = "projekt0n/github-nvim-theme",
    name = "github-nvim-theme",
})

MiniDeps.now(function()
    local palette = {
        ansi = {
            black = "#424242",
            red = "#c30771",
            green = "#0d844c",
            yellow = "#a66f00",
            blue = "#015692",
            magenta = "#523c79",
            cyan = "#008ec4",
            white = "#9d9d9d",
        },
        brights = {
            black = "#1f1f1f",
            red = "#fb007a",
            green = "#10b97a",
            yellow = "#ee9900",
            blue = "#0550ae",
            magenta = "#871094",
            cyan = "#1fbdd0",
            white = "#57606a",
        },
        extra = {
            darkBlue = "#0a3069",
            teal = "#004c63",
            tirquose = "#007474",
            cornflowerBlue = "#b6d6fd",
            gray0 = "#dfdfe1",
            gray1 = "#a1a1a1",
            cherry = "#980054",
            -- dep = "#82071e",
            -- func = "#8430ce",
        },
    }
    require("github-theme").setup({
        options = {
            -- Compiled file's destination location
            compile_path = "/tmp/github-theme",
            transparent = true,
            styles = {
                comments = "italic",
                operators = "bold",
                numbers = "bold",
                constants = "bold",
                builtins = "bold",
            },
        },
        specs = {
            github_light = {
                syntax = {
                    bracket = palette.brights.black,
                    -- builtin0 = palette.ansi.red,
                    builtin0 = palette.ansi.magenta,
                    builtin1 = palette.ansi.blue,
                    builtin2 = palette.brights.magenta,
                    comment = palette.brights.white,
                    conditional = palette.brights.red,
                    -- const = palette.ansi.blue,
                    -- const = palette.ansi.magenta,
                    const = palette.brights.white,
                    dep = palette.brights.cyan,
                    field = palette.extra.teal,
                    func = palette.brights.magenta,
                    ident = palette.ansi.black,
                    keyword = palette.brights.blue,
                    number = palette.ansi.black,
                    operator = palette.extra.darkBlue,
                    param = palette.extra.tirquose,
                    preproc = palette.ansi.red,
                    regex = palette.extra.darkBlue,
                    statement = palette.brights.red,
                    string = palette.ansi.green,
                    tag = palette.ansi.blue,
                    type = palette.brights.black,
                    variable = palette.ansi.black,
                },
                diag = {
                    hint = "#1fbdd0",
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
    vim.api.nvim_set_hl(0, "MiniPickPromptCaret", { fg = palette.extra.gray1 })
    vim.api.nvim_set_hl(0, "MiniPickPromptPrefix", { fg = palette.extra.gray1 })
    vim.api.nvim_set_hl(0, "MiniPickPrompt", { fg = palette.ansi.black })

    -- All floating window border
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.extra.gray1, bg = none })

    -- -- force transparent background for all themes
    -- vim.cmd([[
    --     highlight Normal guibg=none
    --     highlight NonText guibg=none
    --     highlight Normal ctermbg=none
    --     highlight NonText ctermbg=none
    -- ]])
    -- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "", fg = "" })

    vim.api.nvim_set_hl(0, "@constructor", { fg = palette.extra.cherry })

    --  ansible_semantic_highlight
    vim.api.nvim_set_hl(0, "@lsp.type.class", { fg = palette.extra.cherry })
    vim.api.nvim_set_hl(0, "@lsp.type.method.yaml.ansible", { fg = palette.extra.tirquose })

    -- golang semantic highlight
    vim.api.nvim_set_hl(0, "@keyword.function", { fg = palette.ansi.blue, bold = true })
end)
