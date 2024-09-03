return {
  "someone-stole-my-name/yaml-companion.nvim",
  lazy = false,
  config = function()
  local cfg = require("yaml-companion").setup({

    -- Add any options here, or leave empty to use the default settings
    -- lspconfig = {
    --   cmd = {"yaml-language-server"}
    -- },
        schemas = {
          {
            name = "Flux GitRepository",
            uri = "https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/gitrepository-source-v1.json",
          },
          {
          uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json',
          name = 'Argo CD Application',
          }
        },
  })
  require("lspconfig")["yamlls"].setup(cfg)
	end,
}
