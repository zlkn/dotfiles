local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
print("MiniPath: " .. mini_path)
if not vim.loop.fs_stat(mini_path) then
    local clone_cmd = { "git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.deps", mini_path }
    vim.fn.system(clone_cmd)
    vim.cmd('echo "Installed `mini.deps`" | redraw')
end
-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

require("options")
require("autocmds")
require("keymaps")

require("plugins.mini.clue")
require("plugins.mini.files")
require("plugins.mini.pairs")
require("plugins.mini.pick")
require("plugins.mini.extra")
require("plugins.mini.surround")
require("plugins.mini.cursorword")
require("plugins.mini.hipatterns")
require("plugins.mini.icons")
require("plugins.mini.animate")

-- Enhance ui
require("plugins.colorscheme")
require("plugins.indent-blankline")
require("plugins.rainbow-delimiter")
require("plugins.smart-splits")
require("plugins.lualine")
require("plugins.flash")

-- git ingegration
require("plugins.git.gitsigns")

-- Syntax highlight
require("plugins.nvim-treesitter")
require("plugins.nvim-treesitter-context")

-- LSP/completion/autoformat/docs
require("plugins.nvim-lspconfig")
require("plugins.mason")
require("plugins.completion")

require("plugins.conform")
require("plugins.hover")
require("plugins.lazydev")

-- TEST
-- require("plugins.codecompanion")
