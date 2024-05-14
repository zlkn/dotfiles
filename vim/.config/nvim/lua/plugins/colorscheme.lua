return {
  {
    "projekt0n/github-nvim-theme",
    name = "github",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins

    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "",
            string = "italic",
            func = "bold",
            const = "italic",
          },
        },
        specs = {
          all = {
            syntax = {
              string = "#27745c",
              -- variable = "#A66F00",
              -- builtin0 = "#0a3069", -- Builtin variable
              -- builtin1 = pl.syntax.keyword, -- Builtin type
              -- builtin2 = pl.syntax.constant, -- Builtin const
              -- comment = pl.syntax.comment, -- Comment
              -- conditional = pl.syntax.keyword, -- Conditional and loop
              -- const = pl.syntax.constant, -- Constants, imports and booleans
              -- dep = pal.scale.red[8], -- Deprecated
              -- field = pl.syntax.constant, -- Field
              func = "#871094", -- Functions and Titles
              -- ident = spec.fg1, -- Identifiers
              keyword = "#0033b3", -- Keywords
              -- number = pl.syntax.constant, -- Numbers
              -- operator = pl.syntax.constant, -- Operators
              -- param = "#a66f00", -- Parameters
              -- preproc = pl.syntax.keyword, -- PreProc
              -- regex = pl.syntax.string, -- Regex
              -- statement = pl.syntax.keyword, -- Statements
              -- type = pl.syntax.variable, -- Types
              -- tag = pl.syntax.entityTag, -- Tags
              -- variable = "#523c79", -- Variables
            },
          },
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_light",
    },
  },
}
