MiniDeps.add({ source = 'echasnovski/mini.icons' })
MiniDeps.later(
function()
	local icons = require('mini.icons')
	icons.setup({})
end
)

