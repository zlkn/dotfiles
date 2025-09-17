-- use a release tag to download pre-built binaries
MiniDeps.add({
    source = "saghen/blink.cmp",
    checkout = "v0.12.4",
    depends = { "fang2hou/blink-copilot", "zbirenbaum/copilot.lua" },
})

MiniDeps.later(function()
    require("copilot").setup({
        filetypes = {
            yaml = true,
        },
    })
    require("blink-copilot").setup({
        max_completions = 1,
        kind_icon = " ",
    })

    local blink = require("blink.cmp")
    blink.setup({
        keymap = {
            preset = "default",
            -- Simulate completion in commandline
            -- Enter approve select
            -- tab and shift-tab to loop over completion
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                window = {
                    border = "single",
                },
            },
            menu = {
                border = nil,
                scrollbar = false,
                scrolloff = 1,
                draw = {
                    treesitter = { "lsp" },
                    columns = {
                        { "kind_icon" },
                        { "label", "label_description", gap = 1 },
                        { "source_name" },
                        { "kind" },
                    },
                    components = {},
                },
            },
        },
        signature = {
            enabled = true,
        },
        sources = {
            default = { "lsp", "path", "copilot", "buffer" },
            providers = {
                copilot = {
                    name = "Copilot",
                    module = "blink-copilot",
                },
            },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "normal",
            -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
            kind_icons = {
                Copilot = " ", -- GitHub Copilot
                Text = " ",
                Method = " ",
                Function = " ",
                Constructor = " ",

                Field = " ",
                Variable = " ",
                Property = " ",

                Class = " ",
                Interface = " ",
                Struct = " ",
                Module = " ",

                Unit = " ",
                Value = " ",
                Enum = " ",
                EnumMember = " ",

                Keyword = " ",
                Constant = " ",

                Snippet = " ",
                Color = " ",
                File = " ",
                Reference = " ",
                Folder = " ",
                Event = " ",
                Operator = " ",
                TypeParameter = " ",
            },
        },
    })
    local color = "#d1d1d1"
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { fg = none, bg = color })
    vim.api.nvim_set_hl(0, "BlinkCmpKindText", { fg = "#313131", bg = none })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { fg = "#871094", bg = color })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#007474", bg = color })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", { fg = "#c30771", bg = color })
end)
