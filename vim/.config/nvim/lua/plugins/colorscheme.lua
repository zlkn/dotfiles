MiniDeps.add("zenbones-theme/zenbones.nvim")
vim.pack.add({
    { src = 'https://github.com/aktersnurra/no-clown-fiesta.nvim' }
})
MiniDeps.later(function()
    vim.g.zenbones_compat = 1
    -- vim.cmd.colorscheme("zenbones")
    vim.cmd.colorscheme("aqua")
end)
