MiniDeps.add({
    source = "nvim-treesitter/nvim-treesitter",
    -- Use 'master' while monitoring updates in 'main'
    checkout = "main",
    monitor = "main",
    -- Perform action after every checkout
    hooks = {
        post_checkout = function()
            vim.cmd("TSUpdate")
        end,
    },
})

MiniDeps.later(function()
    local packages = {
        "bash",
        "c",
        "go",
        "gomod",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "terraform",
        "hcl",
        "jinja",
        "jinja_inline",
    }

    require("nvim-treesitter").setup({
        -- Directory to install parsers and queries to
        install_dir = vim.fn.stdpath("data") .. "/site",
    })

    require("nvim-treesitter").install(packages) -- wait max. 5 minutes

    vim.api.nvim_create_autocmd("FileType", {
        pattern = packages,
        callback = function()
            vim.treesitter.start()
        end,
    })
    -- -- Lua function to retrieve the key trail (path) of a YAML node under the cursor using Neovim's Tree-sitter
    -- -- This returns a dot-separated string of keys, e.g. "root.parent.child"
    -- function YamlKeytrail()
    --     local ts = vim.treesitter
    --     local ts_utils = require("nvim-treesitter.ts_utils")
    --     -- Get the current buffer and cursor position
    --     local bufnr = vim.api.nvim_get_current_buf()
    --     local cursor = vim.api.nvim_win_get_cursor(0)
    --     local row, col = cursor[1] - 1, cursor[2]
    --
    --     -- Get the parser for YAML
    --     local parser = ts.get_parser(bufnr, "yaml")
    --     if not parser then
    --         return nil, "No Tree-sitter parser for YAML"
    --     end
    --
    --     -- Get the syntax tree root
    --     local tree = parser:parse()[1]
    --     local root = tree:root()
    --
    --     -- Find the smallest named node at the cursor position
    --     local node = root:named_descendant_for_range(row, col, row, col)
    --     if not node then
    --         return nil, "No YAML node at cursor"
    --     end
    --
    --     -- Utility to check if a node is a key node
    --     local function is_key(node)
    --         return node:type() == "block_mapping_pair" or node:type() == "flow_mapping_pair"
    --     end
    --
    --     -- Traverse up to collect key names
    --     local keys = {}
    --     local curr = node
    --     while curr and curr:type() ~= "document" do
    --         if curr:type():find("_mapping_pair") then
    --             -- child 0 is key node, then its text
    --             local key_node = curr:child(0)
    --             if key_node then
    --                 local text = ts_utils.get_node_text(key_node, bufnr)[1]
    --                 table.insert(keys, 1, text)
    --             end
    --         end
    --         curr = curr:parent()
    --     end
    --
    --     if #keys == 0 then
    --         return nil, "Cursor not inside a YAML mapping"
    --     end
    --
    --     -- Concatenate with dots
    --     local path = table.concat(keys, ".")
    --     return path
    -- end
    -- -- Example usage: print key trail
    -- vim.keymap.set("n", "<leader>yk", function()
    --     local keytrail = YamlKeytrail()
    --     print("Key trail: " .. (keytrail or "nil"))
    -- end)
end)
