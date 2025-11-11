MiniDeps.later(function()
    local animate = require("mini.animate")
    animate.setup({
        cursor = { enable = true },
        -- Disable Scroll Animations, as the can interfer with mouse Scrolling
        scroll = { enable = false },
        -- Disable window animation due blinking background
        open = { enable = false },
        close = { enable = false },
        resize = { enable = false },
    })
end)
