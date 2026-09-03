MiniDeps.add({
    source = "nvim-lualine/lualine.nvim",
    name = "lualine",
})

local function lualine_aqua()
    local palette = require("palette")
    local function mode_color(fg)
        return {
            a = { fg = fg, bg = none },
            b = { fg = fg, bg = none },
            c = { fg = fg, bg = none },
        }
    end

    return {
        normal = mode_color(palette.normal),
        insert = mode_color(palette.ansi.green),
        visual = mode_color(palette.ansi.magenta),
        replace = mode_color(palette.ansi.red),
        command = mode_color(palette.ansi.yellow),
        terminal = mode_color(palette.ansi.cyan),
        inactive = mode_color(palette.extra.gray2),
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
                        error = vim.g.symbols.error,
                        warn = vim.g.symbols.warn,
                        hint = vim.g.symbols.hint,
                        info = vim.g.symbols.info,
                    },
                },
            },
            lualine_y = {
                "searchcount",
                -- get_lsp(),
                {
                  'lsp_status',
                  icon =  "󱔸 ", -- f013
                  symbols = {
                    -- Standard unicode symbols to cycle through for LSP progress:
                    spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                    -- Standard unicode symbol for when LSP is done:
                    done = '✓',
                    -- Delimiter inserted between LSP names:
                    separator = ' ',
                  },
                  -- List of LSP names to ignore (e.g., `null-ls`):
                  ignore_lsp = {},
                  -- Display the LSP name
                  show_name = true,
            }
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
