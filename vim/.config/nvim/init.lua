-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
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

local function srequire(module)
    local status_ok, m = pcall(require, module)
    if not status_ok then
        vim.notify("Unable to load: " .. module, vim.log.levels.ERROR)
        return nil
    end
    return m
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })
require("mini.visits").setup()
require("mini.trailspace").setup()

srequire("filetypes")
srequire("options")
srequire("autocmds")

srequire("keymaps")

srequire("plugins.mini.clue")
srequire("plugins.mini.files")
srequire("plugins.mini.pairs")
srequire("plugins.mini.pick")
srequire("plugins.mini.extra")
srequire("plugins.mini.surround")
srequire("plugins.mini.cursorword")
srequire("plugins.mini.hipatterns")
srequire("plugins.mini.icons")
srequire("plugins.mini.notify")
srequire("plugins.mini.git")
srequire("plugins.mini.diff")

-- Enhance ui
srequire("plugins.indent-blankline")
srequire("plugins.rainbow-delimiter")
srequire("plugins.smart-splits")
srequire("plugins.lualine")
srequire("plugins.flash")

-- git ingegration
-- require("plugins.gitsigns")

-- Syntax highlight
srequire("plugins.nvim-treesitter")
srequire("plugins.nvim-treesitter-context")
srequire("plugins.nvim-treesitter-textobjects")

-- LSP/completion/autoformat/docs
srequire("plugins.nvim-lspconfig")
srequire("plugins.mason")
srequire("plugins.completion")

srequire("plugins.conform")
-- require("plugins.hover")

-- TEST
srequire("plugins.codecompanion")

vim.cmd.colorscheme("aqua")
