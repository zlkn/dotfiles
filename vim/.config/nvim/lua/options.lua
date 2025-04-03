vim.g.mapleader = " "

vim.o.mouse = "a" -- Enable mouse support

-- Don't spawn trash on fs
vim.o.undofile = true -- Enable persistent undo (see also `:h undodir`)
vim.o.backup = false -- Don't store backup while overwriting the file
vim.o.writebackup = false -- Don't store backup while overwriting the file

-- UI options
vim.o.number = true

vim.o.cmdheight = 0
vim.o.scrolloff = 5
vim.o.cursorline = true

vim.o.breakindent = true -- Indent wrapped lines to match line start
vim.o.wrap = false -- Display long lines as just one line

vim.o.statuscolumn = "%l%s" -- Sign columng after numbers
vim.o.signcolumn = "yes" -- Always show sign column (otherwise it will shift text)
vim.o.fillchars = "eob: " -- Don't show `~` outside of buffer

vim.opt.clipboard = "unnamedplus"

-- Editing
vim.o.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
vim.o.incsearch = true -- Show search results while typing
vim.o.infercase = true -- Infer letter cases for a richer built-in keyword completion
vim.o.smartcase = true -- Don't ignore case when searching if pattern has upper case
vim.o.smartindent = true -- Make indenting smart

vim.o.completeopt = "menuone,noselect" -- Customize completions
vim.o.virtualedit = "block" -- Allow going past the end of line in visual block mode
vim.o.formatoptions = "qjl1" -- Don't autoformat comments

-- transparent background
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#d1d1d1" })

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.opt.guicursor = {
    "n-v-c:block-Cursor/lCursor-blinkwait6000-blinkon800-blinkoff200",
    "i-ci:ver25-Cursor/lCursor-blinkwait6000-blinkon800-blinkoff200",
    "r:hor50-Cursor/lCursor-blinkwait6000-blinkon800-blinkoff200",
}

vim.diagnostic.config({
    underline = true,
    -- virtual_text = {
    --     prefix = "",
    --     severity = nil,
    --     source = "if_many",
    --     format = nil,
    -- },

    float = {
        -- UI.
        header = false,
        border = "rounded",
        focusable = true,
    },

    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = "󰗖 ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
        },
    },
    severity_sort = true,
    update_in_insert = false,
})
