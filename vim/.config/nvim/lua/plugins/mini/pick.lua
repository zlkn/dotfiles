MiniDeps.later(function()
    require("mini.pick").setup({
        window = {
            prompt_prefix = " ",
            config = function()
                local max_width = vim.o.columns
                local width = max_width

                if max_width > 160 then
                    width = math.floor(max_width * 0.618)
                elseif max_width > 120 then
                    width = 120
                end

                return { width = width, border = "rounded" }
            end,
        },
    })
    MiniPick.registry.yaml_keytrail = M.yaml_keytrail

    local map = vim.keymap.set
    local registry = MiniPick.registry

    map("n", "<leader><leader>", registry.files, { desc = "Files in rootdir" })
    map("n", "<leader>/", registry.grep_live, { desc = "Live grep" })
    map("n", "<leader>,", registry.buffers, { desc = "Open buffers" })
    map("n", "<leader>pg", registry.files, { desc = "Changed files " })

    -- vim.keymap.set("n", "<leader>pgh", ":Pick git_hunks", { desc = "Git hunks" })
    map("n", "<leader>pgh", registry.git_hunks, { desc = "Git hunks" })
    map("n", "<leader>pr", registry.resume, { desc = "Resume last search" })
    map("n", "<leader>pd", ":Pick diagnostic<CR>", { desc = "Diagnostics" })

    map("n", "gD", ":Pick lsp scope='declaration'<CR>", { desc = "Goto declaration" })
    map("n", "gd", ":Pick lsp scope='definition'<CR>", { desc = "Goto definition" })
    map("n", "gi", ":Pick lsp scope='implementation'<CR>", { desc = "Goto implementation" })
    map("n", "gR", ":Pick lsp scope='references'<CR>", { desc = "Goto references" })
    map("n", "gy", ":Pick lsp scope='type_definition'<CR>", { desc = "Goto t[y]pe definition" })

    map("n", "<leader>py", ":Pick yaml_keytrail<CR>", { desc = "Fzf over yaml file" })
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
