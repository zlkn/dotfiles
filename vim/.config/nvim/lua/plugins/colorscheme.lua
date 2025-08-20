MiniDeps.add({
    source = "projekt0n/github-nvim-theme",
    name = "github-nvim-theme",
    hooks = {
        post_checkout = function()
            vim.cmd([[ colorscheme github_light ]])
        end,
    },
})

MiniDeps.now(function()
    require("github-theme").setup({
        options = {
            -- Compiled file's destination location
            compile_path = "/tmp/github-theme",
            transparent = true,
            styles = {
                comments = "italic",
                operators = "bold",
                numbers = "bold",
            },
        },
        specs = {
            github_light = {
                syntax = {
                    bracket = "#1f1f1f",
                    builtin0 = "#980054",
                    builtin1 = "#015692",
                    builtin2 = "#8a4794",
                    -- builtib2 = "#8430ce",
                    comment = "#57606a",
                    conditional = "#fb007a",
                    const = "#015692",
                    dep = "#82071e",
                    field = "#004c63",
                    func = "#871094",
                    -- func = "#8430ce",
                    ident = "#424242",
                    keyword = "#0550ae",
                    number = "#424242",
                    operator = "#0a3069",
                    param = "#007474",
                    preproc = "#c30771",
                    regex = "#0a3069",
                    statement = "#fb007a",
                    string = "#0d844c",
                    tag = "#0550ae",
                    -- tag = "#5b4d79",
                    type = "#1f1f1f",
                    variable = "#424242",
                },
                diag = {
                    -- error = pal.danger.fg,
                    -- warn = "#4fb8cc",
                    -- info = "#4fb8cc",
                    hint = "#4fb8cc",
                },
            },
        },
    })

    vim.cmd([[ colorscheme github_light ]])
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#dfdfe1" })

    -- Transparent/“inherit terminal” bg for builtin tabline
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE", fg = "#888888" })
    vim.api.nvim_set_hl(0, "TabLineSel", { bg = "NONE", fg = "#ffffff", bold = true })

    vim.cmd([[ hi FloatBorder guifg=#a1a1a1 guibg=none]])
    vim.cmd([[ hi MiniPickPromptCaret guifg=#a1a1a1 guibg=none ]])
    vim.cmd([[ hi MiniPickPromptPrefix guifg=#a1a1a1 guibg=none]])
    vim.cmd([[ hi MiniPickPrompt guifg=#424242 guibg=none]])

    -- force transparent background for all themes
    vim.cmd([[
        highlight Normal guibg=none
        highlight NonText guibg=none
        highlight Normal ctermbg=none
        highlight NonText ctermbg=none
    ]])
    -- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#007474" })

    -- Minipick
    vim.cmd([[ hi MiniPickMatchRanges guifg=#871094 guibg=none]])

    vim.api.nvim_set_hl(0, "@constructor", { fg = "#980054" })

    --  ansible_semantic_highlight
    vim.api.nvim_set_hl(0, "@lsp.type.class", { fg = "#980054" })
    vim.api.nvim_set_hl(0, "@lsp.type.method.yaml.ansible", { fg = "#004c63" })

    -- golang semantic highlight
    vim.api.nvim_set_hl(0, "@keyword.function", { fg = "#015692", bold = true })
end)
