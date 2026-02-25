MiniDeps.now(function()
    local diff = require("mini.diff")
    diff.setup({
        view = {
            style = "sign",
            signs = {
                add = " ▎",
                change = " ▎",
                delete = " ▎",
            },
        },
    })

    vim.keymap.set("n", "<Leader>do", function()
        MiniDiff.toggle_overlay()
    end, { desc = "Tooggle diff overlay" })
end)
