MiniDeps.add({ source = "folke/flash.nvim" })
MiniDeps.later(function()
    require("flash").setup({
        modes = {
            char = {
                enabled = false, -- Disable f, F, t, T motion
            },
        },
    })
    vim.keymap.set({ "n", "x", "o" }, "<CR>", function()
        require("flash").jump()
    end, { desc = "Start flash jump mode", noremap = true, silent = true })

    vim.keymap.set({ "n", "x", "o" }, "<c-space>", function()
        require("flash").treesitter({
            actions = {
                ["<c-space>"] = "next",
                ["<BS>"] = "prev",
            },
        })
    end, { desc = "Treesitter incremental selection" })
end)
