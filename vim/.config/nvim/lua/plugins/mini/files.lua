MiniDeps.add("echasnovski/mini.files")
MiniDeps.later(function()
    local files = require("mini.files")
    files.setup({
        windows = {
            preview = true,
            width_focus = 50,
            width_preview = 80,
        },
        options = {
            -- Whether to use for editing directories
            -- Disabled by default in LazyVim because neo-tree is used for that
            use_as_default_explorer = true,
        },
    })
    vim.keymap.set("n", "<leader>fm", function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
        MiniFiles.open(path)
        MiniFiles.reveal_cwd()
    end, { desc = "Open MiniFiles" })
    vim.keymap.set("n", "<leader>fM", function()
        require("mini.files").open(vim.uv.cwd())
    end, { desc = "Open MiniFiles in CWD" })
end)
