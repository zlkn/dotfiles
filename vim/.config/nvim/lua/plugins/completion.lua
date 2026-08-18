-- NOTE: `now`, not `later`. `lsp_completion.auto_setup` only installs a BufEnter
-- autocmd and doesn't touch the already-entered buffer, so a `later` setup
-- leaves 'completefunc' unset in the first file opened via `nvim <file>`.
MiniDeps.now(function()
    local mc = require("mini.completion")

    local process_items = function(items, base)
        return mc.default_process_items(items, base, {
            filtersort = "fuzzy",
            kind_priority = { Text = -1, Snippet = 99 },
        })
    end

    -- Stand-in for blink's `path` source: complete filesystem paths when the
    -- word being typed contains a separator, otherwise buffer keywords.
    local fallback_action = function()
        local col = vim.fn.col(".") - 1
        local left = vim.api.nvim_get_current_line():sub(1, col)
        local is_path = left:match("[%w%._%-~%$/\\]*[/\\][%w%._%-~%$]*$") ~= nil
        vim.api.nvim_feedkeys(vim.keycode(is_path and "<C-x><C-f>" or "<C-n>"), "n", false)
    end

    mc.setup({
        delay = { completion = 100, info = 500, signature = 50 },
        window = {
            info = { height = 25, width = 80, border = "single" },
            signature = { height = 25, width = 80, border = "single" },
        },
        lsp_completion = { process_items = process_items },
        fallback_action = fallback_action,
    })
end)

-- Keymaps go in `later` on purpose: 'mini.pairs' maps <CR> itself when it
-- registers pairs and is set up from an earlier `later` callback. Mapping <CR>
-- in `now` would get clobbered.
MiniDeps.later(function()
    -- Navigate the popup menu, otherwise insert a literal Tab
    vim.keymap.set("i", "<Tab>", function()
        return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
    end, { expr = true, replace_keycodes = true, desc = "Next completion item" })

    vim.keymap.set("i", "<S-Tab>", function()
        return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
    end, { expr = true, replace_keycodes = true, desc = "Prev completion item" })

    -- Accept the selected item, else fall through to 'mini.pairs' <CR>
    vim.keymap.set("i", "<CR>", function()
        if vim.fn.complete_info({ "selected" }).selected ~= -1 then
            return "<C-y>"
        end
        return _G.MiniPairs and MiniPairs.cr() or "<CR>"
    end, { expr = true, replace_keycodes = true, desc = "Accept completion or pairs <CR>" })
end)
