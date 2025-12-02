MiniDeps.add({
    source = "nvim-treesitter/nvim-treesitter",
    -- Use 'master' while monitoring updates in 'main'
    checkout = "main",
    monitor = "main",
    -- Perform action after every checkout
    hooks = {
        post_checkout = function()
            vim.cmd("TSUpdate")
        end,
    },
})

MiniDeps.now(function()
    local packages = {
        "bash",
        "c",
        "cpp",
        "rust",
        "go",
        "gomod",
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
        "jinja",
        "jinja_inline",
    }

    require("nvim-treesitter").setup({
        -- Directory to install parsers and queries to
        install_dir = vim.fn.stdpath("data") .. "/site",
    })

    require("nvim-treesitter").install(packages) -- wait max. 5 minutes

    vim.api.nvim_create_autocmd("FileType", {
        pattern = packages,
        callback = function()
            vim.treesitter.start()
        end,
    })
end)
