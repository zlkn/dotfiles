MiniDeps.add({
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "main",
    monitor = "main",
    hooks = {
        post_checkout = function()
            require("nvim-treesitter").update()
        end,
    },
})

MiniDeps.now(function()
    require("nvim-treesitter").setup({})

    local parsers = {
        "sql", "bash", "c", "cpp", "rust", "go", "gomod", "gosum",
        "ini", "meson", "starlark", "diff", "html", "javascript",
        "jsdoc", "json", "lua", "luadoc", "luap", "markdown",
        "markdown_inline", "printf", "python", "query", "regex",
        "toml", "tsx", "vim", "vimdoc", "xml", "yaml", "terraform",
        "hcl", "jinja", "jinja_inline", "helm"
    }

    -- Only trigger background installation for missing parsers
    local installed = require("nvim-treesitter.config").get_installed()
    local missing = vim.tbl_filter(function(p)
        return not vim.tbl_contains(installed, p)
    end, parsers)

    if #missing > 0 then
        require("nvim-treesitter").install(missing)
    end

    -- Automatically attach Neovim's built-in treesitter highlighting
    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
        callback = function(args)
            pcall(vim.treesitter.start, args.buf)
        end,
    })
end)
