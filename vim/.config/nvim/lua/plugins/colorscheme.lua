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
          },
        },
        specs = {
          all = {
            syntax = {
              string = "#27745c",
              -- variable = "#A66F00",
              -- builtin0 = "#bf6408", -- Builtin variable
              -- builtin1 = "#bf6408", -- Builtin type
              -- builtin2 = "#ff0101", -- Builtin const
              -- comment = "#4fb8cc", -- Comment
              -- conditional = pl.syntax.keyword, -- Conditional and loop
              -- const = "#ff1010", -- Constants, imports and booleans
              -- dep = pal.scale.red[8], -- Deprecated
              field = "#1f1f1f", -- Field
              func = "#871094", -- Functions and Titles
              -- ident = spec.fg1, -- Identifiers
              keyword = "#0033b3", -- Keywords
              number = "#1f1f1f", -- Numbers
              -- operator = pl.syntax.constant, -- Operators
              -- param = "#a66f00", -- Parameters
              -- preproc = pl.syntax.keyword, -- PreProc
              -- regex = pl.syntax.string, -- Regex
              -- statement = pl.syntax.keyword, -- Statements
              -- type = pl.syntax.variable, -- Types
              -- tag = "#ff1111", -- Tags
              -- variable = "#523c79", -- Variables
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
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    name = "cyberdream",
    lazy = false,
    priority = 1000,
    --
    config = function()
      require("cyberdream").setup({
        -- Enable transparent background
        transparent = false,

        -- Enable italics comments
        italic_comments = true,
        theme = { variant = "light" },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_light",
      -- colorscheme = "cyberdream",
    },
  },
}
