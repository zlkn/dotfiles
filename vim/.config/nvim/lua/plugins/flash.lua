MiniDeps.add({ source = "folke/flash.nvim" })
vim.keymap.set("n", "<leader>s", function()
    require("flash").jump()
end, { desc = "Start flash jump mode" })
