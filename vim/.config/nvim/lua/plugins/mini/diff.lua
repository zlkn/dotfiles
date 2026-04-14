MiniDeps.now(function()
    local diff = require("mini.diff")
    diff.setup({})

    vim.keymap.set("n", "<Leader>do", function()
        MiniDiff.toggle_overlay()
    end, { desc = "Tooggle diff overlay" })
end)
