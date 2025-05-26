MiniDeps.add("williamboman/mason.nvim")
MiniDeps.later(function()
    -- https://github.com/mason-org/mason.nvim/discussions/1760
    local mason = require("mason")
    mason.setup({ ui = { border = "single" } })

    local packages = {
        "lua-language-server",
        "bash-language-server",
        "dockerfile-language-server",
        "ruff",
    }

    local mason_registry = require("mason-registry")
    for _, pkg in pairs(packages) do
        local package = mason_registry.get_package(pkg)
        if not package:is_installed() then
            package:install()
        end
    end
end)
