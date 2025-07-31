-- Enhance buffer scroling
vim.keymap.set("n", "<S-Enter>", "<C-d>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Enter>", "<C-u>", { noremap = true, silent = true })

-- Keymaps for run lua code in selection
vim.keymap.set("n", "<leader>rx", "<cmd>source %<CR>", { desc = "Execute lua code" })
vim.keymap.set("v", "<leader>rx", ":.lua<CR>", { desc = "Execute lua code" })

-- Split window
vim.keymap.set("n", "<leader>\\", "<cmd>vsplit<CR>", { desc = "Split vertial" })
vim.keymap.set("n", "<leader>-", "<cmd>split<CR>", { desc = "Split horisontal" })

-- Jump
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })
vim.keymap.set("n", "H", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "L", ":bprev<CR>", { noremap = true, silent = true })

-- Exit
-- Map <leader>qq to exit without saving
vim.keymap.set("n", "<leader>qq", ":q!<CR>", { desc = "Exit buffer without saving", noremap = true, silent = true })
vim.keymap.set("n", "<leader>qa", ":qa!<CR>", { desc = "Exit nvim without saving", noremap = true, silent = true })

-- Map <leader>wq to save and then exit
vim.keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "Save and Exit", noremap = true, silent = true })
vim.keymap.set("n", "<leader>ww", ":w<CR><CR>", { desc = "Save and Format", noremap = true, silent = true })

vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = false })
end)
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = false })
end)

-- make < > shifts keep selection
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- somewhere in your init.lua or a helper module:

vim.keymap.set("n", "<leader>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
end)

-- Create a Vim command
-- vim.cmd([[command! YamlCurrentPosition lua print(require('yaml').get_treesitter_path('yaml')) ]])
vim.api.nvim_create_user_command("YamlCurrentPosition", function()
    print(require("yaml").get_treesitter_path("yaml"))
end, {})
-- vim.cmd([[command! YamlGetAllPaths lua print(require('yaml').get_all_paths()) ]])
vim.api.nvim_create_user_command("YamlGetAllPaths", function()
    print(require("yaml").get_all_paths())
end, {})

vim.api.nvim_create_user_command("YamlSchemas", function()
    local clients = vim.lsp.get_active_clients()
    for _, client in ipairs(clients) do
        if client.name == "yamlls" then
            print(vim.inspect(client.config.settings.yaml.schemas))
        end
    end
end, {})

vim.api.nvim_create_user_command("Yaml", function()
    require("yaml").yaml_get_json_schema()
end, {})

function CopyRelativePathToClipboard()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
        vim.notify("No file loaded", vim.log.levels.WARN)
        return
    end

    -- Get the relative path from the current working directory
    local cwd = vim.fn.getcwd()
    local relative_path = vim.fn.fnamemodify(filepath, ":.")

    -- Copy to system clipboard
    vim.fn.setreg("+", relative_path)

    -- Optionally notify
    vim.notify("Copied relative path to clipboard: " .. relative_path, vim.log.levels.INFO)
end
vim.keymap.set("n", "<leader>cp", CopyRelativePathToClipboard, { desc = "Copy relative path to clipboard" })
