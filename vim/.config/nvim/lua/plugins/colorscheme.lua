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
                builtin2 = "italic",
                -- functions = "bold",
                comments = "italic",
                -- keywords = "bold",
                types = "bold",
                -- tags = "bold",
                operators = "bold",
                numbers = "bold",
            },
        },
        specs = {
            github_light = {
                syntax = {
                    bracket = "#313131",
                    builtin0 = "#980054",
                    builtin1 = "#008ec4",
                    builtin2 = "#523c79",
                    comment = "#57606a",
                    conditional = "#cf222e",
                    const = "#0550ae",
                    dep = "#82071e",
                    field = "#004c63",
                    func = "#871094",
                    ident = "#313131",
                    keyword = "#0550ae",
                    number = "#313131",
                    operator = "#0550ae",
                    param = "#007474",
                    preproc = "#c30771",
                    regex = "#0a3069",
                    statement = "#cf222e",
                    string = "#0d844c",
                    tag = "#0055c4",
                    type = "#1f1f1f",
                    variable = "#313131",
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
    -- debug print for visualizing the colorscheme
    -- local spec = require("github-theme.spec").load("github_light")
    -- print(vim.inspect(spec.syntax))

    vim.cmd([[ colorscheme github_light ]])
    vim.cmd([[ hi FloatBorder guifg=#a1a1a1 guibg=#f4f5f5]])
    vim.cmd([[ hi MiniPickPromptCaret guifg=#a1a1a1 guibg=#f4f5f5]])
    vim.cmd([[ hi MiniPickPromptPrefix guifg=#a1a1a1 guibg=#f4f5f5]])
    vim.cmd([[ hi MiniPickPrompt guifg=#313131 guibg=#f4f5f5]])

    vim.cmd([[ hi MiniPickMatchRanges guifg=#871094 guibg=none]])
end)
