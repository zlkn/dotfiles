MiniDeps.later(function()
    print("Processed: after/ftplugin/yaml.lua")

    local lspconfig = require("lspconfig")
    lspconfig.yamlls.setup({
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
    })
end)
