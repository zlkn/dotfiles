return {
    "folke/noice.nvim",
    opts = {
        cmdline = {
            enabled = true,
            view = "cmdline",
        },
        presets = {
            lsp_doc_border = true,
            command_palette = true,
        },
        views = {
            cmdline_popupmenu = {
                relative = "editor",
                position = {
                    row = "97%",
                    col = "1%",
                },
                size = {
                    width = 60,
                    height = "auto",
                    max_height = 15,
                },
                -- border = {
                --     style = "none",
                --     padding = { 0, 3 },
                -- },
                win_options = {
                    winhighlight = { NormalFloat = "NormalFloat", FloatBorder = "NoiceCmdlinePopupBorder" },
                },
            },
        },
    },
}
