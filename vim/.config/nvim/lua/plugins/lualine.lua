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
        opts.sections.lualine_c = {
            {
                "diff",
                symbols = {
                    added = icons.git.added,
                    modified = icons.git.modified,
                    removed = icons.git.removed,
                },
                source = function()
                    local gitsigns = vim.b.gitsigns_status_dict
                    if gitsigns then
                        return {
                            added = gitsigns.added,
                            modified = gitsigns.changed,
                            removed = gitsigns.removed,
                        }
                    end
                end,
            },
            { LazyVim.lualine.pretty_path() },
        }
        -- opts.sections.lualine_c = {}
        opts.sections.lualine_x = {
            -- stylua: ignore
            {
                function() return require("noice").api.status.command.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                color = function() return LazyVim.ui.fg("Statement") end,
            },
            -- stylua: ignore
            {
                function() return require("noice").api.status.mode.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                color = function() return LazyVim.ui.fg("Constant") end,
            },
            -- stylua: ignore
            {
                function() return "  " .. require("dap").status() end,
                cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                color = function() return LazyVim.ui.fg("Debug") end,
            },
            -- stylua: ignore
            {
                require("lazy.status").updates,
                cond = require("lazy.status").has_updates,
                color = function() return LazyVim.ui.fg("Special") end,
            },
        }
        opts.sections.lualine_z = { { "encoding" }, { extensions = { "neo-tree", "lazy" } } }

        opts.tabline = {
            lualine_b = {
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
