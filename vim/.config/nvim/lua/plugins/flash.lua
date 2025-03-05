MiniDeps.add({ source = "folke/flash.nvim" })
vim.keymap.set("n", "s", function()
    require("flash").jump()
end, { desc = "Start flash jump mode", remap = true, silent = true })
