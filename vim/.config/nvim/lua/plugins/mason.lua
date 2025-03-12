MiniDeps.add("williamboman/mason.nvim")
MiniDeps.later(function()
    local mason = require("mason")
    mason.setup({
        ensure_installed = {
            "stylua",
            "lua-language-server",
            "yaml-language-server",
            "tflint",
        },
        ui = {
            border = "rounded",
        },
    })
end)
