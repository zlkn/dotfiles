MiniDeps.add({
    source = "nvim-treesitter/nvim-treesitter",
    -- 'master' is archived and only exposes the old 'nvim-treesitter.configs' API.
    -- The rewrite lives in 'main' and needs Nvim 0.12+ plus tree-sitter-cli.
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
        "sql",
        "bash",
        "c",
        "cpp",
        "rust",
        "go",
        "gomod",
        "gosum",
        "ini",
        "meson",
        "starlark",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
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
        -- Directory to install parsers and queries to (prepended to 'runtimepath')
        install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- Asynchronous, and a no-op for anything already installed
    require("nvim-treesitter").install(packages)

    -- Parser names are not filetypes ('starlark' is 'bzl', 'tsx' is
    -- 'typescriptreact', ...), so expand the list into every filetype that maps
    -- to one of these languages.
    local filetypes = {}
    for _, lang in ipairs(packages) do
        vim.list_extend(filetypes, vim.treesitter.language.get_filetypes(lang))
    end

    vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function()
            vim.treesitter.start()
        end,
    })
end)
