-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function(args)
        vim.cmd([[ hi! Cursor guibg=NONE guifg=NONE gui=reverse ]])
    end,
})
