MiniDeps.add({
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
        ensure_installed = {
            "bash",
            "c",
            "diff",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "printf",
            "python",
            "query",
            "regex",
            "toml",
            "tsx",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "terraform",
            "hcl",
        },
        highlight = { enable = true },
        textobkects({ enable = true }),
    })

    -- vim.keymap.set("n", "<c-space>", , {desc = "Increment Selection" })
end)
