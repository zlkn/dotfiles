-- set background=dark
vim.o.background = none

-- hi clear
vim.cmd("hi clear")

-- let g:colors_name = 'ansi'
vim.g.colors_name = "ansi"

-- set notermguicolors
vim.o.termguicolors = false

-- This color scheme relies on ANSI colors only. It automatically inherits
-- the 16 colors of your terminal color scheme.

-- ANSI Color Palette Mapping (cterm/terminal codes):
-- 0: Black        │   8: Bright Black (dark gray)
-- 1: Red          │   9: Bright Red
-- 2: Green        │  10: Bright Green
-- 3: Yellow       │  11: Bright Yellow
-- 4: Blue         │  12: Bright Blue
-- 5: Magenta      │  13: Bright Magenta
-- 6: Cyan         │  14: Bright Cyan
-- 7: White (gray) │  15: Bright White

local hl = vim.api.nvim_set_hl
local default_opts = {
    fg = -1, -- Default/NONE
    bg = -1, -- Default/NONE
    bold = false,
    italic = false,
    underline = false,
    undercurl = false,
    reverse = false,
}

-- Helper function to set terminal highlights
-- Uses the 'ctermfg', 'ctermbg', and 'cterm' attributes.
local function set_ansi_hl(name, ctermfg, ctermbg, cterm)
    local opts = vim.deepcopy(default_opts)

    -- ctermfg
    if ctermfg ~= nil then
        opts.fg = ctermfg
    end

    -- ctermbg
    if ctermbg ~= nil then
        opts.bg = ctermbg
    end

    -- cterm attributes
    if cterm then
        for attr in string.gmatch(cterm, "[^,]+") do
            attr = string.match(attr, "^%s*(.*%S)%s*$") -- Trim whitespace
            if attr == "bold" then
                opts.bold = true
            elseif attr == "italic" then
                opts.italic = true
            elseif attr == "underline" then
                opts.underline = true
            elseif attr == "reverse" then
                opts.reverse = true
            elseif attr == "undercurl" then
                opts.undercurl = true
            end
        end
    end

    hl(0, name, opts)
end

-- Editor Elements

-- ctermfg=0
set_ansi_hl("NonText", 0)
-- ctermfg=NONE ctermbg=NONE cterm=NONE
set_ansi_hl("Ignore", -1, -1, "NONE")
-- cterm=underline
set_ansi_hl("Underlined", nil, nil, "underline")
-- cterm=bold
set_ansi_hl("Bold", nil, nil, "bold")
-- cterm=italic
set_ansi_hl("Italic", nil, nil, "italic")

-- ctermfg=15 ctermbg=8 cterm=NONE
set_ansi_hl("StatusLine", 15, 8, "NONE")
-- ctermfg=15 ctermbg=0 cterm=NONE
set_ansi_hl("StatusLineNC", 15, 0, "NONE")
-- ctermfg=8
set_ansi_hl("VertSplit", 8)
-- ctermfg=7 ctermbg=0
set_ansi_hl("TabLine", 7, 0)
-- ctermfg=0 ctermbg=NONE
set_ansi_hl("TabLineFill", 0)
-- ctermfg=0 ctermbg=11
set_ansi_hl("TabLineSel", 0, 11)
-- ctermfg=4 cterm=bold
set_ansi_hl("Title", 4, nil, "bold")
-- ctermbg=0 ctermfg=NONE
set_ansi_hl("CursorLine", -1, 0)
-- ctermbg=15 ctermfg=0
set_ansi_hl("Cursor", 0, 15)
-- ctermbg=0
set_ansi_hl("CursorColumn", nil, 0)
-- ctermfg=8
set_ansi_hl("LineNr", 8)
-- ctermfg=6
set_ansi_hl("CursorLineNr", 6)
-- ctermbg=NONE ctermfg=NONE
set_ansi_hl("helpLeadBlank", -1, -1)
-- ctermbg=NONE ctermfg=NONE
set_ansi_hl("helpNormal", -1, -1)
-- ctermbg=8 ctermfg=15 cterm=bold
set_ansi_hl("Visual", 15, 8, "bold")
-- ctermbg=8 ctermfg=15 cterm=bold
set_ansi_hl("VisualNOS", 15, 8, "bold")
-- ctermbg=0 ctermfg=15
set_ansi_hl("Pmenu", 15, 0)
-- ctermbg=8 ctermfg=7
set_ansi_hl("PmenuSbar", 7, 8)
-- ctermbg=8 ctermfg=15 cterm=bold
set_ansi_hl("PmenuSel", 15, 8, "bold")
-- ctermbg=7 ctermfg=NONE
set_ansi_hl("PmenuThumb", -1, 7)
-- ctermfg=7
set_ansi_hl("FoldColumn", 7)
-- ctermfg=12
set_ansi_hl("Folded", 12)
-- ctermbg=0 ctermfg=15 cterm=NONE
set_ansi_hl("WildMenu", 15, 0, "NONE")
-- ctermfg=0
set_ansi_hl("SpecialKey", 0)
-- ctermbg=1 ctermfg=0
set_ansi_hl("IncSearch", 0, 1)
-- ctermbg=3 ctermfg=0
set_ansi_hl("CurSearch", 0, 3)
-- ctermbg=11 ctermfg=0
set_ansi_hl("Search", 0, 11)
-- ctermfg=4
set_ansi_hl("Directory", 4)
-- ctermbg=0 ctermfg=3 cterm=underline
set_ansi_hl("MatchParen", 3, 0, "underline")
-- cterm=undercurl
set_ansi_hl("SpellBad", nil, nil, "undercurl")
-- cterm=undercurl
set_ansi_hl("SpellCap", nil, nil, "undercurl")
-- cterm=undercurl
set_ansi_hl("SpellLocal", nil, nil, "undercurl")
-- cterm=undercurl
set_ansi_hl("SpellRare", nil, nil, "undercurl")
-- ctermbg=8
set_ansi_hl("ColorColumn", nil, 8)
-- ctermfg=7
set_ansi_hl("SignColumn", 7)
-- ctermbg=15 ctermfg=0 cterm=bold
set_ansi_hl("ModeMsg", 0, 15, "bold")
-- ctermfg=4
set_ansi_hl("MoreMsg", 4)
-- ctermfg=4
set_ansi_hl("Question", 4)
-- ctermbg=0 ctermfg=14
set_ansi_hl("QuickFixLine", 14, 0)
-- ctermfg=8
set_ansi_hl("Conceal", 8)
-- ctermbg=0 ctermfg=15
set_ansi_hl("ToolbarLine", 15, 0)
-- ctermbg=8 ctermfg=15
set_ansi_hl("ToolbarButton", 15, 8)
-- ctermfg=7
set_ansi_hl("debugPC", 7)
-- ctermfg=8
set_ansi_hl("debugBreakpoint", 8)
-- ctermfg=1 cterm=bold,italic
set_ansi_hl("ErrorMsg", 1, nil, "bold,italic")
-- ctermfg=11
set_ansi_hl("WarningMsg", 11)

-- Diff Highlighting
-- ctermbg=10 ctermfg=0
set_ansi_hl("DiffAdd", 0, 10)
-- ctermbg=12 ctermfg=0
set_ansi_hl("DiffChange", 0, 12)
-- ctermbg=9 ctermfg=0
set_ansi_hl("DiffDelete", 0, 9)
-- ctermbg=14 ctermfg=0
set_ansi_hl("DiffText", 0, 14)

-- ctermfg=10
set_ansi_hl("diffAdded", 10)
-- ctermfg=9
set_ansi_hl("diffRemoved", 9)
-- ctermfg=12
set_ansi_hl("diffChanged", 12)
-- ctermfg=11
set_ansi_hl("diffOldFile", 11)
-- ctermfg=13
set_ansi_hl("diffNewFile", 13)
-- ctermfg=12
set_ansi_hl("diffFile", 12)
-- ctermfg=7
set_ansi_hl("diffLine", 7)
-- ctermfg=14
set_ansi_hl("diffIndexLine", 14)

-- Health Highlighting
-- ctermfg=1
set_ansi_hl("healthError", 1)
-- ctermfg=2
set_ansi_hl("healthSuccess", 2)
-- ctermfg=3
set_ansi_hl("healthWarning", 3)

-- Syntax Highlighting
-- ctermfg=8 cterm=italic
set_ansi_hl("Comment", 8, nil, "italic")
-- ctermfg=3
set_ansi_hl("Constant", 3)
-- ctermfg=1
set_ansi_hl("Error", 1)
-- ctermfg=9
set_ansi_hl("Identifier", 9)
-- ctermfg=4
set_ansi_hl("Function", 4)
-- ctermfg=13
set_ansi_hl("Special", 13)
-- ctermfg=5
set_ansi_hl("Statement", 5)
-- ctermfg=2
set_ansi_hl("String", 2)
-- ctermfg=6
set_ansi_hl("Operator", 6)
-- ctermfg=3
set_ansi_hl("Boolean", 3)
-- ctermfg=14
set_ansi_hl("Label", 14)
-- ctermfg=5
set_ansi_hl("Keyword", 5)
-- ctermfg=5
set_ansi_hl("Exception", 5)
-- ctermfg=5
set_ansi_hl("Conditional", 5)
-- ctermfg=13
set_ansi_hl("PreProc", 13)
-- ctermfg=5
set_ansi_hl("Include", 5)
-- ctermfg=5
set_ansi_hl("Macro", 5)
-- ctermfg=11
set_ansi_hl("StorageClass", 11)
-- ctermfg=11
set_ansi_hl("Structure", 11)
-- ctermfg=0 ctermbg=9 cterm=bold
set_ansi_hl("Todo", 0, 9, "bold")
-- ctermfg=11
set_ansi_hl("Type", 11)

-- neovim-specific
-- ctermbg=0 ctermfg=15
set_ansi_hl("NormalFloat", 15, 0)
-- ctermbg=0 ctermfg=7
set_ansi_hl("FloatBorder", 7, 0)
-- ctermbg=0 ctermfg=15
set_ansi_hl("FloatShadow", 15, 0)

-- Treesitter highlighting: Only available for nvim >0.5.
-- This uses the same ANSI color mapping (0-15) as the previous conversion.

local hl = vim.api.nvim_set_hl

-- Helper function to set terminal highlights for Treesitter groups
-- cterm attributes are mapped to Neovim's 'force' attributes.
local function set_treesitter_hl(name, ctermfg, ctermbg, cterm)
    local opts = {
        fg = ctermfg ~= nil and ctermfg or -1,
        bg = ctermbg ~= nil and ctermbg or -1,
    }

    -- Handle cterm attributes (bold, italic, underline, etc.)
    if cterm then
        for attr in string.gmatch(cterm, "[^,]+") do
            attr = string.match(attr, "^%s*(.*%S)%s*$") -- Trim whitespace
            if attr == "bold" then
                opts.bold = true
            elseif attr == "italic" then
                opts.italic = true
            elseif attr == "underline" then
                opts.underline = true
            elseif attr == "strikethrough" then
                opts.strikethrough = true
            elseif attr == "reverse" then
                opts.reverse = true
            end
        end
    end

    hl(0, name, opts)
end

---
--- ## 🎨 Treesitter Highlight Definitions

-- ctermfg=15
set_treesitter_hl("@variable", 15)
-- ctermfg=1
set_treesitter_hl("@variable.builtin", 1)
-- ctermfg=1
set_treesitter_hl("@variable.parameter", 1)
-- ctermfg=1
set_treesitter_hl("@variable.member", 1)
-- ctermfg=5
set_treesitter_hl("@constant.builtin", 5)
-- ctermfg=1
set_treesitter_hl("@string.regexp", 1)
-- ctermfg=6
set_treesitter_hl("@string.escape", 6)
-- ctermfg=4 cterm=underline
set_treesitter_hl("@string.special.url", 4, nil, "underline")
-- ctermfg=13
set_treesitter_hl("@string.special.symbol", 13)
-- ctermfg=3
set_treesitter_hl("@type.builtin", 3)
-- ctermfg=1
set_treesitter_hl("@property", 1)
-- ctermfg=5
set_treesitter_hl("@function.builtin", 5)
-- ctermfg=11
set_treesitter_hl("@constructor", 11)
-- ctermfg=1
set_treesitter_hl("@keyword.coroutine", 1)
-- ctermfg=5
set_treesitter_hl("@keyword.function", 5)
-- ctermfg=5
set_treesitter_hl("@keyword.return", 5)
-- ctermfg=14
set_treesitter_hl("@keyword.export", 14)
-- ctermfg=15
set_treesitter_hl("@punctuation.bracket", 15)

-- Comment Tones
-- ctermbg=9 ctermfg=0
set_treesitter_hl("@comment.error", 0, 9)
-- ctermbg=11 ctermfg=0
set_treesitter_hl("@comment.warning", 0, 11)
-- ctermbg=12 ctermfg=0
set_treesitter_hl("@comment.todo", 0, 12)
-- ctermbg=14 ctermfg=0
set_treesitter_hl("@comment.note", 0, 14)

-- Markup (e.g., Markdown)
-- ctermfg=15
set_treesitter_hl("@markup", 15)
-- ctermfg=15 cterm=bold
set_treesitter_hl("@markup.strong", 15, nil, "bold")
-- ctermfg=15 cterm=italic
set_treesitter_hl("@markup.italic", 15, nil, "italic")
-- ctermfg=15 cterm=strikethrough
set_treesitter_hl("@markup.strikethrough", 15, nil, "strikethrough")
-- ctermfg=4 cterm=bold
set_treesitter_hl("@markup.heading", 4, nil, "bold")
-- ctermfg=6
set_treesitter_hl("@markup.quote", 6)
-- ctermfg=4
set_treesitter_hl("@markup.math", 4)
-- ctermfg=5 cterm=underline
set_treesitter_hl("@markup.link.url", 5, nil, "underline")
-- ctermfg=14
set_treesitter_hl("@markup.raw", 14)
-- ctermfg=2
set_treesitter_hl("@markup.list.checked", 2)
-- ctermfg=7
set_treesitter_hl("@markup.list.unchecked", 7)

-- Tags (e.g., HTML/XML)
-- ctermfg=5
set_treesitter_hl("@tag", 5)
-- ctermfg=6
set_treesitter_hl("@tag.builtin", 6)
-- ctermfg=4
set_treesitter_hl("@tag.attribute", 4)
-- ctermfg=15
set_treesitter_hl("@tag.delimiter", 15)

---
-- ## 🔗 Treesitter Linking

-- The 'link' commands map Treesitter groups to existing Vim/Neovim highlight groups.
-- This ensures they inherit styles defined in the previous section or Neovim defaults.

local function link_ts_hl(from_group, to_group)
    hl(0, from_group, { link = to_group })
end

link_ts_hl("@variable.parameter.builtin", "@variable.parameter")
link_ts_hl("@constant", "Constant")
link_ts_hl("@constant.macro", "Macro")
link_ts_hl("@module", "Structure")
link_ts_hl("@module.builtin", "Special")
link_ts_hl("@label", "Label")
link_ts_hl("@string", "String")
link_ts_hl("@string.special", "Special")
link_ts_hl("@character", "Character")
link_ts_hl("@character.special", "SpecialChar")
link_ts_hl("@boolean", "Boolean")
link_ts_hl("@number", "Number")
link_ts_hl("@number.float", "Float")
link_ts_hl("@type", "Type")
link_ts_hl("@type.definition", "Type")
link_ts_hl("@attribute", "Constant")
link_ts_hl("@attribute.builtin", "Constant")
link_ts_hl("@function", "Function")
link_ts_hl("@function.call", "Function")
link_ts_hl("@function.method", "Function")
link_ts_hl("@function.method.call", "Function")
link_ts_hl("@operator", "Operator")
link_ts_hl("@keyword", "Keyword")
link_ts_hl("@keyword.operator", "Operator")
link_ts_hl("@keyword.import", "Include")
link_ts_hl("@keyword.type", "Keyword")
link_ts_hl("@keyword.modifier", "Keyword")
link_ts_hl("@keyword.repeat", "Repeat")
link_ts_hl("@keyword.debug", "Exception")
link_ts_hl("@keyword.exception", "Exception")
link_ts_hl("@keyword.conditional", "Conditional")
link_ts_hl("@keyword.conditional.ternary", "Operator")
link_ts_hl("@keyword.directive", "PreProc")
link_ts_hl("@keyword.directive.define", "Define")
link_ts_hl("@punctuation.delimiter", "Delimiter")
link_ts_hl("@punctuation.special", "Special")
link_ts_hl("@comment", "Comment")
link_ts_hl("@comment.documentation", "Comment")
link_ts_hl("@markup.underline", "underline")
link_ts_hl("@markup.link", "Tag")
link_ts_hl("@markup.link.label", "Label")
link_ts_hl("@markup.list", "Special")
link_ts_hl("@diff.plus", "diffAdded")
link_ts_hl("@diff.minus", "diffRemoved")
link_ts_hl("@diff.delta", "diffChanged")
