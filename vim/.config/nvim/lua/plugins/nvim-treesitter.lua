return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "HiPhish/nvim-ts-rainbow2" },
    opts = function(_, opts)
      opts.ensure_installed = {
        "hcl",
        "terraform",
      }
      opts.highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
      }
    end,
  },
}
