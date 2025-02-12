return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, {
                    "terraform",
                    "hcl",
                })
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                terraformls = {
                    cmd = { "terraform-ls", "serve" },
                    filetypes = { "terraform", "tf" },
                    root_dir = require("lspconfig.util").root_pattern(".git", ".terraform", ".tf"),
                },
            },
        },
    },
    -- ensure terraform tools are installed
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "tflint" })
        end,
    },
    -- {
    --     "mfussenegger/nvim-lint",
    --     optional = true,
    --     opts = {
    --         linters_by_ft = {
    --             terraform = { "terraform_validate" },
    --             tf = { "terraform_validate" },
    --         },
    --     },
    -- },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                terraform = { "terraform_fmt" },
                tf = { "terraform_fmt" },
                ["terraform-vars"] = { "terraform_fmt" },
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            {
                "ANGkeith/telescope-terraform-doc.nvim",
                config = function()
                    LazyVim.on_load("telescope.nvim", function()
                        require("telescope").load_extension("terraform_doc")
                    end)
                end,
            },
            {
                "cappyzawa/telescope-terraform.nvim",
                config = function()
                    LazyVim.on_load("telescope.nvim", function()
                        require("telescope").load_extension("terraform")
                    end)
                end,
            },
        },
    },
}
