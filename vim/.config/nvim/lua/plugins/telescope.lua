return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    opts = function()
        return {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                layout_strategy = "vertical",
                layout_config = {
                    vertical = { width = 0.8, height = 0.9 },
                },
            },
        }
    end,
}
