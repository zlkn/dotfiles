MiniDeps.add({ source = 'echasnovski/mini.surround', checkout = 'stable' })
MiniDeps.later(
	function()
		local surround = require('mini.surround')
		surround.setup({
			  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
			  highlight_duration = 500,
		})
	end
)
