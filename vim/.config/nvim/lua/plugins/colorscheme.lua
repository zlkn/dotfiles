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
                types = "italic",
                constants = "bold",
            },
        },
        specs = {
            github_light = {
                syntax = {
                    bracket = palette.brights.black,
                    builtin0 = palette.ansi.magenta,
                    builtin1 = palette.brights.cyan,
                    builtin2 = palette.brights.magenta,
                    comment = palette.brights.white,
                    conditional = palette.brights.red,
                    const = palette.brights.black,
                    dep = palette.brights.cyan,
                    field = palette.extra.teal,
                    func = palette.brights.magenta,
                    ident = palette.ansi.black,
                    keyword = palette.brights.blue,
                    number = palette.brights.black,
                    operator = palette.brights.black,
                    param = palette.ansi.black,
                    preproc = palette.ansi.red,
                    regex = palette.ansi.yellow,
                    statement = palette.brights.red,
                    string = palette.brights.green,
                    tag = palette.brights.blue,
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

    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#ececec" })
    vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#ececec" })

    vim.api.nvim_set_hl(0, "MiniNotifyNormal", { bg = "#ececec" })
    vim.api.nvim_set_hl(0, "MiniNotifyBorder", { fg = "#ececec", bg = "#ececec" })
    vim.api.nvim_set_hl(0, "MiniNotifyTitle", { fg = "#ececec", bg = "#ececec" })

    -- Diagnostic virual text
    vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = palette.ansi.cyan })

    -- Transparent tabline
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = none })

    vim.api.nvim_set_hl(0, "Visual", { bg = palette.extra.gray1 })

    -- MiniCursorword
    vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bg = palette.extra.gray4 })
    vim.api.nvim_set_hl(0, "MiniCursorword", { bg = palette.extra.gray4 })

    -- Minipick
    vim.api.nvim_set_hl(0, "MiniPickMatchRanges", { fg = palette.brights.magenta })
    vim.api.nvim_set_hl(0, "MiniPickPromptCaret", { fg = palette.extra.gray2 })
    vim.api.nvim_set_hl(0, "MiniPickPromptPrefix", { fg = palette.extra.gray2 })
    vim.api.nvim_set_hl(0, "MiniPickPrompt", { fg = palette.ansi.black })

    -- MiniHipatterns
    vim.api.nvim_set_hl(0, "MiniHipatternsFixme", { bg = "#f4d8e4", fg = palette.brights.black })
    vim.api.nvim_set_hl(0, "MiniHipatternsHack", { bg = "#f2e3b7", fg = palette.brights.black })
    vim.api.nvim_set_hl(0, "MiniHipatternsTodo", { bg = "#d7e6dd", fg = palette.brights.black })
    vim.api.nvim_set_hl(0, "MiniHipatternsNote", { bg = "#d3e4f1", fg = palette.brights.black })

    -- All floating window border
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.extra.gray2, bg = none })

    vim.api.nvim_set_hl(0, "@string.escape", { fg = palette.ansi.yellow })

    --  ansible_semantic_highlight
    vim.api.nvim_set_hl(0, "@lsp.type.class", { fg = palette.brights.magenta })
    vim.api.nvim_set_hl(0, "@lsp.type.method.yaml.ansible", { fg = palette.extra.tirquose })
    vim.api.nvim_set_hl(0, "@lsp.type.keyword.yaml.ansible", { fg = palette.brights.blue })

    -- yaml semantic highlight
    vim.api.nvim_set_hl(0, "@boolean.yaml", { bold = true })
    -- vim.api.nvim_set_hl(0, "@number.yaml", { fg = palette.ansi.yellow })

    -- terraform semantic highlight
    vim.api.nvim_set_hl(0, "@boolean.terraform", { bold = true })

    -- golang semantic highlight
    vim.api.nvim_set_hl(0, "@keyword.function", { fg = palette.brights.blue, bold = true })

    -- lua semantic highlight
    vim.api.nvim_set_hl(0, "@lsp.mod.global.lua", { bold = true })
    vim.api.nvim_set_hl(0, "@boolean.lua", { bold = true })

    -- golang semantic highlight
    vim.api.nvim_set_hl(0, "@constant.builtin.go", { fg = palette.brights.yellow, bold = true })

    -- jinja semantic highlight
    -- vim.api.nvim_set_hl(0, "@keyword.directive.jinja", { fg = palette.ansi.magenta })
    -- vim.api.nvim_set_hl(0, "@keyword.directive.jinja", { fg = palette.brights.green, bold = true })
    vim.api.nvim_set_hl(0, "@keyword.directive.jinja", { fg = palette.ansi.cyan })
end)
