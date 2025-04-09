MiniDeps.add("williamboman/mason.nvim")
MiniDeps.now(function()
    local mason = require("mason")
    mason.setup({
        ensure_installed = {
            "stylua",
            "lua-language-server",
            "yaml-language-server",
            "tflint",
            "terraform-ls",
        },
        ui = {
            border = "rounded",
        },
    })
end)
