MiniDeps.add({
    source = "nvim-treesitter/nvim-treesitter",
    -- 'master' is archived and only exposes the old 'nvim-treesitter.configs' API.
    -- The rewrite lives in 'main' and needs Nvim 0.12+ plus tree-sitter-cli.
    checkout = "main",
    monitor = "main",
    hooks = {
        post_checkout = function()
            -- Lua API, not :TSUpdate: plugin/ files are sourced after init.lua,
            -- so the command does not exist yet on a fresh install.
            require("nvim-treesitter").update()
        end,
    },
})

MiniDeps.now(function()
    local parsers = {
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

    require("nvim-treesitter").setup({})

    -- Runs async and is a no-op for already installed parsers.
    -- Unlike arborist there is no on-demand install: this list is the full set.
    require("nvim-treesitter").install(parsers)

    -- The plugin only ships parsers/queries, highlighting is started by core
    vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
            local lang = vim.treesitter.language.get_lang(args.match)
            if not lang then
                return
            end
            pcall(vim.treesitter.start, args.buf, lang)
        end,
    })
end)
