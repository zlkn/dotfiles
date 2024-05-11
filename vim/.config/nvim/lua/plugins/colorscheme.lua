return {
	{
		"nick-kadutskyi/vim-jb", -- My color theme (forked from devsjs/vim-js)
		lazy = false,
		name = "jb",
		-- dev = true, -- theme is in dev but falls back to my public GitHub repo
		init = function()
			vim.g.jb_enable_italics = 1 -- Enables intalics
			vim.g.jb_style = "light" -- JB defualt light theme
		end,
	},
	{
		"rmehri01/onenord.nvim",
		lazy = false, -- make
		name = "onenord",
		opts = {
			disable = {
				background = true, -- Disable setting the background color
			},
		},
	},
	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		priority = 1000,
		config = function()
			require("github-theme").setup({
			})
		end,
	},
}
