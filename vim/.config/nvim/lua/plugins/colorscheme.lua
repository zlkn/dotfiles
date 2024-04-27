return {
	{
		"rmehri01/onenord.nvim",
		lazy = true,
		name = "onenord",
		opts = {
		    theme ="light"
		},
        disable = {
          background = true, -- Disable setting the background color
          }
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "onenord",
		},
	},
}
