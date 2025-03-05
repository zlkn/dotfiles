MiniDeps.later(function()
    print("Processed: after/ftplugin/lua.lua")

    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup({})
end)
