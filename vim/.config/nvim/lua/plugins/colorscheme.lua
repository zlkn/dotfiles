MiniDeps.add({
    source = "projekt0n/github-nvim-theme",
    name = "github-nvim-theme",
})

MiniDeps.now(function()
    local palette = require("palette")
    local semantic_highlight = function()
        local hl = vim.api.nvim_set_hl

        hl(0, "CursorLine", { bg = palette.extra.gray0 })
        hl(0, "CursorLineNr", { bg = palette.extra.gray0 })
        hl(0, "CursorLineSign", { bg = palette.extra.gray0 })

        hl(0, "NormalFloat", { bg = none })
        hl(0, "FloatTitle", { bg = none })

        -- hl(0, "MiniNotifyNormal", { fg = palette.ansi.white, bg = none })
        hl(0, "MiniNotifyBorder", { fg = palette.extra.background, bg = none })
        hl(0, "MiniNotifyTitle", { fg = palette.extra.background, bg = none })

        -- Diagnostic virual text
        hl(0, "DiagnosticHint", { fg = palette.ansi.cyan })

        -- Transparent tabline
        hl(0, "TabLineFill", { bg = none })

        hl(0, "Visual", { bg = palette.extra.gray1 })

        -- MiniCursorword
        hl(0, "MiniCursorwordCurrent", { bg = palette.extra.gray4 })
        hl(0, "MiniCursorword", { bg = palette.extra.gray4 })

        -- Minipick
        hl(0, "MiniPickMatchRanges", { fg = palette.brights.magenta })
        hl(0, "MiniPickPromptCaret", { fg = palette.extra.gray2 })
        hl(0, "MiniPickPromptPrefix", { fg = palette.extra.gray2 })
        hl(0, "MiniPickPrompt", { fg = palette.ansi.white })

        -- MiniHipatterns
        hl(0, "MiniHipatternsFixme", { bg = "#f4d8e4", fg = palette.brights.black })
        hl(0, "MiniHipatternsHack", { bg = "#f2e3b7", fg = palette.brights.black })
        hl(0, "MiniHipatternsTodo", { bg = "#d7e6dd", fg = palette.brights.black })
        hl(0, "MiniHipatternsNote", { bg = "#d3e4f1", fg = palette.brights.black })

        hl(0, "BlinkCmpMenu", { fg = none, bg = palette.extra.gray1 })
        hl(0, "BlinkCmpKindText", { fg = palette.ansi.white, bg = none })
        hl(0, "BlinkCmpLabelMatch", { fg = palette.brights.magenta, bg = none })
        hl(0, "BlinkCmpSignatureHelp", { fg = palette.brights.magenta, bg = palette.extra.gray1 })
        hl(0, "BlinkCmpSignatureHelpBorder", { fg = palette.brights.cyan, bg = palette.extra.gray1 })
        hl(0, "BlinkCmpSignatureHelpActiveParameter", { fg = palette.ansi.red, bg = palette.extra.gray1 })

        -- All floating window border
        hl(0, "FloatBorder", { fg = palette.extra.gray2, bg = none })

        -- Extra lsp semantic_highlight
        hl(0, "@string.escape", { fg = palette.ansi.yellow })
        hl(0, "@constructor", { fg = palette.ansi.magenta })
        hl(0, "@function.builtin", { fg = palette.ansi.magenta })
        hl(0, "@keyword.exception", { fg = palette.brights.magenta })
        hl(0, "@keyword.function", { fg = palette.ansi.white, bold = true })

        --  ansible_semantic_highlight
        hl(0, "@lsp.type.class", { fg = palette.brights.magenta })
        -- hl(0, "@lsp.type.class", { fg = palette.brights.blue })
        hl(0, "@lsp.type.method.yaml.ansible", { fg = palette.brights.cyan })
        hl(0, "@lsp.type.keyword.yaml.ansible", { fg = palette.brights.blue })

        -- yaml semantic highlight
        hl(0, "@boolean.yaml", { bold = true })
        -- hl(0, "@number.yaml", { fg = palette.ansi.yellow })

        -- terraform semantic highlight
        hl(0, "@boolean.terraform", { bold = true })
        hl(0, "@lsp.type.type.terraform", { fg = palette.brights.white })

        -- lua semantic highlight
        hl(0, "@lsp.mod.global.lua", { fg = palette.brights.white, bold = true })
        hl(0, "@boolean.lua", { bold = true })
        hl(0, "@lsp.typemod.function.defaultLibrary.lua", { fg = palette.ansi.magenta })

        -- jinja semantic highlight
        hl(0, "@keyword.directive.jinja", { fg = palette.ansi.blue })

        -- c semantic highlight
        hl(0, "@keyword.conditional.ternary.c", { fg = palette.ansi.yellow, bold = true })
        hl(0, "@constant.builtin.c", { fg = palette.brights.white, bold = true })
        hl(0, "@type.c", { fg = palette.brights.white, italic = true })

        -- python semantic highlight
        hl(0, "@boolean.python", { fg = palette.brights.black, bold = true })
        hl(0, "@lsp.typemod.class.builtin.python", { fg = palette.brights.blue, italic = true })
        hl(0, "@lsp.type.class.python", { fg = palette.brights.blue })
    end
    local syntax = {
        aqua = {
            bracket = palette.ansi.white,
            builtin0 = palette.ansi.magenta,
            builtin1 = palette.brights.blue, -- C lang types
            builtin2 = palette.brights.white,
            comment = palette.brights.black,
            conditional = palette.ansi.white,
            const = palette.ansi.white,
            dep = palette.ansi.white,
            field = palette.ansi.white,
            func = palette.brights.cyan,
            ident = palette.ansi.white,
            keyword = palette.ansi.white,
            number = palette.ansi.white,
            operator = palette.ansi.white,
            param = palette.ansi.white,
            preproc = palette.ansi.white,
            regex = palette.ansi.yellow,
            statement = palette.ansi.white,
            string = palette.brights.green,
            tag = palette.brights.blue,
            type = palette.brights.white,
            variable = palette.ansi.white,
        },
        default = {
            bracket = palette.brights.black,
            builtin0 = palette.ansi.magenta,
            builtin1 = palette.brights.cyan,
            builtin2 = palette.brights.magenta,
            comment = palette.ansi.white,
            conditional = palette.brights.red,
            const = palette.ansi.white,
            dep = palette.brights.cyan,
            field = palette.brights.white,
            func = palette.brights.magenta,
            ident = palette.ansi.white,
            keyword = palette.brights.blue,
            number = palette.brights.black,
            operator = palette.brights.black,
            param = palette.ansi.white,
            preproc = palette.ansi.red,
            regex = palette.ansi.yellow,
            statement = palette.brights.red,
            string = palette.brights.green,
            tag = palette.brights.blue,
            type = palette.brights.black,
            variable = palette.ansi.white,
        },
    }

    require("github-theme").setup({
        options = {
            -- Compiled file's destination location
            compile_path = "/tmp/github-theme",
            transparent = true,
            styles = {
                comments = "italic",
                types = "italic",
                constants = "bold",
                keywords = "bold",
            },
        },
        specs = {
            github_light = {
                syntax = syntax.aqua,
            },
        },
    })

    vim.cmd([[ colorscheme github_light ]])
    semantic_highlight()
end)
