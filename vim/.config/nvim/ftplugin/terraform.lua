MiniDeps.later(function()
    print("Processed: ftplugin/terraform.lua")
    local lspconfig = require("lspconfig")
    lspconfig.terraformls.setup({
        servers = {
            terraformls = {
                cmd = { "terraform-ls", "serve" },
                filetypes = { "terraform", "tf" },
                root_dir = require("lspconfig.util").root_pattern(".git", ".terraform", ".tf"),
            },
        },
    })

    lspconfig.tflint.setup({})
end)
