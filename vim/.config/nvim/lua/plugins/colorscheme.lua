return {
  -- {
  -- 	"nick-kadutskyi/vim-jb", -- My color theme (forked from devsjs/vim-js)
  -- 	name = "jb",
  -- 	-- dev = true, -- theme is in dev but falls back to my public GitHub repo
  -- 	init = function()
  -- 		vim.g.jb_enable_italics = 1 -- Enables intalics
  -- 		vim.g.jb_style = "light" -- JB defualt light theme
  -- 	end,
  -- },
  -- {
  -- 	"rmehri01/onenord.nvim",
  -- 	name = "onenord",
  -- 	opts = {
  -- 		disable = {
  -- 			background = true, -- Disable setting the background color
  -- 		},
  -- 	},
  -- },
  {
    "projekt0n/github-nvim-theme",
    name = "github",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins

    config = function()
      require("github-theme").setup({
        options = {
          theme_style = "light",
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "",
          },
          darken = { -- Darken floating windows and sidebar-like windows
            floats = true,
            sidebars = {
              enabled = false,
              list = {}, -- Apply dark background to specific windows
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
