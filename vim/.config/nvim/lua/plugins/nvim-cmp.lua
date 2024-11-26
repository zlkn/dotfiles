return {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
        local cmp_window = require("cmp.config.window")
        opts.window = {
            completion = cmp_window.bordered(),
            documentation = cmp_window.bordered(),
        }
    end,
}
