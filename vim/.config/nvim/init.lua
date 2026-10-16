vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local data = ev.data
        if data.spec.name == "nvim-treesitter" and (data.kind == "install" or data.kind == "update") then
            if not data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            require("nvim-treesitter").update()
        end
    end,
})

vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })
require("mini.misc").setup()

local function srequire(module)
    local status_ok, m = pcall(require, module)
    if not status_ok then
        vim.notify("Unable to load: " .. module, vim.log.levels.ERROR)
        return nil
    end
    return m
end

srequire("options")
srequire("autocmds")
srequire("keymaps")

require("mini.visits").setup()
require("mini.trailspace").setup()
require('mini.indentscope').setup({ symbol = "▏" })

srequire("plugins.mini.clue")
srequire("plugins.mini.files")
srequire("plugins.mini.pairs")
srequire("plugins.mini.pick")
srequire("plugins.mini.extra")
srequire("plugins.mini.surround")
-- srequire("plugins.mini.ai")
srequire("plugins.mini.cursorword")
srequire("plugins.mini.hipatterns")
srequire("plugins.mini.icons")
srequire("plugins.mini.notify")
srequire("plugins.mini.git")
srequire("plugins.mini.diff")
srequire("plugins.mini.snippets")

-- Enhance ui
srequire("plugins.colorscheme")
srequire("plugins.rainbow-delimiter")
srequire("plugins.smart-splits")
srequire("plugins.lualine")
srequire("plugins.flash")
srequire("plugins.markview")

-- git ingegration
-- require("plugins.gitsigns")

-- Syntax highlight
srequire("plugins.nvim-treesitter")
srequire("plugins.nvim-treesitter-context")

-- LSP/completion/autoformat/docs
srequire("plugins.nvim-lspconfig")
srequire("plugins.completion")
srequire("plugins.brygga")
srequire("plugins.conform")
-- require("plugins.hover")
