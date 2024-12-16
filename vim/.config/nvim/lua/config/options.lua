-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_prettier_needs_config = false
vim.opt.pumblend = 0

vim.o.tabstop = 2 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2 -- Number of spaces inserted when indenting

vim.opt.guicursor = {
    "n-v-c:block-Cursor/lCursor-blinkwait6000-blinkon800-blinkoff200",
    "i-ci:ver25-Cursor/lCursor-blinkwait6000-blinkon800-blinkoff200",
    "r:hor50-Cursor/lCursor-blinkwait6000-blinkon800-blinkoff200",
}

-- vim.o.winbar = "This is my Winbar"
-- vim.o.tabline = "This is my Tabline"
-- vim.o.showtabline = 2
