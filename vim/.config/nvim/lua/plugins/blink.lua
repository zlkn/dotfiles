-- use a release tag to download pre-built binaries
MiniDeps.add({
    source = "saghen/blink.cmp",
    checkout = "v0.12.4",
})

MiniDeps.later(function()
    print("Configure blink.cmp")
    require("blink.cmp").setup({
        keymap = {
            preset = "default",
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                border = "rounded",
                window = {
                    border = "rounded",
                },
            },
            menu = {
                border = "rounded",
                draw = {
                    treesitter = { "lsp" },
                },
            },
        },
        signature = {
            enabled = true,
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "normal",
        },
    })

    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#d1d1d1" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { fg = "none", bg = "none" })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#d1d1d1" })
end)
