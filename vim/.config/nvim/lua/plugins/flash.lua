MiniDeps.add({ source = "folke/flash.nvim" })
MiniDeps.later(function()
    vim.keymap.set("n", "f", function()
        require("flash").jump()
    end, { desc = "Start flash jump mode", noremap = true, silent = true })
end)
