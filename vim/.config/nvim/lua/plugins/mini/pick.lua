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

    vim.keymap.set("n", "<leader>py", ":Pick yaml_keytrail<CR>", { desc = "Fzf over yaml file" })
end)

M = {}

-- Jump to a given row:col in buf_id, in the window that triggered the picker
M.yaml_jump_to_node = function(buf_id, path)
    local sr, sc = path:match("^(%d+):(%d+)|")
    local row, col = tonumber(sr), tonumber(sc) - 1 -- col is 0-based

    -- get the window that launched the picker
    local state = MiniPick.get_picker_state()
    local win = state.windows.target
    if win == nil or vim.api.nvim_win_get_buf(win) ~= buf_id then
        vim.api.nvim_err_writeln("Target window not showing buffer " .. buf_id)
        return
    end

    -- focus and set cursor there
    vim.api.nvim_set_current_win(win)
    vim.api.nvim_win_set_cursor(win, { row, col })
end

M.yaml_keytrail = function(_, opts)
    local items = require("yaml").get_all_paths()
    local buf_id = vim.api.nvim_get_current_buf()
    table.sort(items)

    local function choose(item)
        M.yaml_jump_to_node(buf_id, item)
    end

    local function preview(buf_id, item)
        return nil
    end

    local source = {
        name = "YamlKeytrail",
        items = items,
        choose = choose,
        preview = preview,
    }

    opts = vim.tbl_deep_extend("force", { source = source }, opts or {})
    return MiniPick.start(opts)
end
