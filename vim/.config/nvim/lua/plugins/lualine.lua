return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = LazyVim.config.icons
      opts.options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = ''},
      }
      opts.sections.lualine_z = {}
    end,
  },
}
