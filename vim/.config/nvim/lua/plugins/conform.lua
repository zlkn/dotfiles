-- TODO: Remove if autocommand formatter by lsp & treesitter good enough
MiniDeps.add("stevearc/conform.nvim")
MiniDeps.later(function()
    local conform = require("conform")
    conform.setup({
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_format = "fallback",
        },
        formatters_by_ft = {
            lua = { "stylua" },
            hcl = { "packer_fmt" },
            terraform = { "terraform_fmt" },
            tf = { "terraform_fmt" },
            ["terraform-vars"] = { "terraform_fmt" },
        },
    })
end)
