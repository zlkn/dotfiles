-- use a release tag to download pre-built binaries
MiniDeps.add({
    source = "saghen/blink.cmp",
    checkout = "v0.12.4",
})

MiniDeps.later(function()
    local blink = require("blink.cmp")
    blink.setup({
        keymap = {
            preset = "default",
            -- Simulate completion in commandline
            -- Enter approve select
            -- tab and shift-tab to loop over completion
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
        },
        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },
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
            default = { "lsp", "path", "buffer" },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "normal",
            kind_icons = {
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
end)
