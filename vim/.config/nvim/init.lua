-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/nvim-mini/mini.nvim",
        mini_path,
    }
    vim.fn.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

vim.cmd.colorscheme("aqua")

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })
require("mini.visits").setup()
require("filetypes")
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
require("plugins.mini.notify")

-- Enhance ui
require("plugins.indent-blankline")
require("plugins.rainbow-delimiter")
require("plugins.smart-splits")
require("plugins.lualine")
require("plugins.flash")

-- git ingegration
-- require("plugins.gitsigns")
require("mini.diff").setup({ view = { style = "sign", signs = { add = " ▎", change = " ▎", delete = " ▎" } } })
require("mini.git").setup()

-- Syntax highlight
require("plugins.nvim-treesitter")
require("plugins.nvim-treesitter-context")

-- LSP/completion/autoformat/docs
require("plugins.nvim-lspconfig")
require("plugins.mason")
require("plugins.completion")

require("plugins.conform")
-- require("plugins.hover")

-- TEST
require("plugins.codecompanion")
