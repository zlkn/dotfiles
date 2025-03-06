MiniDeps.add({
    source = "nvim-lualine/lualine.nvim",
    name = "lualine",
})

-- transparent background for lualine
-- https://www.reddit.com/r/neovim/comments/zh4kc8/comment/jhekub8/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
local auto_theme_custom = require("lualine.themes.auto")
for mode, _ in pairs(auto_theme_custom) do
    -- auto_theme_custom[mode].c.bg = "none"
    auto_theme_custom[mode].c.bg = "#f4f5f5"
    auto_theme_custom[mode].c.fg = "#313131"
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

local function lsp_status()
    return function()
        if vim.lsp.buf_get_clients() > 0 then
            print("buf_get_clients: " .. vim.lsp.buf_get_clients())
            local lsp = vim.lsp.util.get_progress_messages()[1]
            if lsp then
                local name = lsp.name or ""
                local msg = lsp.message or ""
                local percentage = lsp.percentage or 0
                local title = lsp.title or ""
                return string.format("lsp: %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
            end
        end
        return "lsp: none"
    end
end

require("lualine").setup({
    options = {
        theme = auto_theme_custom,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        always_show_tabline = true,
        globalstatus = true,
    },
    sections = {
        lualine_c = {},
        lualine_z = { "encoding" },
    },
    tabline = {
        lualine_c = {
            { git_root() },
            {
                "diagnostics",
                -- symbols = {
                --     error = "✘",
                --     warn = "▲",
                --     info = "ℹ",
                --     hint = "⚑",
                -- },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
                "filename",
                file_status = true,
                newfile_status = false,
                path = 1,
                shorting_target = 40,
                symbols = {
                    modified = "m",
                    readonly = "󱚳 ",
                    unnamed = "[NoName]",
                    newfile = "[New]",
                },
            },
        },
        lualine_z = { { lsp_status() } },
    },
})
