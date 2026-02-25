MiniDeps.later(function()
    git = require("mini.git")
    git.setup()

    local ns_id = vim.api.nvim_create_namespace("MyGitBlame")

    local function show_blame_ghost()
        local fname = vim.api.nvim_buf_get_name(0)
        local line = vim.api.nvim_win_get_cursor(0)[1]

        -- Clear previous virtual text
        vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

        -- Run git blame for just this line
        vim.system({ "git", "blame", "-L", line .. "," .. line, "--porcelain", fname }, { text = true }, function(obj)
            if obj.code ~= 0 or not obj.stdout then
                return
            end

            -- Parse the first few lines of porcelain output
            local author = obj.stdout:match("author ([^\n]+)")
            local summary = obj.stdout:match("summary ([^\n]+)")
            local time = obj.stdout:match("author%-time (%d+)")
            local date = os.date("%Y-%m-%d", tonumber(time))

            local text = string.format("  󰊢 %s • %s • %s", author, date, summary)

            -- Update UI on main thread
            vim.schedule(function()
                vim.api.nvim_buf_set_extmark(0, ns_id, line - 1, 0, {
                    virt_text = { { text, "Comment" } },
                    virt_text_pos = "eol",
                    hl_mode = "combine",
                    priority = 10,
                })
            end)
        end)
    end

    vim.keymap.set("n", "<leader>gb", show_blame_ghost, { desc = "Show line blame ghost" })

    vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
            vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
        end,
    })

    vim.api.nvim_create_autocmd("CursorHold", {
        callback = show_blame_ghost,
    })
end)
