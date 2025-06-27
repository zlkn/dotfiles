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

vim.api.nvim_set_hl(0, "LspInlayHint", { bg = "red", fg = "blue" })

M = {}
M.yaml_jump_to_node = function(path)
    local ok_parser, parser = pcall(vim.treesitter.get_parser, 0, "yaml")
    if not ok_parser or not parser then
        print("Could not get parser for YAML")
        return nil
    end

    local trees = parser:parse()
    if not trees or not trees[1] then
        print("No trees found")
        return nil
    end

    local tree = trees[1]
    local node = tree:root()
    if not node then
        print("No root node found")
        return nil
    end

    local bufnr = vim.api.nvim_get_current_buf()

    -- iterate each segment in the dotted path
    for part in path:gmatch("[^.]+") do
        local found = nil

        for child in node:iter_children() do
            print("NodeName: " .. vim.treesitter.get_node_text(child, bufnr))
            if child:named() and child then
                local txt = vim.treesitter.get_node_text(child, bufnr)
                if txt == part then
                    found = child
                    break
                end
            end
        end

        if not found then
            vim.notify(("Couldn’t find “%s” under %s"):format(part, node:type()), vim.log.levels.WARN)
            return
        end

        node = found
    end

    print("Find position for Node" .. node)

    local ts_utils = require("nvim-treesitter.ts_utils")
    ts_utils.goto_node(node, true)
end

M.yaml_keytrail = function(_, opts)
    local items = require("test").get_all_paths()
    table.sort(items)

    local function choose(item)
        print("Choose item: " .. item)
        M.yaml_jump_to_node(item)
    end

    local function preview(bufnr, item)
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
