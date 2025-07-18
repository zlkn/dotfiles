MiniDeps.add("lewis6991/gitsigns.nvim")
MiniDeps.later(function()
    local gitsigns = require("gitsigns")
    gitsigns.setup({
        current_line_blame = false,
    })
    -- vim.api.nvim_set_keymap("n", "<Space>bl", [[<Cmd>lua require"gitsigns".blame_line()<CR>]], { noremap = true, silent = true })
    vim.keymap.set("n", "<Space>bl", [[ <Cmd>:Gitsigns toggle_current_line_blame <CR> ]], { noremap = true, silent = true })
    vim.keymap.set("n", "<Space>bh", [[ <Cmd>:Gitsigns diffthis <CR>]], { noremap = true, silent = true })
end)
