return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",

    opts = function(_, opts)
        -- transparent background for lualine
        -- https://www.reddit.com/r/neovim/comments/zh4kc8/comment/jhekub8/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        local auto_theme_custom = require("lualine.themes.auto")
        for mode, _ in pairs(auto_theme_custom) do
            auto_theme_custom[mode].c.bg = "none"
        end

        local icons = LazyVim.config.icons

        opts.options = {
            theme = auto_theme_custom,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            always_show_tabline = true,
        }

        opts.sections.lualine_c = {}
        opts.sections.lualine_z = {
            { "encoding" },
            { extensions = { "neo-tree", "lazy" } },
        }
        opts.tabline = {
            lualine_c = {
                LazyVim.lualine.root_dir(),
                {
                    "diagnostics",
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warn,
                        info = icons.diagnostics.Info,
                        hint = icons.diagnostics.Hint,
                    },
                },
                { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                { LazyVim.lualine.pretty_path() },
            },
        }
    end,
}
