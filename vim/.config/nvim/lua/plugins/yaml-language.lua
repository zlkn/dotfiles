return {
  { -- configure LSPs
    "neovim/nvim-lspconfig",
    dependencies = "folke/neodev.nvim",
    init = function()
	require("neodev").setup({
	  library = { plugins = false },
        })
	require("lspconfig").yamlls.setup({
          settings = {
            yaml = { keyOrdering = false },
          },
	})
    end,
  },
}
