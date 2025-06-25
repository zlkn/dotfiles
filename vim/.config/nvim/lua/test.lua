local M = {}

-- Recursively convert Tree-sitter YAML nodes into a flat list of paths
local function collect_paths(node, prefix, paths)
    print("collect_paths")
    local flattened = {}
    for child, count in node:iter_children() do
        local type = child:type()
        if type == "block_mapping" then
            local key_node = child:field("key")[1]
            local key = vim.treesitter.get_node_text(key_node, 0)
            print("blcok_mapping key:" .. key)
            table.insert(flattened, key)
            local new_prefix = #prefix > 0 and (prefix .. "." .. key) or key
            local value_node = child:field("value")[1]
            collect_paths(value_node, new_prefix, paths)
        elseif type == "block_sequence" or type == "flow_sequence" then
            for i, item in ipairs(child:children()) do
                local idx_prefix = prefix .. "[" .. i .. "]"
                collect_paths(item, idx_prefix, paths)
            end
        elseif type == "block_mapping" or type == "flow_mapping" then
            collect_paths(child, prefix, paths)
        elseif type == "string" or type == "number" or type == "true" or type == "false" or type == "null" then
            table.insert(paths, prefix)
        end
    end
end

-- Main entry: returns table of "path:line" entries
function M.get_yaml_paths()
    local bufnr = vim.api.nvim_get_current_buf()
    local parser = vim.treesitter.get_parser(bufnr, "yaml")
    local tree = parser:parse()[1]
    local root = tree:root()
    local paths = {}
    collect_paths(root, "", paths)

    -- attach line numbers
    local items = {}
    for _, path in ipairs(paths) do
        print(path)
    end
    return items
end

-- FZF integration: launch fzf to select a path and jump to its line
function M.search_yaml_paths()
    local items = M.get_yaml_paths()
    if vim.tbl_isempty(items) then
        print("No YAML paths found")
        return
    end
    print("Done")
end

local function get_treesitter_path(ft)
    if not ensure_parser_ready(ft) then
        return nil
    end

    local ok_parser, parser = pcall(vim.treesitter.get_parser, 0, ft)
    if not ok_parser or not parser then
        return nil
    end

    local trees = parser:parse()
    if not trees or not trees[1] then
        return nil
    end

    local tree = trees[1]
    local root = tree:root()
    if not root then
        return nil
    end

    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1] - 1, cursor[2]
    local node = root:named_descendant_for_range(row, col, row, col)
    if not node then
        return nil
    end

    ---@type string[]
    local path = {}
    while node do
        local type = node:type()

        -- Handle both YAML and JSON object properties
        if type == "block_mapping_pair" or type == "flow_mapping_pair" or type == "pair" then
            local key_node = node:field("key")[1]
            if key_node then
                local key = clean_key(vim.treesitter.get_node_text(key_node, 0))
                table.insert(path, 1, key)
            end
            -- Handle both YAML and JSON array items
        elseif type == "block_sequence_item" or type == "flow_sequence_item" or type == "array" then
            local parent = node:parent()
            if parent then
                local index = 0
                for child in parent:iter_children() do
                    if child == node then
                        break
                    end
                    if child:type() == type then
                        index = index + 1
                    end
                end
                table.insert(path, 1, "[" .. index .. "]") -- Format array index with brackets
            end
        end

        node = node:parent()
    end

    if #path == 0 then
        return nil
    end

    -- Join path segments with a beautiful delimiter
    return table.concat(path, config.get().delimiter)
end

return M
