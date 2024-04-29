return {
	{
		"nick-kadutskyi/vim-jb", -- My color theme (forked from devsjs/vim-js)
		name = "jb",
		-- dev = true, -- theme is in dev but falls back to my public GitHub repo
		init = function()
			vim.g.jb_enable_italics = 1 -- Enables intalics
			vim.g.jb_style = "light" -- JB defualt light theme
		end,
	},
	{
		"rmehri01/onenord.nvim",
		name = "onenord",
		opts = {
			disable = {
				background = true, -- Disable setting the background color
			},
		},
	},
}
