-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function git_root()
    local git_dir = vim.fn.finddir(".git", ".;")
    if git_dir == "" then
        return nil
    end

    git_dir = vim.fn.fnamemodify(git_dir, ":p:h:h")
    git_dir = vim.fn.fnamemodify(git_dir, ":t")

    return git_dir
end

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function(event)
        local title = "vim"
        local icon = "󱉭 "

        if event.file ~= "" then
            local file_name = vim.fs.basename(event.file)

            local git_dir = git_root()

            if git_dir ~= nil then
                if git_dir == "dotfiles" then
                    local path = vim.fn.fnamemodify(event.file, ":p:h:t")
                    title = string.format("%s", icon .. git_dir .. "/" .. path)
                else
                    title = string.format("%s", icon .. git_dir)
                end
            else
                title = string.format("%s", file_name)
            end
        end

        vim.fn.system({ "wezterm", "cli", "set-tab-title", title })
    end,
})

-- Create a user command to call the function
vim.api.nvim_create_user_command("GitRoot", git_root, {})
vim.api.nvim_set_keymap("n", "<leader>rg", [[:GitRoot<CR>]], { noremap = true, silent = true })
