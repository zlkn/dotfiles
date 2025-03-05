local add = MiniDeps.add

-- Add to current session (install if absent)
-- add({
--     source = "neovim/nvim-lspconfig",
--     -- Supply dependencies near target plugin
--     depends = { "williamboman/mason.nvim" },
-- })

add({
    source = "nvim-treesitter/nvim-treesitter",
    -- Use 'master' while monitoring updates in 'main'
    checkout = "master",
    monitor = "main",
    -- Perform action after every checkout
    hooks = {
        post_checkout = function()
            vim.cmd("TSUpdate")
        end,
    },
})
MiniDeps.later(function()
    -- Possible to immediately execute code which depends on the added plugin
    require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vimdoc", "yaml" },
        highlight = { enable = true },
    })

    vim.keymap.set({ "<c-space>", desc = "Increment Selection", mode = { "x", "n" } })
end)
