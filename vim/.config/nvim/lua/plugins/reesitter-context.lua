return {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
        max_lines = 0,
    },
    config = function(_, opts)
        require("treesitter-context").setup(opts)

        -- Set the highlight for TreesitterContext after the plugin is loaded
        vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#e7eaf0" })
    end,
}
