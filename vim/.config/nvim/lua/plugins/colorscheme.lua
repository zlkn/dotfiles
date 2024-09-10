return {
  {
    "projekt0n/github-nvim-theme",
    -- tag = "v1.0.2",
    name = "github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins

    config = function()
      require("github-theme").setup({
        options = {
              -- Compiled file's destination location
          compile_path = '/tmp/github-theme',
          compile_file_suffix = '_compiled', -- Compiled file suffix
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
            tag = "bold"
          },
        },
        palettes = {
          all = {
            bg0 = "#f8f8f8",
            bg1 = "#f8f8f8",
            bg2 = "#f8f8f8",
            bg3 = "#f8f8f8",
            bg4 = "#f8f8f8",
          }
        },
        specs = {
          github_light = {
            syntax = {
              string = "#27745c",
              variable = "#1f1f1f",
              -- builtin0 = "#bf6408", -- Builtin variable
              -- builtin1 = "#bf6408", -- Builtin type
              -- builtin2 = "#ff0101", -- Builtin const
              -- comment = "#4fb8cc", -- Comment
              -- conditional = pl.syntax.keyword, -- Conditional and loop
              -- const = "#ff1010", -- Constants, imports and booleans
              -- dep = pal.scale.red[8], -- Deprecated
              field = "#1f1f1f", -- Field
              func = "#871094", -- Functions and Titles
              ident = "#1f1f1f", -- Identifiers
              keyword = "#0033b3", -- Keywords
              number = "#1f1f1f", -- Numbers
              -- operator = pl.syntax.constant, -- Operators
              -- param = "#a66f00", -- Parameters
              -- preproc = pl.syntax.keyword, -- PreProc
              -- regex = pl.syntax.string, -- Regex
              -- statement = pl.syntax.keyword, -- Statements
              -- type = "#bf6408", -- Types
              tag = "#523c79", -- Tags
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
      -- debug print for visualizing the colorscheme
      -- local spec = require('github-theme.spec').load('github_light')
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
