return {
  "someone-stole-my-name/yaml-companion.nvim",
  lazy = false,
  dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
    },
  config = function()
    local cfg = require("yaml-companion").setup({
      lspconfig = {
        settings = {
          yaml = {
            validate = true,
            schemaStore = {
              enable = true,
              url = "https://www.schemastore.org/api/json/catalog.json",
            }
          }
        }
      },
      schemas = {
        {
          name = "Kubernetes 1.22.4",
          uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
        },
        {
          uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
          name = "Argo CD Application",
          fileMatch = { "Application.yaml", "ApplicationSet.yaml" },
        }
      },
    })
  require("lspconfig")["yamlls"].setup(cfg)
	end,
}
