-- use a release tag to download pre-built binaries
MiniDeps.add({
    source = "saghen/blink.cmp",
    checkout = "v0.12.4",
    depends = { "zbirenbaum/copilot.lua" },
})

MiniDeps.later(function()
    -- print("Configure blink.cmp")
    require("blink.cmp").setup({
        keymap = {
            preset = "default",
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                -- border = "rounded",
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
                    },
                },
            },
        },
        signature = {
            enabled = true,
        },
        sources = {
            providers = {},
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "normal",
            -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
            kind_icons = {
                Copilot = "",
                Text = "󰉿",
                Method = "󰊕",
                Function = "󰊕",
                Constructor = "󰒓",

                Field = "󰜢",
                Variable = "󰆦",
                Property = "󰖷",

                Class = "󱡠",
                Interface = "󱡠",
                Struct = "󱡠",
                Module = "󰅩",

                Unit = "󰪚",
                Value = "󰦨",
                Enum = "󰦨",
                EnumMember = "󰦨",

                Keyword = "󰻾",
                Constant = "󰏿",

                Snippet = "󱄽",
                Color = "󰏘",
                File = "󰈔",
                Reference = "󰬲",
                Folder = "󰉋",
                Event = "󱐋",
                Operator = "󰪚",
                TypeParameter = "󰬛",
            },
        },
    })

    -- FIXME: Hardcoded colors
    local borderColor = "#a1a1a1"
    local backgroundColor = "#f4f5f5"
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = borderColor })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = borderColor })
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { fg = backgroundColor, bg = "#d9d9d9" })
    vim.api.nvim_set_hl(0, "BlinkCmpScrollBarThumb", { bg = borderColor })
    -- vim.api.nvim_set_hl(0, "BlinkCmpKind", { bg = none, fg = "#313131" })
end)
