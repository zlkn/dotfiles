local function augroup(name)
    return vim.api.nvim_create_augroup("ag_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

-- Reread file on external changes
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- Highlight on yank
autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", priority = 1000 })
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
    group = augroup("create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- Remember last cursor place
autocmd("BufReadPost", {
    group = augroup("global"),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- https://www.reddit.com/r/neovim/comments/1ms0jrs/poor_mans_autoformatter_with_treesitter/
-- LSP and fallback treesitter autoformat
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        if next(vim.lsp.get_clients({ bufnr = 0 })) ~= nil then
            vim.lsp.buf.format({ async = false })
        else
            local pos = vim.api.nvim_win_get_cursor(0)
            vim.cmd("normal! gg0=G")
            vim.api.nvim_win_set_cursor(0, pos)
        end
    end,
})

-- Show cursorline in current window in normal mode
autocmd({ "InsertLeave", "WinEnter" }, {
    group = augroup("cursorline"),
    callback = function()
        vim.o.cursorline = true
    end,
})

-- Hide cursorline in insert mode and on windows leave
autocmd({ "InsertEnter", "WinLeave" }, {
    group = augroup("cursorline"),
    callback = function()
        vim.o.cursorline = false
    end,
})
