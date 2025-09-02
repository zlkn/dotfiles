MiniDeps.add("mrjones2014/smart-splits.nvim")
MiniDeps.later(function()
    require("smart-splits").setup({})
    -- moving between splits
    vim.keymap.set("n", "<A-h>", require("smart-splits").move_cursor_left)
    vim.keymap.set("n", "<A-j>", require("smart-splits").move_cursor_down)
    vim.keymap.set("n", "<A-k>", require("smart-splits").move_cursor_up)
    vim.keymap.set("n", "<A-l>", require("smart-splits").move_cursor_right)
end)
