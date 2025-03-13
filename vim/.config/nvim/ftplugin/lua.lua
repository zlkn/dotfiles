MiniDeps.later(function()
    print("Processed: after/ftplugin/lua.lua")

    local lspconfig = require("lspconfig")
    local lsputils = require("lspconfig.util")

    lspconfig.lua_ls.setup({
        -- Force the workspace root to a static path where your .luarc.json is located.
        root_dir = function()
            -- return "/home/yzolkin/dotfiles/vim/.config/nvim/.luarc.json"
            return lsputils.root_pattern(".git", ".luarc.json", "stylua.toml")
        end,
        settings = {
            Lua = {},
        },
    })
end)
