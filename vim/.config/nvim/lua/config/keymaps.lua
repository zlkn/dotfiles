-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional autocmds here

---
local function search_and_notify_kind()
    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    local kind_values = {}
    local pattern = "kind:%s*(%w+)"

    -- Iterate over lines and search for the pattern
    for _, line in ipairs(lines) do
        local kind = line:match(pattern)
        if kind then
            table.insert(kind_values, kind)
        end
    end

    -- Send notification about the found kinds
    if #kind_values > 0 then
        vim.api.nvim_notify("Found kinds: " .. table.concat(kind_values, ", "), vim.log.levels.INFO, {})
    else
        vim.api.nvim_notify("No 'kind' keypairs found.", vim.log.levels.INFO, {})
    end
end

-- Create a user command to call the function
vim.api.nvim_create_user_command("SearchAndNotifyKind", search_and_notify_kind, {})
vim.api.nvim_set_keymap("n", "<leader>rr", [[:SearchAndNotifyKind<CR>]], { noremap = true, silent = true })

local function print_current_pallete()
    local spec = require("github-theme.spec").load("github_light")
    print(vim.inspect(spec.syntax))
end

vim.api.nvim_create_user_command("PrintCurrentPallete", print_current_pallete, {})
vim.api.nvim_set_keymap("n", "<leader>rp", [[:PrintCurrentPallete<CR>]], { noremap = true, silent = true })
