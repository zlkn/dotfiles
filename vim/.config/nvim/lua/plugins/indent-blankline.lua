MiniDeps.add("lukas-reineke/indent-blankline.nvim")
MiniDeps.later(
	function()
		require("ibl").setup({
		    indent = {
			char = "▏",
			tab_char = "▏",
		    },
		    scope = {
			enabled = true,
			show_start = false,
			show_end = false,
		    },
		    whitespace = {
			remove_blankline_trail = true,
		    },
		    exclude = {
			filetypes = {
			    "NvimTree",
			    "Trouble",
			    "dashboard",
			    "git",
			    "help",
			    "markdown",
			    "notify",
			    "packer",
			    "sagahover",
			    "terminal",
			    "undotree",
			},
			buftypes = { "terminal", "nofile", "prompt", "quickfix" },
		    },
		})
	end
)
