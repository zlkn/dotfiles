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
        textobjects = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
    })
end)
