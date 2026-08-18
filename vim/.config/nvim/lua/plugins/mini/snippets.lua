MiniDeps.later(function()
    require("mini.snippets").setup({
        -- Only LSP-provided snippets for now; 'mini.completion' routes them
        -- here via `default_snippet_insert`. Add `gen_loader.from_lang()` to
        -- also match local/friendly-snippets.
        snippets = {},
    })
end)
