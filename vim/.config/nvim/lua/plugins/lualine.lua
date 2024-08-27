return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)

      -- transparent background for lualine
      -- https://www.reddit.com/r/neovim/comments/zh4kc8/comment/jhekub8/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
      local auto_theme_custom = require('lualine.themes.auto')
      auto_theme_custom.normal.c.bg = 'none'
      auto_theme_custom.insert.c.bg = 'none'
      auto_theme_custom.visual.c.bg = 'none'

      opts.options = {
        theme = auto_theme_custom,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = ''},
      }
      opts.sections.lualine_z = {}
    end,
  },
}
