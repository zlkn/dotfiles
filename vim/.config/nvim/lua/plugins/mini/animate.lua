MiniDeps.add("nvim-mini/mini.animate")
MiniDeps.later(function()
    local animate = require("mini.animate")
    animate.setup({
        scroll = {
            -- Disable Scroll Animations, as the can interfer with mouse Scrolling
            enable = false,
        },
        -- Disable window animation due blinking background
        open = { enable = false },
        close = { enable = false },
        resize = { enable = false },

        cursor = {
            timing = animate.gen_timing.cubic({ duration = 200, unit = "total" }),
        },
    })
end)
