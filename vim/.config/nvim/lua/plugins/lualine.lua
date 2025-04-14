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
        return "󱔸 : " .. vim.lsp.get_clients()[1].name or "None"
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

require("lualine").setup({
    options = {
        theme = auto_theme_custom,
        -- section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        always_show_tabline = true,
        globalstatus = true,
        section_separators = "",
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { "branch", "diff" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { get_lsp() },
        lualine_z = { "progress", "location", "encoding", "filetype", "fileformat" },
    },
    tabline = {
        lualine_c = {
            { git_root() },
            {
                "diagnostics",
                -- symbols = {
                --     -- error = " ",
                --     -- warn = " ",
                --     -- info = " ",
                --     -- hint = " ",
                -- },
                symbols = {
                    error = " ",
                    --    warn = " ",
                    warn = "󰗖 ",
                    hint = " ",
                    info = " ",
                },
            },
            -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
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
        },
        lualine_z = {},
    },
})
