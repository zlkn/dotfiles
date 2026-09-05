MiniDeps.add("zenbones-theme/zenbones.nvim")
MiniDeps.later(function()
    vim.g.zenbones_compat = 1
    -- vim.cmd.colorscheme("zenbones")
    vim.cmd.colorscheme("aqua")
end)
