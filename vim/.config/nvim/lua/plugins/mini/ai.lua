MiniDeps.later(function()
    require("mini.ai").setup({
        -- Number of lines within which textobject is searched
        n_lines = 500,

        -- How to search for object (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'prev', 'nearest'.
        search_method = "cover_or_next",
    })
end)
