MiniDeps.add("nvim-mini/mini.notify")
MiniDeps.later(function()
    require("mini.notify").setup()
end)
