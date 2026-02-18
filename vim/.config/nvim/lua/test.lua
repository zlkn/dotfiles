local ns_id = vim.api.nvim_create_namespace("incsearch_match_counter")

vim.api.nvim_create_autocmd("CmdlineChanged", {
    group = vim.api.nvim_create_augroup("IncSearchCounter", { clear = true }),
    pattern = "[:/\\?]",
    callback = function()
        vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

        local cmd_type = vim.fn.getcmdtype()
        if cmd_type ~= "/" and cmd_type ~= "?" then
            return
        end

        local pattern = vim.fn.getcmdline()
        if #pattern < 1 then
            return
        end

        -- Use pcall because the regex might be incomplete while typing
        local ok, s_count = pcall(vim.fn.searchcount, { recompute = 1, maxcount = 500, timeout = 100 })
        if not ok or s_count.total == 0 then
            return
        end

        local top_line = vim.fn.line("w0")
        local bot_line = vim.fn.line("w$")
        local match_idx = 0

        -- We need to find all matches in the buffer to determine the "index"
        -- of the ones currently visible on screen.
        local curr_pos = { 1, 0 }
        while true do
            -- searchpos returns {line, col}
            local match_pos = vim.fn.searchpos(pattern, "Wz", bot_line)
            if match_pos[1] == 0 or match_pos[1] > bot_line then
                break
            end

            match_idx = match_idx + 1

            -- Only draw if it's within the visible window
            if match_pos[1] >= top_line then
                vim.api.nvim_buf_set_extmark(0, ns_id, match_pos[1] - 1, match_pos[2] - 1, {
                    virt_text = { { string.format(" [%d/%d]", match_idx, s_count.total), "DiagnosticVirtualTextInfo" } },
                    virt_text_pos = "eol", -- Change to 'overlay' if you want it on top of the text
                })
            end

            -- Move cursor forward to find next match
            vim.fn.cursor(match_pos[1], match_pos[2] + 1)
        end

        -- Restore cursor position so the screen doesn't jump
        vim.fn.winrestview({ lnum = vim.fn.line("w0") })
    end,
})

-- Cleanup
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
--     callback = function()
--         vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
--     end,
-- })
