MiniDeps.add({ source = "arborist-ts/arborist.nvim" })

MiniDeps.now(function()
    require("arborist").setup({
        -- Do not eagerly install the built-in "popular" set; keep an explicit,
        -- curated list instead. Anything not listed still installs on demand
        -- when a matching file is opened.
        install_popular = false,

        -- No wasmtime in this Neovim build, so parsers compile natively anyway.
        prefer_wasm = false,

        ensure_installed = {
            "sql",
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
        },
    })
end)
