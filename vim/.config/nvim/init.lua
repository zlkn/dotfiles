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

local function safely_require(module)
    MiniMisc.safely("now", function()
        require(module)
    end)
end

safely_require("options")
safely_require("autocmds")
safely_require("keymaps")

require("mini.visits").setup()
require("mini.trailspace").setup()
require('mini.indentscope').setup({ symbol = "▏" })

safely_require("plugins.mini.clue")
safely_require("plugins.mini.files")
safely_require("plugins.mini.pairs")
safely_require("plugins.mini.pick")
safely_require("plugins.mini.extra")
safely_require("plugins.mini.surround")
-- safely_require("plugins.mini.ai")
safely_require("plugins.mini.cursorword")
safely_require("plugins.mini.hipatterns")
safely_require("plugins.mini.icons")
safely_require("plugins.mini.notify")
safely_require("plugins.mini.git")
safely_require("plugins.mini.diff")
safely_require("plugins.mini.snippets")

-- Enhance ui
safely_require("plugins.colorscheme")
safely_require("plugins.rainbow-delimiter")
safely_require("plugins.smart-splits")
safely_require("plugins.lualine")
safely_require("plugins.flash")
safely_require("plugins.markview")

-- git ingegration
-- require("plugins.gitsigns")

-- Syntax highlight
safely_require("plugins.nvim-treesitter")
safely_require("plugins.nvim-treesitter-context")

-- LSP/completion/autoformat/docs
safely_require("plugins.nvim-lspconfig")
safely_require("plugins.completion")
safely_require("plugins.brygga")
safely_require("plugins.conform")
-- require("plugins.hover")
