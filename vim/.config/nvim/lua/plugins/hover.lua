MiniDeps.add("lewis6991/hover.nvim")
MiniDeps.later(function()
    require("hover").setup({
        init = function()
            require("hover.providers.lsp")
            require("hover.providers.diagnostic")
            require("hover.providers.man")
        end,
        preview_opts = {
            border = "single",
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
        mouse_providers = {
            "LSP",
        },
        mouse_delay = 1000,
    })

    -- Setup keymaps
    vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
    vim.keymap.set("n", "<Tab>", function()
        require("hover").hover_switch("next")
    end, { desc = "hover.nvim (next source)" })

    -- Mouse support
    vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
    vim.o.mousemoveevent = true
end)
