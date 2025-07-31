local M = {}

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
