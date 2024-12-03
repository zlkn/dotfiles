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
                        functions = "bold",
                        comments = "italic",
                        keywords = "bold",
                        types = "italic",
                        tag = "bold",
                    },
                },
                specs = {
                    github_light = {
                        syntax = {
                            bracket = "#1F2328",
                            builtin0 = "#0550ae",
                            -- builtin1 = "#cf222e",
                            builtin1 = "#20a5ba",
                            -- builtin1 = "#1f1f1f",
                            builtin2 = "#523c79",
                            comment = "#57606a",
                            conditional = "#cf222e",
                            const = "#0550ae",
                            dep = "#82071e",
                            field = "#1f1f1f",
                            func = "#871094",
                            ident = "#1f1f1f",
                            keyword = "#0055c4",
                            number = "#1f1f1f",
                            operator = "#0550ae",
                            param = "#1F2328",
                            preproc = "#cf222e",
                            regex = "#0a3069",
                            statement = "#cf222e",
                            string = "#27745c",
                            tag = "#0055c4",
                            type = "#953800",
                            -- variable = "#008ec4",
                            variable = "#1f1f1f",
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
