local map = vim.keymap.set
-- Enhance buffer scroling
map("n", "<S-Enter>", "<C-d>", { noremap = true, silent = true })
map("n", "<C-Enter>", "<C-u>", { noremap = true, silent = true })

-- Permanent delete without copy in buffer
map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "X", '"_X')

-- Keymaps for run lua code in selection
map("n", "<leader>rx", "<cmd>source %<CR>", { desc = "Execute lua code" })
map("v", "<leader>rx", ":.lua<CR>", { desc = "Execute lua code" })

-- Split window
map("n", "<leader>\\", "<cmd>vsplit<CR>", { desc = "Split vertial" })
map("n", "<leader>-", "<cmd>split<CR>", { desc = "Split horisontal" })

-- Jump
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })
map("n", "H", ":bnext<CR>", { noremap = true, silent = true })
map("n", "L", ":bprev<CR>", { noremap = true, silent = true })

-- Exit
-- Map <leader>qq to exit without saving
map("n", "<leader>qq", ":q!<CR>", { desc = "Exit buffer without saving", noremap = true, silent = true })
map("n", "<leader>qa", ":qa!<CR>", { desc = "Exit nvim without saving", noremap = true, silent = true })

-- Map <leader>wq to save and then exit
map("n", "<leader>wq", ":wq<CR>", { desc = "Save and Exit", noremap = true, silent = true })
map("n", "<leader>ww", ":w<CR>", { desc = "Save and Format", noremap = true, silent = false })

map("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = false })
end)
map("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = false })
end)

-- make < > shifts keep selection
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- somewhere in your init.lua or a helper module:

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

    local relative_path = vim.fn.fnamemodify(filepath, ":.")

    -- Copy to system clipboard
    vim.fn.setreg("+", relative_path)

    -- Optionally notify
    vim.notify("Copied relative path to clipboard: " .. relative_path, vim.log.levels.INFO)
end
map("n", "<leader>cp", CopyRelativePathToClipboard, { desc = "Copy relative path to clipboard" })

-- Toggle current hlsearch
map("n", "<leader>th", function()
    vim.v.hlsearch = vim.v.hlsearch ~= 1
    vim.print((vim.o.hlsearch and vim.v.hlsearch == 1 and "Enable" or "Disable") .. " hlsearch")
end, { desc = "toogle hlsearch" })

-- Toogle inlay_hint
map("n", "<leader>ti", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
    print((vim.lsp.inlay_hint.is_enabled and "Enable" or "Disable") .. " inlay hints")
end, { desc = "tootle inlay hint" })
