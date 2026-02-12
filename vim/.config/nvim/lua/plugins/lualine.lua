MiniDeps.add({
    source = "nvim-lualine/lualine.nvim",
    name = "lualine",
})

local function lualine_aqua()
    local palette = require("palette")
    return {
        normal = {
            a = { bg = none, fg = palette.normal },
            b = { bg = none, fg = palette.normal },
            c = { bg = none, fg = palette.normal },
        },
        insert = {
            a = { bg = palette.light.green, fg = palette.normal },
            b = { bg = palette.light.green, fg = palette.normal },
            c = { bg = palette.light.green, fg = palette.normal },
        },
        visual = {
            a = { bg = palette.light.blue, fg = palette.normal },
            b = { bg = palette.light.blue, fg = palette.normal },
            c = { bg = palette.light.blue, fg = palette.normal },
        },
        replace = {
            a = { bg = palette.light.red, fg = palette.normal },
            b = { bg = palette.light.red, fg = palette.normal },
            c = { bg = palette.light.red, fg = palette.normal },
        },
        command = {
            a = { bg = palette.light.yellow, fg = palette.normal },
            b = { bg = palette.light.yellow, fg = palette.normal },
            c = { bg = palette.light.yellow, fg = palette.normal },
        },
        inactive = {
            a = { bg = none, fg = palette.normal },
            b = { bg = none, fg = palette.normal },
            c = { bg = none, fg = palette.normal },
        },
    }
end

local function keytrail_in_yaml()
    return function()
        local path = require("yaml").get_treesitter_path()
        if path == "" or path == "nil" then
            return ""
        end
        return " " .. path
    end
end

local function get_lsp()
    return function()
        local names = {}
        local copilot = " "

        -- Get LSP clients attached to the current buffer onlo
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

        return "󱉭 " .. git_dir
    end
end

MiniDeps.later(function()
    require("lualine").setup({
        options = {
            -- theme = auto_theme_custom,
            theme = lualine_aqua(),
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
            lualine_y = {
                "searchcount",
                get_lsp(),
            },
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
                { keytrail_in_yaml() },
            },
            lualine_z = {},
        },
    })
end)
