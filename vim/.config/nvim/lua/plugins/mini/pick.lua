MiniDeps.add("echasnovski/mini.pick")
MiniDeps.later(function()
    require("mini.pick").setup({
        window = { prompt_prefix = " " },
    })

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

    vim.keymap.set("n", "<leader>pgm", ":Pick git_files scope='modified'<CR>", { desc = "Find modified files" })
    vim.keymap.set("n", "<leader>pr", ":Pick resume<CR>", { desc = "Resume last search" })
    vim.keymap.set("n", "<leader>pd", ":Pick diagnostic<CR>", { desc = "Diagnostics" })

    vim.keymap.set("n", "gD", ":Pick lsp scope='declaration'<CR>", { desc = "Goto declaration" })
    vim.keymap.set("n", "gd", ":Pick lsp scope='definition'<CR>", { desc = "Goto definition" })
    vim.keymap.set("n", "gi", ":Pick lsp scope='implementation'<CR>", { desc = "Goto implementation" })
    vim.keymap.set("n", "gR", ":Pick lsp scope='references'<CR>", { desc = "Goto references" })
    vim.keymap.set("n", "gy", ":Pick lsp scope='type_definition'<CR>", { desc = "Goto t[y]pe definition" })
end)
