MiniDeps.add({
    source = "nvim-lualine/lualine.nvim",
    name = "lualine",
})

-- transparent background for lualine
-- https://www.reddit.com/r/neovim/comments/zh4kc8/comment/jhekub8/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
local auto_theme_custom = require("lualine.themes.auto")
for mode, _ in pairs(auto_theme_custom) do
    for _, part in ipairs({ "a", "b", "c" }) do
        auto_theme_custom[mode][part].bg = "#f4f5f5"
        -- auto_theme_custom[mode].c.bg = "none"
        auto_theme_custom[mode][part].fg = "#313131"
    end
end

local function get_lsp()
    return function()
        local names = {}
        local copilot = " "

        -- local clients = vim.lsp.get_clients()
        -- Get LSP clients attached to the current buffer only
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })

        if not clients or next(clients) == nil then
            return "  󱔹 "
        end

        for _, client in pairs(clients) do
            if client.name == "copilot" then
                copilot = " "
            else
                table.insert(names, client.name)
            end
        end

        return copilot .. " 󱔸 " .. table.concat(names, "/")
    end
end

local function mode()
    local mode_icons = {
        n = " ", -- Normal mode, a balanced icon
        i = " ", -- Insert mode, a pencil-like icon
        v = "󱈅 ", -- Visual mode, a classic choice
        V = "󱈅 ", -- Visual-line mode, a variant for line-wise selection
        c = " ", -- Command mode, a sharp icon
        R = " ", -- Replace mode, a distinct icon
    }
    local current_mode = vim.fn.mode()
    return mode_icons[current_mode] or "Unknown"
end

local function git_root()
    return function()
        local git_dir = vim.fn.finddir(".git", ".;")
        if git_dir == "" then
            return ""
        end

        git_dir = vim.fn.fnamemodify(git_dir, ":p:h:h")
        git_dir = vim.fn.fnamemodify(git_dir, ":t")

        return " " .. git_dir
    end
end

MiniDeps.later(function()
    require("lualine").setup({
        options = {
            theme = auto_theme_custom,
            always_show_tabline = true,
            globalstatus = true,
            section_separators = "",
            component_separators = "",
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {
                "minipick",
                "neo-tree",
                "toggleterm",
                "netrw",
                "TelescopePrompt",
                "mason",
                "lazy",
            },
        },
        sections = {
            lualine_a = { mode },
            lualine_b = { "branch", "diff" },
            lualine_c = {},
            lualine_x = {
                {
                    "diagnostics",
                    symbols = {
                        error = " ",
                        warn = "󰗖 ",
                        hint = " ",
                        info = " ",
                    },
                },
            },
            lualine_y = { get_lsp() },
            lualine_z = { "progress", "filetype", "fileformat" },
        },
        tabline = {
            lualine_c = {
                { git_root() },
                {
                    "filename",
                    file_status = true,
                    newfile_status = false,
                    path = 1,
                    shorting_target = 40,
                    symbols = {
                        modified = " ",
                        readonly = "󱚳 ",
                        unnamed = "",
                        newfile = "[New]",
                    },
                },
                {
                    function()
                        local f = require("nvim-treesitter").statusline({
                            indicator_size = 70,
                            type_patterns = {
                                -- "class",
                                -- "function",
                                -- "method",
                                -- "interface",
                                -- "type_spec",
                                -- "table",
                                -- "if_statement",
                                -- "for_statement",
                                -- "for_in_statement",
                                -- "block_mapping_pair",
                                "string_scalar",
                            },
                        })
                        for node in f do
                            if node.type == "string_scalar" then
                                return "󰅌 " .. node.text
                            end
                        end
                        local context = string.format("%s", f) -- convert to string, it may be a empty ts node

                        if context == "vim.NIL" then
                            return " "
                        end
                        return " " .. context
                    end,
                },
            },
            lualine_z = {},
        },
    })
end)
