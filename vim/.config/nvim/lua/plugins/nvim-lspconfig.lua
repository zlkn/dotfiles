MiniDeps.add("neovim/nvim-lspconfig")
MiniDeps.later(function()
    print("Setup lsp servers")
    local lspconfig = require("lspconfig")

    local function get_diagnostic()
        local diagnostics = vim.diagnostic.get(0) -- 0 means current buffer
        for _, d in ipairs(diagnostics) do
            print(d.message)
        end
    end

    -- vim.keymap.set("n", "<leader>ld", get_diagnostic(), { desc = "Get diagnotics messages for current buffer", remap = true, silent = true })
end)
