local M = {}

local delimiter = "."

-- Helper: extract key from node text
---@param key string
local function clean_key(key)
    return key:gsub("^[\"']", ""):gsub("[\"']$", "")
end

function M.get_treesitter_path(ft)
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
    return table.concat(path, ".")
end

---Get all possible paths in the current document
---@return table paths Array of paths
function M.get_all_paths()
    local ft = vim.bo.filetype
    local ok_parser, parser = pcall(vim.treesitter.get_parser, 0, ft)
    if not ok_parser or not parser then
        return {}
    end

    local trees = parser:parse()
    if not trees or not trees[1] then
        return {}
    end

    local tree = trees[1]
    local root = tree:root()
    if not root then
        return {}
    end

    local function add_position(sr, sc, path)
        return tonumber(sr) + 1 .. ":" .. tonumber(sc) + 1 .. "|" .. path
    end

    local paths = {}

    local function traverse_node(node, current_path)
        local type = node:type()

        -- Handle YAML document structure
        if ft == "yaml" then
            if type == "stream" or type == "document" or type == "block_node" then
                for child in node:iter_children() do
                    traverse_node(child, current_path)
                end
                return
            end
        end

        -- Handle JSON structure
        if ft == "json" then
            if type == "program" or type == "document" or type == "object" then
                for child in node:iter_children() do
                    traverse_node(child, current_path)
                end
                return
            end

            if type == "array" then
                local index = 0
                for child in node:iter_children() do
                    if child:type() == "array_element" then
                        local sr, sc, _, _ = node:range()
                        local new_path = current_path .. "[" .. index .. "]"
                        table.insert(paths, add_position(sr, sc, new_path))
                        traverse_node(child, new_path)
                        index = index + 1
                    end
                end
                return
            end
        end

        -- Handle object properties
        if type == "pair" or type == "block_mapping_pair" or type == "flow_mapping_pair" then
            local key_node = node:field("key")[1]
            if key_node then
                local key = clean_key(vim.treesitter.get_node_text(key_node, 0))
                local sr, sc, _, _ = node:range()
                local new_path = current_path .. (current_path ~= "" and delimiter or "") .. key
                table.insert(paths, add_position(sr, sc, new_path))

                -- Traverse value node
                local value_node = node:field("value")[1]
                if value_node then
                    traverse_node(value_node, new_path)
                end
            end
            -- Handle array items
        elseif type == "block_sequence_item" or type == "flow_sequence_item" then
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
                local sr, sc, _, _ = node:range()
                local new_path = current_path .. "[" .. index .. "]"
                table.insert(paths, add_position(sr, sc, new_path))

                -- Traverse array item content
                for child in node:iter_children() do
                    traverse_node(child, new_path)
                end
            end
            -- Handle block mappings and sequences
        elseif type == "block_mapping" or type == "flow_mapping" or type == "block_sequence" or type == "flow_sequence" then
            for child in node:iter_children() do
                traverse_node(child, current_path)
            end
        end
    end

    traverse_node(root, "")

    return paths
end

M.yaml_get_json_schema = function()
    local uri = vim.uri_from_bufnr(0)
    vim.lsp.buf_request(0, "yaml/get/jsonSchema", uri, function(err, schemas)
        if err then
            vim.notify("Error fetching schemas: " .. err.message, vim.log.levels.ERROR)
            return false
        end
        if not schemas or vim.tbl_isempty(schemas) then
            vim.notify("No schemas in use for this document", vim.log.levels.INFO)
            return false
        end
        for _, s in ipairs(schemas) do
            vim.notify(string.format("Schema: %s (%s)", s.uri, s.name or "no name"), vim.log.levels.INFO)
        end
        return true
    end)
end

return M
