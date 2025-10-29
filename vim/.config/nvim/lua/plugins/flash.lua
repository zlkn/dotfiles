MiniDeps.add({ source = "folke/flash.nvim" })
MiniDeps.later(function()
    require("flash").setup({
        modes = {
            -- search = {
            --     enabled = true,
            -- },
            char = {
                enabled = false, -- Disable f, F, t, T motion
            },
        },
    })
    vim.keymap.set({ "n", "x", "o" }, "f", function()
        require("flash").jump()
    end, { desc = "Start flash jump mode", noremap = true, silent = true })
end)
