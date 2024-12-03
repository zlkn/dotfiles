return {
    -- {
    --     "diogo464/kubernetes.nvim",
    --     enabled = false,
    -- },
    {},
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
                                ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
                                ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "docker-compose*.{yml,yaml}",
                                ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "argocd-application.yaml",
                                -- ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.0/all.json"] = "k8s/**",
                                -- -- use this if you want to match all '*.yaml' files
                                -- [require("kubernetes").yamlls_schema()] = "*.yaml",
                                -- -- or this to only match '*.<resource>.yaml' files. ex: 'app.deployment.yaml', 'app.argocd.yaml', ...
                                -- [require("kubernetes").yamlls_schema()] = require("kubernetes").yamlls_filetypes(),
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
