return {
    --     "diogo464/kubernetes.nvim",
    --     enabled = false,
    -- },
    -- {
    --     "someone-stole-my-name/yaml-companion.nvim",
    --     dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    --     config = function()
    --         local cfg = require("yaml-companion").setup({
    --             -- Additional schemas available in Telescope picker
    --             schemas = {
    --                 {
    --                     name = "Flux GitRepository",
    --                     uri = "https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/gitrepository-source-v1.json",
    --                 },
    --             },
    --
    --             -- Pass any additional options that will be merged in the final LSP config
    --             -- Defaults: https://github.com/someone-stole-my-name/yaml-companion.nvim/blob/main/lua/yaml-companion/config.lua
    --             lspconfig = {
    --                 settings = {
    --                     yaml = {
    --                         validate = true,
    --                         schemaStore = {
    --                             enable = false,
    --                             url = "",
    --                         },
    --                         schemas = {
    --                             ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
    --                         },
    --                     },
    --                 },
    --             },
    --         })
    --
    --         require("lspconfig")["yamlls"].setup(cfg)
    --
    --         -- Load Telescope extension for yaml schemas
    --         require("telescope").load_extension("yaml_schema")
    --     end,
    -- },
    {
        "neovim/nvim-lspconfig",
        opts = {
            -- make sure mason installs the server
            servers = {
                yamlls = {
                    -- Have to add this for yamlls to understand that we support line folding
                    capabilities = {
                        textDocument = {
                            foldingRange = {
                                dynamicRegistration = false,
                                lineFoldingOnly = true,
                            },
                        },
                    },
                    -- lazy-load schemastore when needed
                    on_new_config = function(new_config)
                        new_config.settings.yaml.schemas = vim.tbl_deep_extend(
                            "force",
                            new_config.settings.yaml.schemas or {},
                            require("schemastore").yaml.schemas()
                        )
                    end,
                    settings = {
                        redhat = { telemetry = { enabled = false } },
                        yaml = {
                            keyOrdering = false,
                            format = {
                                enable = false,
                            },
                            validate = true,
                            schemaStore = {
                                -- Must disable built-in schemaStore support to use
                                -- schemas from SchemaStore.nvim plugin
                                enable = false,
                                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                                url = "",
                            },
                            schemas = {
                                kubernetes = { "k8s**.yaml", "kube*/*.yaml", "tshoot*/*.yaml" },
                                ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
                                ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "docker-compose*.{yml,yaml}",
                                ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "*.Application.yaml",
                                ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/applicationset_v1alpha1.json"] = "*.ApplicationSet.yaml",
                            },
                        },
                    },
                },
            },
            setup = {
                yamlls = function()
                    -- Neovim < 0.10 does not have dynamic registration for formatting
                    if vim.fn.has("nvim-0.10") == 0 then
                        LazyVim.lsp.on_attach(function(client, _)
                            client.server_capabilities.documentFormattingProvider = true
                        end, "yamlls")
                    end
                end,
            },
        },
    },
}
