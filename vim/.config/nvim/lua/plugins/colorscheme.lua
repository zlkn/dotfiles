return {
    {
        "projekt0n/github-nvim-theme",
        name = "github-nvim-theme",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins

        config = function()
            require("github-theme").setup({
                options = {
                    -- Compiled file's destination location
                    compile_path = "/tmp/github-theme",
                    transparent = true,
                    styles = {
                        builtin2 = "boold",
                        functions = "italic",
                        comments = "italic",
                        keywords = "bold",
                        types = "bold",
                        tags = "bold",
                        operators = "bold",
                    },
                },
                specs = {
                    github_light = {
                        syntax = {
                            bracket = "#212121",
                            builtin0 = "#c30771",
                            builtin1 = "#008ec4",
                            builtin2 = "#523c79",
                            comment = "#57606a",
                            conditional = "#cf222e",
                            const = "#0550ae",
                            dep = "#82071e",
                            field = "#212121",
                            func = "#871094",
                            ident = "#212121",
                            keyword = "#0550ae",
                            number = "#212121",
                            operator = "#0550ae",
                            -- param = "#008ec4",
                            -- param = "#20B2AA",
                            param = "#007474",
                            -- param = "#0a3069",
                            -- param = "#20bbfc",
                            preproc = "#cf222e",
                            regex = "#0a3069",
                            statement = "#cf222e",
                            string = "#27745c",
                            tag = "#0055c4",
                            type = "#1f1f1f",
                            variable = "#212121",
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
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "github_light",
        },
    },
}
