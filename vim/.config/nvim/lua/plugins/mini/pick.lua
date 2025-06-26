MiniDeps.add("echasnovski/mini.pick")
MiniDeps.later(function()
    require("mini.pick").setup({
        window = { prompt_prefix = " " },
    })
    MiniPick.registry.yaml_keytrail = M.yaml_keytrail

    vim.keymap.set("n", "<leader><leader>", function()
        MiniPick.builtin.files()
    end, { desc = "Files in rootdir" })

    vim.keymap.set("n", "<leader>/", function()
        MiniPick.builtin.grep_live()
    end, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>,", function()
        MiniPick.builtin.buffers()
    end, { desc = "Open buffers" })
    vim.keymap.set("n", "<leader>g/", function()
        MiniPick.builtin.files({ items = { "foo", "bar" } })
    end, { desc = "Changed files " })

    vim.keymap.set("n", "<leader>pgm", ":Pick git_files scope='modified'<CR>", { desc = "Git modified files" })
    vim.keymap.set("n", "<leader>pgh", ":Pick git_hunks", { desc = "Git hunks" })
    vim.keymap.set("n", "<leader>pr", ":Pick resume<CR>", { desc = "Resume last search" })
    vim.keymap.set("n", "<leader>pd", ":Pick diagnostic<CR>", { desc = "Diagnostics" })

    vim.keymap.set("n", "gD", ":Pick lsp scope='declaration'<CR>", { desc = "Goto declaration" })
    vim.keymap.set("n", "gd", ":Pick lsp scope='definition'<CR>", { desc = "Goto definition" })
    vim.keymap.set("n", "gi", ":Pick lsp scope='implementation'<CR>", { desc = "Goto implementation" })
    vim.keymap.set("n", "gR", ":Pick lsp scope='references'<CR>", { desc = "Goto references" })
    vim.keymap.set("n", "gy", ":Pick lsp scope='type_definition'<CR>", { desc = "Goto t[y]pe definition" })

    vim.keymap.set("n", "<leader>pp", ":echo 'Not Implemeted'<CR>", { desc = "Mock for jq over current buffer" })
end)

M = {}
M.yaml_keytrail = function(_, opts)
    local items = require("test").get_all_paths()
    table.sort(items)

    local function choose(item)
        print("Choose item: " .. item)
    end

    local function preview(bufnr, item)
        return nil
    end

    -- 4. Assemble source
    local source = {
        name = "YamlKeytrail",
        items = items,
        choose = choose,
        preview = preview,
    }

    opts = vim.tbl_deep_extend("force", { source = source }, opts or {})
    return MiniPick.start(opts)
end
