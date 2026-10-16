vim.pack.add({
    "https://github.com/zenbones-theme/zenbones.nvim",
    "https://github.com/aktersnurra/no-clown-fiesta.nvim",
})
MiniMisc.safely("later", function()
    vim.g.zenbones_compat = 1
    -- vim.cmd.colorscheme("zenbones")
    vim.cmd.colorscheme("aqua")
end)
